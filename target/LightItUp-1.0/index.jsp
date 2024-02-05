<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.lightitup.helper.FactoryProvider" %>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Dashboard</title>
    <link rel="icon" type="image/png" href="images/l_img.png" />

  </head>
  <body>
    <%@include file="components/nav.jsp"%>
    <h2>Creating Session factory object <% 
      out.println(FactoryProvider.getFactory());
    %></h2>
    <div >
      
    </div>
  </body>
</html>