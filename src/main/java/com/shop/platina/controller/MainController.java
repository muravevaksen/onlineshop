package com.shop.platina.controller;

import com.shop.platina.ClassPathTldsLoader;
import com.shop.platina.domain.Product;
import com.shop.platina.domain.User;
import com.shop.platina.repos.ProductRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@Controller
public class MainController {

    @Autowired
    private ProductRepo productRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/")
    public String main(Map <String, Object> model) {
        Iterable<Product> products = productRepo.findAll();
        model.put("products", products);
        return "main";
    }

    @PostMapping("/")
    public String add(
            @AuthenticationPrincipal User user,
            @RequestParam String productName,
            @RequestParam String tag, Map<String, Object> model,
            @RequestParam Double price,
            @RequestParam("file") MultipartFile file
    ) throws IOException {
        Product product = new Product(productName, tag, price);

        if (file != null){
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()){
                uploadDir.mkdir();
            }

            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + file.getOriginalFilename();

            file.transferTo(new File(uploadPath + "/" + resultFilename));

            product.setFilename(resultFilename);
        }

        productRepo.save(product);
        Iterable<Product> products = productRepo.findAll();
        model.put("products", products);
        return "main";
    }

    @Bean
    @ConditionalOnMissingBean(ClassPathTldsLoader.class)
    public ClassPathTldsLoader classPathTldsLoader(){
        return new ClassPathTldsLoader();
    }

}