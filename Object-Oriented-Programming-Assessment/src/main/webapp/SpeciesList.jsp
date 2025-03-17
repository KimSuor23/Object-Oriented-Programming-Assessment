<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Species List</title>
    <style>
        .species-table {
            margin-top: 20px;
        }
    </style>
</head>
<body style="font-family: arial, serif;">
    <%@ include file="header.jsp" %>
    
<h3><a href="Home.jsp">Home</a>   <a href="Species.jsp">Species</a>   <a href="Categories.jsp">Categories</a>   <a href="Login.jsp">Admin</a></h3>

    <div align="center" class="species-table">
        <table>
            <h2>List of Species</h2>

            <center>
                <h4><a href="${pageContext.request.contextPath}/SpeciesServlet?action=new">Add New Species</a></h4>
            </center>

            <tr align=center>
                <th>ID</th>
                <th>Title</th>
                <th>Category ID</th>
                <th>Created Date</th>
                <th>Content</th>
                <th>Is Hidden</th>
                <th>Actions</th>
            </tr>

            <!-- Display species list -->
            <c:forEach var="spe" items="${listSpecies}">
                <tr align=center>
                    <td><c:out value="${spe.getId()}" /></td>
                    <td><c:out value="${spe.getTitle()}" /></td>
                    <td><c:out value="${spe.getCategoryId()}" /></td>
                    <td><c:out value="${spe.getCreatedDate()}" /></td>
                    <td><c:out value="${spe.getContent()}" /></td>
                    <td><c:out value="${spe.isHidden()}" /></td>
                    <td>
                        | <a href="${pageContext.request.contextPath}/SpeciesServlet?action=edit&id=${spe.id}">Edit</a> |
                        | <a href="${pageContext.request.contextPath}/SpeciesServlet?action=delete&id=${spe.id}">Delete</a> |
                        | <a href="${pageContext.request.contextPath}/SpeciesServlet?action=toggleHide&id=${spe.id}">
                            ${spe.isHidden() ? 'Unhide' : 'Hide'}
                          </a> |
                    </td>
                </tr>
            </c:forEach>

            
            <c:if test="${empty listSpecies}">
                <tr>
                    <td colspan="7">No species found.</td>
                </tr>
            </c:if>

        </table>
    </div>
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
