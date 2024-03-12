<%-- 
    Document   : checkout
    Created on : 10 Mar 2024, 03:08:37
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  User cuser =(User)session.getAttribute("logged_user");
  if(cuser == null){
    session.setAttribute("message", "You are not logged in! Please login first. ");
    response.sendRedirect("login.jsp");
    return;
  }
  else{
     if(cuser.getUserType().equals("admin")){
      session.setAttribute("message", "You donot have access to this page.");
      response.sendRedirect("login.jsp");
      return;
    }
  }
  double total = (double)session.getAttribute("total");
    
%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Proceed With Payment</title>
  </head>
  <body>
    <%@include file="components/nav.jsp"%>
    <link rel="stylesheet" href="css/displaybody.css" />
    <link rel="stylesheet" href="css/cardStyle.css" />
    <%@include file="components/message.jsp"%>
    <%=total%>
  </body>
</html>
