<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Home Page</title>
</head>
<body>

<h2 align="center">List of <b>Categories</b></h2>
<h4 align="center"><a href="Categoriesform.jsp">Add New Category</a></h4>
<table align="center">

   <tr>
       <th>ID</th>
       <th>Name</th>
   </tr>
   
   <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
       url="jdbc:mysql://localhost:3306/assessment2?serverTimezone=Australia/Melbourne"
       user="root" password="Kimsourl123" />
   <sql:query dataSource="${snapshot}" var="result">
       SELECT id, name FROM categories
   </sql:query>
   
   <c:forEach items="${result.rows}" var="categories">
       <tr>
           <td><c:out value="${categories.id}" /></td>
           <td><c:out value="${categories.name}" /></td>
           <td>| 
               <a href="${pageContext.request.contextPath}/CategoriesServlet?action=edit&id=<c:out value='${categories.id}' />">Edit</a> | 
               <a href="${pageContext.request.contextPath}/CategoriesServlet?action=delete&id=<c:out value='${categories.id}' />">Delete</a> |
           </td>
       </tr>
   </c:forEach>
</table>

</body>
</html>