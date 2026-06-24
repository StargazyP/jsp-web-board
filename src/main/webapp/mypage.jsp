<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/includes/head.jspf" %>
<title>My Page · JSP Drawing</title>
</head>
<body>
<%
    String userID = null;
    User user = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
        UserDAO userDAO = new UserDAO();
        user = userDAO.getUserInfo(userID);
    }
%>

<nav class="navbar navbar-expand-lg app-navbar">
    <div class="container-fluid">
        <button type="button" class="navbar-toggler"
            data-bs-toggle="collapse"
            data-bs-target="#bs-example-navbar-collapse-1"
            aria-controls="bs-example-navbar-collapse-1"
            aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <a class="navbar-brand" href="index.jsp">JSP Drawing</a>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="main.jsp">Main</a></li>
                <li class="nav-item"><a class="nav-link" href="bbs.jsp">Board</a></li>
                <li class="nav-item"><a class="nav-link" href="chat.jsp">Chat</a></li>
            </ul>
            <% if (userID == null) { %>
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                            role="button" data-bs-toggle="dropdown"
                            aria-expanded="false">Account</a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="login.jsp">Login</a></li>
                            <li><a class="dropdown-item" href="register.jsp">Sign up</a></li>
                        </ul>
                    </li>
                </ul>
            <% } else { %>
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownUser"
                            role="button" data-bs-toggle="dropdown"
                            aria-expanded="false"><%= userID %></a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownUser">
                            <li><a class="dropdown-item" href="mypage.jsp">My page</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="logoutAction.jsp">Logout</a></li>
                        </ul>
                    </li>
                </ul>
            <% } %>
        </div>
    </div>
</nav>

<div class="container app-container">
    <h1 class="page-title">User Information</h1>
    <div class="board-panel">
        <table class="table table-board mb-0">
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Gender</th>
                </tr>
            </thead>
            <tbody>
                <% if (user != null) { %>
                <tr>
                    <td><%= user.getUserID() %></td>
                    <td><%= user.getUserName() %></td>
                    <td><%= user.getUserEmail() %></td>
                    <td><%= user.getUserGender() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
