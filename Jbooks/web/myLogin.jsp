<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <c:if test="${not empty badLogin}">
            <font color=red>${badLogin}</font>
        </c:if>        
        <jsp:include page="header.jsp"/>
    </head>
    <body>
        <h1>Online Book Registration</h1>
        <form action="Validator" method="POST">
            <table border="0">
                <tr>
                    <td>Username: </td>
                    <td colspan="2"><input type="text" name="username"></td>
                </tr>
                <tr>
                    <td>Password: </td>
                    <td colspan="2"><input type="password" name="password"></td>
                </tr>
                <tr>
                    <td>Status: </td>
                    <td><input type="radio" name="usertype" value="staff" checked>Staff</td>
                    <td><input type="radio" name="usertype" value="student">Student</td>
                </tr>    
                <tr>
                    <td><input type="submit" value="Login"/></td>
                </tr>                
            </table>
        </form>
    </body>
</html>
