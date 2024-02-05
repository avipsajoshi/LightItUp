<%-- 
    Document   : login
    Created on : 4 Feb 2024, 10:26:29
    Author     : Dell
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/fontAndColors.css" />
    <link rel="stylesheet" href="css/formStyle.css" />

    <title>Login</title>
  </head>
  <body>
    <%@include file="components/nav.jsp"%>
    <form method="post" id="login-form" action="./LoginServlet">

      <div class="formheader">
        <h3>Welcome Back!</h3>
        <h4>Start Browsing</h4>
        <p class="invalid"><%@include file="components/message.jsp" %></p>
      </div>
      <div class="text-container">
        <label for="user_email">Email:</label>
        <small id="email-error" class="error"></small>
        <br />
        <input type="email" id="email" name="user_email" />
      </div>
      <div class="text-container">
        <label for="user_password">Password: </label>
        <small id="password-error" class="error"></small><br />
        <input type="password" id="password" name="user_password" />
      </div>
      <div class="submitBtn">
        <button type="submit" id="submitButton">Login</button>
      </div>
      <div class="register-href-div">
        <label>New Here? </label><br />
        <a href="register.jsp" id="register-href">Register Now</a>
      </div>
    </form>
    <script src="js/loginSignupValidation.js"></script>

  </body>
</html>

