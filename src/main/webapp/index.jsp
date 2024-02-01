<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.lightitup.helper.FactoryProvider" %>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Dashboard</title>
    <%@include file="components/common_css_js.jsp" %>
    
  </head>
  <body>
    <h1>Hello World!</h1>
    <h1>Creating Session factory object</h1>
    <h1>Creating Session factory object</h1>
    <h1>Creating Session factory object</h1>
    <h1>Creating Session factory object</h1>
    
    <% 
      out.println(FactoryProvider.getFactory());
    %>
  </body>
</html>