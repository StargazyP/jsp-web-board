<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String mode = request.getParameter("mode");
    if (mode == null) mode = "signin";
    boolean isSignup = "signup".equals(mode);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/includes/head.jspf" %>
<title><%= isSignup ? "회원가입" : "로그인" %> · JSP Drawing</title>
</head>
<body class="auth-page">

<p class="tip">JSP Drawing — Real-time chat &amp; collaborative canvas</p>

<div class="cont<%= isSignup ? " s--signup" : "" %>" id="authCont">
    <div class="form sign-in">
        <h2>Welcome</h2>
        <form method="post" action="loginAction.jsp">
            <label>
                <span>ID</span>
                <input type="text" name="userID" maxlength="20" required autocomplete="username">
            </label>
            <label>
                <span>Password</span>
                <input type="password" name="userPw" maxlength="20" required autocomplete="current-password">
            </label>
            <button type="submit" class="submit">Sign In</button>
        </form>
    </div>

    <div class="sub-cont">
        <div class="img">
            <div class="img__text m--up">
                <h2>New here?</h2>
                <p>Sign up and discover a great amount of new opportunities!</p>
            </div>
            <div class="img__text m--in">
                <h2>One of us?</h2>
                <p>If you already have an account, just sign in. We've missed you!</p>
            </div>
            <div class="img__btn">
                <span class="m--up">
                    <button type="button" class="btn" id="btnSignUp">Sign Up</button>
                </span>
                <span class="m--in">
                    <button type="button" class="btn" id="btnSignIn">Sign In</button>
                </span>
            </div>
        </div>

        <div class="form sign-up">
            <h2>Sign Up</h2>
            <form method="post" action="registerAction.jsp">
                <label>
                    <span>ID</span>
                    <input type="text" name="userID" maxlength="20" required autocomplete="username">
                </label>
                <label>
                    <span>Password</span>
                    <input type="password" name="userPw" maxlength="20" required autocomplete="new-password">
                </label>
                <label>
                    <span>Name</span>
                    <input type="text" name="userName" maxlength="20" required>
                </label>
                <label class="gender-label">
                    <span>Gender</span>
                    <div class="gender-row">
                        <label class="gender-opt"><input type="radio" name="userGender" value="male" checked> Male</label>
                        <label class="gender-opt"><input type="radio" name="userGender" value="female"> Female</label>
                    </div>
                </label>
                <label>
                    <span>Email</span>
                    <input type="email" name="userEmail" maxlength="50" required autocomplete="email">
                </label>
                <button type="submit" class="submit">Register</button>
            </form>
        </div>
    </div>
</div>

<p class="auth-back"><a href="main.jsp">← Back to Main</a></p>

<script>
(function () {
    var cont = document.getElementById('authCont');
    var btnSignUp = document.getElementById('btnSignUp');
    var btnSignIn = document.getElementById('btnSignIn');

    if (btnSignUp) {
        btnSignUp.addEventListener('click', function () {
            cont.classList.add('s--signup');
            history.replaceState(null, '', 'register.jsp');
        });
    }
    if (btnSignIn) {
        btnSignIn.addEventListener('click', function () {
            cont.classList.remove('s--signup');
            history.replaceState(null, '', 'login.jsp');
        });
    }
})();
</script>
</body>
</html>
