<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/includes/head.jspf" %>
<title>Edit · JSP Drawing</title>
</head>
<body>
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	if(session.getAttribute("userID") == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('PLEASE LOGIN');");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}
	int bbsID = 0;
	if(request.getParameter("bbsID") != null){
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if(bbsID == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('NULL');");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
	
	Bbs bbs = new BbsDAO().getBbs(bbsID);
	
	if(!userID.equals(bbs.getUserID())){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('NO PERMISSION');");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
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
        </div>
    </div>
</nav>

<div class="container app-container">
    <h1 class="page-title">Edit Post</h1>
    <div class="board-panel">
        <div class="board-panel-header">Rewrite</div>
        <form method="post" action="updateAction.jsp?bbsID=<%= bbsID %>" class="p-3 p-md-4">
            <div class="mb-3">
                <input type="text" class="form-control" placeholder="Title" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle() %>" required>
            </div>
            <div class="mb-3">
                <textarea class="form-control" placeholder="Content" name="bbsContent" maxlength="2048" required><%= bbs.getBbsContent() %></textarea>
            </div>
            <div class="btn-actions btn-actions-end">
                <a href="view.jsp?bbsID=<%= bbsID %>" class="btn btn-outline-secondary">Cancel</a>
                <input type="submit" class="btn btn-primary" value="Save">
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
