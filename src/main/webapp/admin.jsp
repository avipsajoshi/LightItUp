<%-- 
    Document   : admin
    Created on : 5 Feb 2024, 14:40:08
    Author     : Dell
--%>


<%
    User user =(User) session.getAttribute("logged_user");
  if(user == null){
    session.setAttribute("message", "You are not logged in! Please login first. ");
    response.sendRedirect("login.jsp");
    return;
  }
  else{
     if(user.getUserType().equals("customer")){
      session.setAttribute("message", "You donot have access to this page.");
      response.sendRedirect("login.jsp");
      return;
    }
  }

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin Panel</title>
    <link rel="stylesheet" href="css/fontAndColors.css" />
  </head>
  <body>
    <%@include file="components/nav.jsp"%>
    <h1>admin panel</h1>
  </body>
</html>
