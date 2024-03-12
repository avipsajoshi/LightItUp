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
<%@page import="java.util.ArrayList" %>
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
    <style>
      table{
        border-bottom: 1px solid gray;
        border-left: none;
        border-right: none;
        border-top:none;
        padding: 10px;
        margin-top: 55px;
      }
      th,td{
        padding: 15px;
        border-bottom: 1px solid gray;
      }
      a, a:visited{
        text-decoration: none;
        color: black;
      }
    </style>
  </head>
  <body>
    <%@include file="components/nav.jsp"%>

    <br>
    <br>
    <br>
  <center>
    <table>
      <%
        String view = request.getParameter("view");
        if(view == null){
          response.sendRedirect("admin.jsp");
        }else if(view.trim().equals("users")){
          String type = request.getParameter("type");
          UserDao udao =new UserDao(FactoryProvider.getFactory());
          List<User> allUsers = udao.getUserByType(type);
      %>
      <h3>Customers</h3>
      <a href="./admin-view.jsp?view=users&type=admin">Admins</a>
      <hr>
      <tr>
        <th>Name</th>
        <th>Phone</th>
        <th>Address</th>
      </tr>
      <%for(User au : allUsers){%>
      <tr>
        <td><%=au.getUserName()%></td>
        <td><%=au.getUserPhone()%></td>
        <td><%=au.getUserAddress()%></td>
      </tr>
      <%}%>
      <%
        }
        else if(view.trim().equals("allorders")){
          OrderDao odao =new OrderDao(FactoryProvider.getFactory());
          String status = request.getParameter("status");
          List<OrderTable> allOrders = odao.getOrdersByStatus(status);
          int sn =0;
      %>
      <h3>All Orders</h3>
      <a href="./admin-view.jsp?view=allorders&status=completed">Completed Orders</a>
      <hr>
      <tr>
        <th>Order Id</th>
        <th>Product Name</th>
        <th>Product Category</th>
        <th>Product Quantity</th>
        <th>Customer Name</th>
        <th>Customer Address</th>
        <th>Customer Phone</th>
        <th>Order Status</th>
        <th>Payment Status</th>
      </tr>
      <%for(OrderTable ao : allOrders){%>
      <tr>
        <td><%=sn++%></td>
        <td><a href="./admin-view.jsp?view=order&type=product&id=<%=ao.getOrderProduct().getpId()%>"><%=ao.getOrderProduct().getpName()%></a></td>
        <td><a href="./admin-view.jsp?view=order&type=category&id=<%=ao.getOrderProduct().getCategory().getCategoryId()%>"><%=ao.getOrderProduct().getCategory().getCategoryTitle()%></a></td>
        <td><%=ao.getQuantity()%></td>
        <td><a href="./admin-view.jsp?view=order&type=user&id=<%=ao.getOrderUser().getUserId()%>"><%=ao.getOrderUser().getUserName()%></a></td>
        <td><%=ao.getOrderUser().getUserAddress()%></td>
        <td><%=ao.getOrderUser().getUserPhone()%></td>
        <td><%=ao.getStatus()%></td>
        <td><%=ao.getPayment()%></td>
      </tr>
      <%
          }
        }else if(view.trim().equals("order")){
          OrderDao odao =new OrderDao(FactoryProvider.getFactory());
          List<OrderTable> specifiedOrders = new ArrayList();
          String type = request.getParameter("type");
          int id = Integer.parseInt(request.getParameter("id"));
          if(type.trim().equals("user")){
            specifiedOrders = odao.getOrdersByUser(id);
          }
          else if(type.trim().equals("product")){
            specifiedOrders = odao.getOrdersByProduct(id);
          } 
          else if(type.trim().equals("category")){
            specifiedOrders = odao.getOrdersByCategory(id);
          } 
          int sn =0;
      %>
      <h3>All Orders by <%=type%></h3>
      <hr>
      <tr>
        <th>Order Id</th>
        <th>Product Name</th>
        <th>Product Category</th>
        <th>Product Quantity</th>
        <th>Customer Name</th>
        <th>Customer Address</th>
        <th>Customer Phone</th>
        <th>Order Status</th>
        <th>Payment Status</th>
      </tr>
      <%for(OrderTable ao : specifiedOrders){%>
      <tr>
        <td><%=sn++%></td>
        <td><a href="./admin-view.jsp?view=order&type=product&id=<%=ao.getOrderProduct().getpId()%>"><%=ao.getOrderProduct().getpName()%></a></td>
        <td><a href="./admin-view.jsp?view=order&type=category&id=<%=ao.getOrderProduct().getCategory().getCategoryId()%>"><%=ao.getOrderProduct().getCategory().getCategoryTitle()%></a></td>
        <td><%=ao.getQuantity()%></td>
        <td><a href="./admin-view.jsp?view=order&type=user&id=<%=ao.getOrderUser().getUserId()%>"><%=ao.getOrderUser().getUserName()%></a></td>
        <td><%=ao.getOrderUser().getUserAddress()%></td>
        <td><%=ao.getOrderUser().getUserPhone()%></td>
        <td><%=ao.getStatus()%></td>
        <td><%=ao.getPayment()%></td>
      </tr>
      <%
          }
        }
        else if(view.trim().equals("categories")){
          CategoryDao acdao =new CategoryDao(FactoryProvider.getFactory());
          List<Category> allCategories = acdao.getAllCategory();
      %>
      <h3>Categories</h3>
      <hr>
      <tr>
        <th>Name</th>
        <th>Description</th>
        <th>Number of Products</th>
      </tr>
      <%for(Category ac : allCategories){%>
      <tr>
        <td><%=ac.getCategoryTitle()%></td>
        <td><%=ac.getCategoryDescription()%></td>
        <td><%=ac.getProducts().size()%></td>
      </tr>
      <%}%>
      <%
        }
        else if(view.trim().equals("products")){
          ProductDao pdao =new ProductDao(FactoryProvider.getFactory());
          List<Product> allProducts = pdao.getAllProducts();
      %>
      <h3>Products</h3>
      <hr>
      <tr>
        <th>Name</th>
        <th>Description</th>
        <th>Price</th>
        <th>Discount</th>
        <th>Price After Discount</th>
        <th>Stock Quantity</th>
        <th>Category</th>
      </tr>
      <%for(Product ap : allProducts){%>
      <tr>
        <td><%=ap.getpName()%></td>
        <td><%=ap.getpDescription()%></td>
        <td><%=ap.getpPrice()%></td>
        <td><%=ap.getpDiscount()%></td>
        <td><%=ap.getPriceAfterDiscount()%></td>
        <td><%=ap.getpQuantity()%></td>
        <td><%=ap.getCategory().getCategoryTitle()%></td>
      </tr>
      <%}%>
      <%
        }
        else{
          session.setAttribute("message", "Error");
          response.sendRedirect("admin.jsp");
        }
      %>
    </table>
  </center>
</body>
</html>
