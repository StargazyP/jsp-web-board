<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/includes/head.jspf" %>
<title>View · JSP Drawing</title>
</head>
<body>
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	int bbsID = 0;
	if(request.getParameter("bbsID") != null){
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if(bbsID == 0){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('Please login.');");
        script.println("location.href = 'bbs.jsp';");
        script.println("</script>");
	}
	Bbs bbs = new BbsDAO().getBbs(bbsID);
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
    <div class="board-panel">
        <div class="board-panel-header"><%= bbs.getBbsTitle() %></div>
        <table class="table table-board mb-0">
            <tbody>
                <tr>
                    <td class="label-cell">Writer</td>
                    <td class="text-left"><%= bbs.getUserID() %></td>
                </tr>
                <tr>
                    <td class="label-cell">Date</td>
                    <td class="text-left"><%= bbs.getBbsDate().substring(0,11) + bbs.getBbsDate().substring(11,13) + " : " + bbs.getBbsDate().substring(14,16) %></td>
                </tr>
                <tr>
                    <td class="label-cell">Content</td>
                    <td class="text-left"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="btn-actions">
        <a href="bbs.jsp" class="btn btn-outline-secondary">List</a>
        <% if (userID != null && userID.equals(bbs.getUserID())) { %>
            <a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">Edit</a>
            <a href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-danger">Delete</a>
        <% } %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
