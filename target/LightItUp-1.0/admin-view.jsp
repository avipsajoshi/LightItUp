<%-- 
    Document   : admin-view
    Created on : 11 Mar 2024, 16:04:23
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.lightitup.entities.User" %>
<%@page import="com.lightitup.entities.Product" %>
<%@page import="com.lightitup.entities.Category" %>
<%@page import="com.lightitup.entities.OrderTable" %>
<%@page import="com.lightitup.helper.FactoryProvider" %>
<%@page import="com.lightitup.dao.CategoryDao" %>
<%@page import="com.lightitup.dao.UserDao" %>
<%@page import="com.lightitup.dao.ProductDao" %>
<%@page import="com.lightitup.dao.OrderDao" %>
<%@page import="java.util.List" %>
<% 
  User user =(User)session.getAttribute("logged_user");
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
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Light It Up</title>
  </head>
  <body>
    <%
      String view = request.getParameter("view");
      if(view == null){
        response.sendRedirect("admin.jsp");
      }
      else if(view.trim().equals("users")){
        UserDao udao =new UserDao(FactoryProvider.getFactory());
        List<User> allCustomerUsers = udao.getUserByType("customer");
        List<User> allAdminUsers = udao.getUserByType("admin");
    %>
    
    <%
      }
      else if(view.trim().equals("orders")){
        OrderDao odao =new OrderDao(FactoryProvider.getFactory());
        List<OrderTable> allOrdersCompleted = odao.getOrdersByStatus("completed");
        List<OrderTable> allOrdersPending = odao.getOrdersByStatus("pending");
    %>
    
    <%
      }
      else if(view.trim().equals("categories")){
        CategoryDao cdao =new CategoryDao(FactoryProvider.getFactory());
        List<Category> allCategories = cdao.getAllCategory();
    %>
    
    <%
      }
      else if(view.trim().equals("products")){
        ProductDao pdao =new ProductDao(FactoryProvider.getFactory());
        List<Product> allProducts = pdao.getAllProducts();
      }
    %>
    
    <%
      else{
        session.setAttribute("message", "Error");
        response.sendRedirect("admin.jsp");
      }
    %>
   
  </body>
</html>
