<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Header</title>
    <style>
        .search-bar {
            display: flex;
            justify-content: flex-end;
            padding: 10px;
        }
    </style>
</head>
<body>
    <!-- Search bar container -->
    <div class="search-bar">
        <form action="SpeciesServlet" method="GET">
            <input type="hidden" name="action" value="search" />
            <input type="text" name="search" placeholder="Search species..." />
            <input type="submit" value="Search" />
        </form>
    </div>
</body>
</html>
