<%-- 
    Document   : success
    Created on : 14 Mar 2024, 06:21:44
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  String search = request.getParameter("id");
  
%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Success</title>
  </head>
  <body>
  <script>
    window.alert("Payment Successfull");
    window.location.replace("./dashboard.jsp");
  </script>
  </body>
</html>
