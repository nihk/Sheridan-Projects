<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Database Search</title>
        <jsp:include page="header.jsp"/>
    </head>
    <body>
        <h1>Search Results:</h1>
        <%-- If no results were found, don't print the table --%>
        <c:choose>
            <c:when test="${not empty noResults}">
                <p>${noResults}</p>                
            </c:when>    
            <c:otherwise> 
                <table border="1" cellpadding="5">
                    <tr>
                        <c:forEach var="column" items="${columnNames}">
                            <th>${column}</th>
                        </c:forEach>
                    </tr>        
                    <c:forEach var="book" items="${bookRecords}">
                        <tr>
                            <td>${book.bookId}</td>
                            <td>${book.title}</td>
                            <td>${book.author}</td>
                        </tr>
                    </c:forEach>                       
                </table>                
            </c:otherwise>           
        </c:choose>     
    </body>
</html>
