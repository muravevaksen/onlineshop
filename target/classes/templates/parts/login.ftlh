<#assign  security=JspTaglibs["http://www.springframework.org/security/tags"] />

<#macro login path isRegisterForm>
    <form action="${path}" method="post">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Логин:</label>
            <div class="col-sm-5">
                <input type="text" name="username" class="form-control" placeholder="Логин"/>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Пароль:</label>
            <div class="col-sm-5">
                <input type="password" name="password" class="form-control" placeholder="Пароль"/>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <div class="navbar-text col-sm-10">
        <button class="btn btn-primary" type="submit"><#if isRegisterForm>Зарегистрироваться<#else>Войти</#if></button>
        </div>
    </form>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <@security.authorize access="isAuthenticated()">
        <button class="btn btn-primary" type="submit">Выйти</button>
        </@security.authorize>
    </form>
</#macro>