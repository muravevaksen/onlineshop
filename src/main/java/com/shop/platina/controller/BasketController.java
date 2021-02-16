package com.shop.platina.controller;

import com.shop.platina.domain.Product;
import com.shop.platina.repos.ProductRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Map;

@Controller
public class BasketController {

    @Autowired
    private ProductRepo productRepo;

    @GetMapping("/basket")
    public String basket(Map<String, Object> model) {
        Iterable<Product> products = productRepo.findAll();
        model.put("products", products);
        return "basket";
    }

}
