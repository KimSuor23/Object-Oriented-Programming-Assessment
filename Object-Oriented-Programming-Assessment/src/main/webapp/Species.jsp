<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Species Page</title>
</head>
<body>
<h3><a href="Home.jsp">Home</a>   <a href="Species.jsp">Species</a>   <a href="Categories.jsp">Categories</a>   <a href="Login.jsp">Admin</a></h3>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
        url="jdbc:mysql://localhost:3306/assessment2?serverTimezone=Australia/Melbourne"
        user="root" password="Kimsourl123" />

        <sql:query dataSource="${snapshot}" var="result">
SELECT title, content FROM species WHERE is_hidden= false ORDER BY created_date DESC LIMIT 3;
    </sql:query>
        <c:forEach items="${result.rows}" var="row">
   <b> <a href="individualSpecies.jsp?title=${row.title}"><c:out value="${row.title}" /></a></b>
    <c:out value="${row.content}"/>
    <br>
    <br>
    </c:forEach>
    
</body>
</html>