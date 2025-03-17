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
<title>Categories Register</title>
</head>
<body>
<h3><a href="Home.jsp">Home</a>   <a href="Species.jsp">Species</a>   <a href="Categories.jsp">Categories</a>   <a href="Login.jsp">Admin</a></h3>

	<center>
		<h4>
			<a href="CategoriesList.jsp">List</a>
		</h4>
	</center>
	<div align="center">
		<c:if test="${species != null}">
			<form action="${pageContext.request.contextPath}/CategoriesServlet" method="post">
			<input type="hidden" name="action" value="update">
		</c:if>
		<c:if test="${species == null}">
			<form action="${pageContext.request.contextPath}/CategoriesServlet?action=insert" method="post">


		</c:if>
		<table>
			<caption>
				<h2>
					<c:if test="${categories != null}"> Edit Category </c:if>
					<c:if test="${categories == null}"> Add New Category</c:if>
				</h2>
			</caption>
			<c:if test="${species != null}">
				<input type="hidden" name="id"
					value="<c:out value='${Categories.getId()}' />" />
			</c:if>
			<tr>
				<th>name:</th>
				<td><input type="text" name="Title" size="45" required
					value="<c:out value='${Categories.getTitle()}' />" /></td>
			</tr>
			
			<tr>
				<td colspan="2" align="center"><input type="submit"
					value="Save" /></td>
			</tr>
		</table>
	</div>
</body>
</html>