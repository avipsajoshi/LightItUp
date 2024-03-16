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
//  String order_id = (String)session.getAttribute("orderId");
//    int total = 100;
    String order_id= "123aauu4";
    
%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Proceed With Payment</title>
    <style>
      #paymentForm{
        margin:50px;
      }
     </style>
     <script src="https://khalti.s3.ap-south-1.amazonaws.com/KPG/dist/2020.12.17.0.0.0/khalti-checkout.iffe.js"></script>
  </head>
  <body>
    <%@include file="components/nav.jsp"%>
    <link rel="stylesheet" href="css/displaybody.css" />
    <link rel="stylesheet" href="css/cardStyle.css" />
    <%@include file="components/message.jsp"%>
    <form id="paymentForm" method="post" action="./Initiate">
      <h3>Your Total Amount: </h3>
      <input type="text" value="<%=total/100%>" readonly/>
      <input type="text" name="amount" id="amount" value="<%=total%>" hidden/>
      <input type="hidden" name="purchase_order_id" value="<%=order_id%>" />
      <input type="hidden" name="username" value="<%=cuser.getUserName()%>" />
      <input type="hidden" name="userEmail" value="<%=cuser.getUserEmail()%>" />
      <input type="hidden" name="userPhone" value="<%=cuser.getUserPhone()%>" />
      <input type="hidden" name="return_url" id="amount_field" value="http://localhost:9080/LightItUp/VerifyServlet" />
<!--      <button onclick="paymentStart()">PAY WITH KHALTI</button>-->
      <button type="submit">PAY WITH KHALTI</button>
    </form>
      <script src="js/khaltiIntegration.js"></script>
  </body>
  
  
</html>
