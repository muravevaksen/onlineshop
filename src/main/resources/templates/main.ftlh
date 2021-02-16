<#import "parts/common.ftlh" as c>
<#include "parts/security.ftlh">

<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />

<@c.page>

    <#if isAdmin>
        <div class="navbar-text mr-3">
            Добавление товара
            <form method="post" enctype="multipart/form-data">
                <input type="text" name="productName" placeholder="Товар">
                <input type="text" name="tag" placeholder="Категория товара">
                <input type="text" name="price" placeholder="Цена">
                <input type="file" name="file">
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <button class="btn btn-primary" type="submit">Добавить</button>
            </form>
        </div>
    </#if>

    <#list products as product>
        <div>
            <div>
                <#if product.filename??>
                    <img src="/img/${product.filename}">
                </#if>
            </div>
            <span>${product.productName}</span>
            <b><br>${product.price}</b>
            <@security.authorize access="isAuthenticated()">
                <form><input class="btn btn-primary" type="submit" value="Добавить в корзину"></form>
            </@security.authorize>
        </div>
    <#else>
        Нет продуктов
    </#list>

</@c.page>