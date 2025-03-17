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
    <title>Register Page</title>
</head>
<body>

    <!-- Registration Form -->
    <form action="Register.jsp" method="post">
        <p>
            <label for="uname"><b>Username</b></label>
            <input type="text" placeholder="Enter Username" name="uname" required>
        </p>
        <p>
            <label for="psw"><b>Password</b></label>
            <input type="password" placeholder="Enter Password" name="psw" required>
        </p>
        <button type="submit">Register</button>
    </form>
    
     <br>
    <a href="Login.jsp">Back to Login Page</a>

    <!-- Only process if the form is submitted -->
    <c:if test="${not empty param.uname}">
    
        <%-- JDBC Data Source --%>
        <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
            url="jdbc:mysql://localhost:3306/EMP?serverTimezone=Australia/Melbourne"
            user="root" password="Kimsourl123" />

        <%-- Check if username already exists --%>
        <sql:query dataSource="${snapshot}" var="result">
            SELECT COUNT(*) AS kount FROM users WHERE uname = ?
            <sql:param value="${param.uname}" />
        </sql:query>

        <%-- Handle registration logic --%>
        <c:forEach items="${result.rows}" var="r">
            <c:choose>
                <c:when test="${r.kount > 0}">
                    <c:out value="Username already exists. Please choose another username." />
                    <br>
                    <a href="Register.jsp">Back to Registration</a>
                    <br>
                    <a href="Login.jsp">Go to Login Page</a>
                </c:when>
                <c:otherwise>
                    <sql:update dataSource="${snapshot}">
                        INSERT INTO users (uname, psw) VALUES (?, MD5(?))
                        <sql:param value="${param.uname}" />
                        <sql:param value="${param.psw}" />
                    </sql:update>
                    <c:out value="Registration successful! You can now login." />
                    <br>
                    <a href="Login.jsp">Go to Login</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </c:if>
    
</body>
</html>
