<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Validate User</title>
</head>
<body>
	<%-- JDBC driver name and database URL STEP 2: Register JDBC driver --%>
	<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://localhost:3306/EMP?serverTimezone=Australia/Melbourne"
		user="root" password="Kimsourl123" />
	<%-- Getting Request parameters --%>
	<c:set var="uname" scope="session" value="${param.uname}" />
	<c:set var="psw" scope="session" value="${param.psw}" />
	<%-- STEP 3: Open a connection
         STEP 4: Execute a query --%>
	    <sql:query dataSource="${snapshot}" var="result">
         select count(*) as kount from users where uname = ? and psw = MD5(?)
        <sql:param value="${uname}" />
		<sql:param value="${psw}" />
	</sql:query>
	<%-- STEP 5: Extract data from result set --%>
	<c:forEach items="${result.rows}" var="r">
		<c:choose>
			<c:when test="${r.kount > 0}">
				<c:out value="User exists. Welcome!" />
				<c:redirect url="SpeciesServlet?action=list"/>
			</c:when>
			<c:otherwise>
				<c:out value="Password or username incorret"/>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<br>
	<a href="Login.jsp">Back</a>
</body>
</html>