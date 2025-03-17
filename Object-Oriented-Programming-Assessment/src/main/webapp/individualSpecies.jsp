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
<title>Insert title here</title>
</head>
<body>


<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
        url="jdbc:mysql://localhost:3306/assessment2?serverTimezone=Australia/Melbourne"
        user="root" password="Kimsourl123" />
    <c:set var="title" scope="session" value="${param.title}" />

    <sql:query dataSource="${snapshot}" var="result">
SELECT title, created_date, category_id, content FROM species where title= ?
 <sql:param value="${title}" />
    </sql:query>

    <c:forEach items="${result.rows}" var="rows">
        <h2><b><c:out value="${rows.title}" /></b></h2>
        <h3><b>Created:</b> <c:out value="${rows.created_date}" /></h3>

        <h3><b>Category ID:</b> <c:out value="${rows.category_id}" /></h3>

        <c:out value="${rows.content}" />
    </c:forEach>
    
    <a href="Home.jsp">back</a>
</body>
</html>