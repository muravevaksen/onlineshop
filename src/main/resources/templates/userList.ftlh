<#import "parts/common.ftlh" as c>

<@c.page>
    Список пользователей
    <table>
        <thread>
            <tr>
                <th>Логин</th>
                <th>Роль</th>
                <th></th>
            </tr>
        </thread>
        <tbody>
        <#list users as user>
            <tr>
                <td>${user.username}</td>
                <td><#list user.roles as role>${role}<#sep>, </#list></td>
                <td><a href="/user/${user.id}">Редактировать</a></td>
            </tr>
        </#list>
        </tbody>
    </table>
</@c.page>