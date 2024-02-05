<%-- 
    Document   : register
    Created on : 3 Feb 2024, 15:11:34
    Author     : Dell
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/fontAndColors.css" />
    <link rel="stylesheet" href="css/formStyle.css" />

    <title>Register Now!</title>
  </head>
  <body>
    <%--<%@include file="components/nav.jsp"%>--%>
    <form method="post" id="register-form" action="./Register">

      <div class="formheader">
        <h1>JOIN US!</h1>
        <h5>Create Your Account</h5>
        <p class="error"><%@include file="components/message.jsp" %></p>
      </div>
      <div class="text-container">
        <label for="user_name">Full Name:</label>
        <small id="name-error" class="error"></small>
        <br />
        <input type="text" id="user_name" name="user_name" />
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
      <div class="text-container">
        <label for="password2">Confirm Password: </label>
        <small id="password2-error" class="error"></small><br />
        <input type="password" id="password2" name="password2" />
      </div>
      <div class="text-container">
        <label for="user_phone">Phone Number: </label
        ><small id="number-error" class="error">Error</small><br />
        <input type="text" id="phone" name="user_phone" />
      </div>
      <div class="text-container">
        <label for="user_address">Address:</label
        ><small id="address-error" class="error"></small><br />
        <textarea id="address" name="user_address"></textarea>
      </div>
      <div class="submitBtn">
        <button type="submit">Register Now</button>
      </div>
      <div class="register-href-div">
        <label>Already have an account? </label><br />
        <a href="login.jsp" id="register-href">Login Here</a>
      </div>
    </form>
  </body>
</html>
