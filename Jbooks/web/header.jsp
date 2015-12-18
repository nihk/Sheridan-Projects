<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<p>Sheridan College</p>
<jsp:useBean id="now" class="java.util.Date"/>    
<fmt:formatDate value="${now}" pattern="E MMM d HH:mm:ss z y"/>        

