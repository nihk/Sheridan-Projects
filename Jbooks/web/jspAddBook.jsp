<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book Registration Confirmation</title>
        <jsp:include page="header.jsp"/>
    </head>
    <body>
        <h1>The book shown below has been registered.</h1>
        <p><b>Title:</b> ${book.title}</p>
        <p><b>Author:</b> ${book.author}</p>
    </body>
</html>
