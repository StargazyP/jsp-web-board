<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/includes/head.jspf" %>
<title>Chat · JSP Drawing</title>
</head>
<body>

<%
String userID = null;
if (session.getAttribute("userID") == null) {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('PLEASE LOGIN');");
    script.println("location.href = 'login.jsp'");
    script.println("</script>");
}
if (session.getAttribute("userID") != null) {
    userID = (String) session.getAttribute("userID");
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
                <li class="nav-item"><a class="nav-link active" href="chat.jsp">Chat</a></li>
            </ul>
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

<div class="container-fluid app-container-wide chat-layout">
    <div class="row g-4">
        <div class="col-lg-7">
            <div class="chat-canvas-wrap">
                <canvas id="myCanvas"></canvas>
            </div>
        </div>
        <div class="col-lg-5">
            <div class="chat-card">
                <div class="card-header">
                    <h4 class="card-title">Real-time Chat</h4>
                </div>
                <div id="chat-content"></div>
                <div class="chat-publisher">
                    <input id="message" type="text" class="form-control" placeholder="Type a message" onkeydown="if(event.key==='Enter') sendMessage();">
                    <div class="btn-row">
                        <button onclick="sendMessage();" class="btn btn-primary">Send</button>
                        <button onclick="clearCanvas();" class="btn btn-danger">Clear Canvas</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var wsUrl = (location.protocol === 'https:' ? 'wss:' : 'ws:') + '//' + location.host + '${pageContext.request.contextPath}/websocketendpoint';
    var webSocket = new WebSocket(wsUrl);
    var echoText = document.getElementById("chat-content");
    var messageInput = document.getElementById("message");
    var loggedInUserId = "<%= session.getAttribute("userID") %>";

    webSocket.onopen = function(event){ wsOpen(event); };
    webSocket.onmessage = function(event){ wsGetMessage(event); };
    webSocket.onclose = function(event){ wsClose(event); };
    webSocket.onerror = function(event){ wsError(event); };

    function wsOpen(event){
        echoText.innerHTML += "Connected ... <br>";
    }

    function sendMessage() {
        var message = messageInput.value;
        if (message.trim() !== "") {
            var chatMessage = JSON.stringify({ type: 'chat', user: loggedInUserId, text: message });
            webSocket.send(chatMessage);
            messageInput.value = "";
        }
    }

    function wsGetMessage(event){
        var data = JSON.parse(event.data);
        if (data.type === 'chat') {
            echoText.innerHTML += data.user + ": " + data.text + "<br>";
        } else if (data.type === 'draw') {
            drawFromMessage(data);
        } else if (data.type === 'clear') {
            clearCanvasLocal();
        }
    }

    function wsClose(event){
        echoText.innerHTML += "Disconnected ... <br>";
    }

    function wsError(event){
        echoText.innerHTML += "Error ... <br>";
    }

    function drawFromMessage(data) {
        ctx.beginPath();
        ctx.moveTo(data.x, data.y);
        ctx.lineTo(data.newX, data.newY);
        ctx.strokeStyle = "#375582"; 
        ctx.lineWidth = 2; 
        ctx.stroke();
    }

    function clearCanvasLocal() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        drawGrid();
    }

    function clearCanvas() {
        clearCanvasLocal();
        var clearMessage = JSON.stringify({ type: 'clear' });
        webSocket.send(clearMessage);
    }

    function drawGrid() {
        for (let x = 0; x < canvas.width; x += gridSize) {
            ctx.beginPath();
            ctx.moveTo(x, 0);
            ctx.lineTo(x, canvas.height);
            ctx.strokeStyle = "#e2e8f0";
            ctx.stroke();
        }
        for (let y = 0; y < canvas.height; y += gridSize) {
            ctx.beginPath();
            ctx.moveTo(0, y);
            ctx.lineTo(canvas.width, y);
            ctx.strokeStyle = "#e2e8f0";
            ctx.stroke();
        }
    }

    const canvas = document.getElementById("myCanvas");
    const ctx = canvas.getContext("2d");
    const gridSize = 20;
    let isDrawing = false;
    let lastX = 0;
    let lastY = 0;

    canvas.width = canvas.offsetWidth;
    canvas.height = canvas.offsetHeight;

    drawGrid();

    canvas.addEventListener("mousedown", (e) => {
        isDrawing = true;
        lastX = e.clientX - canvas.getBoundingClientRect().left;
        lastY = e.clientY - canvas.getBoundingClientRect().top;
    });

    canvas.addEventListener("mousemove", (e) => {
        if (!isDrawing) return;

        const x = e.clientX - canvas.getBoundingClientRect().left;
        const y = e.clientY - canvas.getBoundingClientRect().top;

        ctx.beginPath();
        ctx.moveTo(lastX, lastY);
        ctx.lineTo(x, y);
        ctx.strokeStyle = "#375582";
        ctx.lineWidth = 2;
        ctx.stroke();

        const drawMessage = JSON.stringify({ type: 'draw', x: lastX, y: lastY, newX: x, newY: y });
        webSocket.send(drawMessage);

        lastX = x;
        lastY = y;
    });

    canvas.addEventListener("mouseup", () => {
        isDrawing = false;
    });

    canvas.addEventListener("mouseleave", () => {
        isDrawing = false;
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
