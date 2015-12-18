<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Book</title>
        <c:if test="${not empty badBookId}">
            <font color=red>${badBookId}</font>
        </c:if>           
        <jsp:include page="header.jsp"/>
    </head>
    <body>
        <h1>Adding a new Book</h1>
        <form action="AddBook" method="POST">
            <table border="0">
                <tr>
                    <td>Book ID: </td>
                    <td><input type="text" name="bookid"></td>
                </tr>
                <tr>
                    <td>Title: </td>
                    <td><input type="text" name="title"></td>
                </tr>
                <tr>
                    <td>Author: </td>
                    <td><input type="text" name="author"></td>
                </tr>    
                <tr>
                    <td><input type="submit" value="Add the Book"/></td>
                </tr>                
            </table>
        </form>
    </body>
</html>
