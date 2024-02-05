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
    <%  
      
      user = session.getAttribute("logged_user");
      if(user == null){
        out.println("Error during login");
        session.removeAttribute("logged_user");
      }
      else{
        int logged = 1;
      }
      
    %>
    <div >
      <%  (logged) -> logged==1? out.println("Login Successful!");
        //if (logged == 1){out.println("Login Successful!");}
      %>
    </div>
  </body>
</html>