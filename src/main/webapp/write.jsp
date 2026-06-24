<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/includes/head.jspf" %>
<title>Write · JSP Drawing</title>
</head>
<body>
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
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
                <li class="nav-item"><a class="nav-link active" href="bbs.jsp">Board</a></li>
            </ul>
            <% if(userID == null) { %>
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
                        <li><a class="dropdown-item" href="logoutAction.jsp">Logout</a></li>
                    </ul>
                </li>
            </ul>
            <% } %>
        </div>
    </div>
</nav>

<div class="container app-container">
    <h1 class="page-title">New Post</h1>
    <div class="board-panel">
        <div class="board-panel-header">Write Post</div>
        <form method="post" action="writeAction.jsp" class="p-3 p-md-4">
            <div class="mb-3">
                <input type="text" class="form-control" placeholder="Title" name="bbsTitle" maxlength="50" required>
            </div>
            <div class="mb-3">
                <textarea class="form-control" placeholder="Content" name="bbsContent" maxlength="2048" required></textarea>
            </div>
            <div class="btn-actions btn-actions-end">
                <a href="bbs.jsp" class="btn btn-outline-secondary">Cancel</a>
                <input type="submit" class="btn btn-primary" value="Submit">
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
