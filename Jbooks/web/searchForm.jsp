<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Database Search Form</title>
        <jsp:include page="header.jsp"/>
    </head>
    <body>
        <h1>Please enter book title and/or author to be searched</h1>
        <form action="Search" method="POST">
            <table border="0">
                <tr>
                    <td>Title: </td>
                    <td><input type="text" name="title"></td>
                </tr>
                <tr>
                    <td>Author: </td>
                    <td><input type="text" name="author"></td>
                </tr>    
                <tr>
                    <td><input type="submit" value="Search"/></td>
                </tr>                
            </table>
        </form>       
    </body>
</html>
