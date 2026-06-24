<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/includes/head.jspf" %>
<title>Board · JSP Drawing</title>
</head>
<body>
<%
	String userID = null;
	if(session.getAttribute("userID") == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('PLEASE LOGIN');");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	int pageNumber = 1;
	if(request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
                <li class="nav-item"><a class="nav-link" href="chat.jsp">Chat</a></li>
            </ul>
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
        </div>
    </div>
</nav>

<div class="container app-container">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="page-title mb-0">My Board</h1>
        <a href="write.jsp" class="btn btn-primary">Write</a>
    </div>
    <div class="board-panel">
        <table class="table table-board table-hover mb-0">
            <thead>
                <tr>
                    <th style="width: 10%">No.</th>
                    <th>Title</th>
                    <th style="width: 18%">Writer</th>
                    <th style="width: 22%">Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    BbsDAO bbsDAO = new BbsDAO();
                    ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
                    for(int i = 0; i < list.size(); i++){
                %>
                <tr>
                    <td><%= list.get(i).getBbsID() %></td>
                    <td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
                    <td><%= list.get(i).getUserID() %></td>
                    <td><%= list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11,13) + " : " + list.get(i).getBbsDate().substring(14,16) %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
