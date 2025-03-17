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
<title>Species Register</title>
</head>
<body>
<h3><a href="Home.jsp">Home</a>   <a href="Species.jsp">Species</a>   <a href="Categories.jsp">Categories</a>   <a href="Login.jsp">Admin</a></h3>

	<center>
		<h4>
			<a href="SpeciesList.jsp">List</a>
		</h4>
	</center>
	<div align="center">
		<c:if test="${species != null}">
			<form action="${pageContext.request.contextPath}/SpeciesServlet" method="post">
			<input type="hidden" name="action" value="update">
		</c:if>
		<c:if test="${species == null}">
			<form action="${pageContext.request.contextPath}/SpeciesServlet?action=insert" method="post">


		</c:if>
		<table>
			<caption>
				<h2>
					<c:if test="${species != null}"> Edit Species </c:if>
					<c:if test="${species == null}"> Add New Species </c:if>
				</h2>
			</caption>
			<c:if test="${species != null}">
				<input type="hidden" name="id"
					value="<c:out value='${species.getId()}' />" />
			</c:if>
			<tr>
				<th>Title:</th>
				<td><input type="text" name="Title" size="45" required
					value="<c:out value='${species.getTitle()}' />" /></td>
			</tr>
			<tr>
				<th>Category ID:</th>
				<td><input type="number" name="CategoryID" min="1" max="3" required
					value="<c:out value='${species.getCategoryId()}' />" /></td>
			</tr>
			<tr>
				<th>Created Date:</th>
				<td><input type="date" name="CreatedDate" required
					value="<c:out value='${species.getCreatedDate()}' />" /></td>
			</tr>
			<tr>
				<th>Content:</th>
				<td><input type="text" name="Content" required
					value="<c:out value='${species.getContent()}' />" /></td>
			</tr>
			<tr>
				<th>is hidden?</th> 
				<td> <select name="is_hidden" required value="<c:out value='${species.isHidden()}' />">
					<option value="True">True </option>
					<option value="False">False </option>
					</select>
					</td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit"
					value="Save" /></td>
			</tr>
		</table>
	</div>
</body>
</html>