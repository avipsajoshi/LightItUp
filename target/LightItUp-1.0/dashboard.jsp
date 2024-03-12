<%-- 
    Document   : client.jsp
    Renamed    : dashboard.jsp
    Created on : 5 Feb 2024, 14:40:22
    Renamed on : 4 Mar 2024, 15:33:15
    Author     : Dell
--%>
<%@page import="com.lightitup.helper.FactoryProvider" %>
<%@page import="com.lightitup.dao.ProductDao" %>
<%@page import="java.util.List" %>
<%
    User user =(User) session.getAttribute("logged_user");
    if(user == null){
      session.setAttribute("message", "You are not logged in! Please login first. ");
      response.sendRedirect("login.jsp");
      return;
    }
    else{
       if(user.getUserType().equals("admin")){
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
    <title>Dashboard</title>
    <link rel="stylesheet" href="css/fontAndColors.css" />

  </head>
  <body>
    <%@include file="components/nav.jsp"%>
    <link rel="stylesheet" href="css/displaybody.css" />
    <link rel="stylesheet" href="css/cardStyle.css" />
    <link rel="stylesheet" href="js/cardScript.js" />

    <!--    <h2>Creating Session factory object <% 
          FactoryProvider.getFactory();
    %>-->
    <%@include file="components/message.jsp"%>

    <div id="main">
      <%
        String category = request.getParameter("cat");
        ProductDao getProductsDao = new ProductDao(FactoryProvider.getFactory());
        List<Product> productList = null;
        if(category == null || category.trim().equals("all")){
          productList = getProductsDao.getProductsByCategory();
        }
        else{
          int catId=Integer.parseInt(category.trim());
          productList = getProductsDao.getProductsByCategoryId(catId);
        }
      %>
      <div class="list-group" id="main-sidebar">
        <!--show categories-->
        <a href="dashboard.jsp?cat=all" class="list-group-item active" >
          All Products
        </a>
        <%
          for(Category c : allCategories){
        %>
        <a href="dashboard.jsp?cat=<%=c.getCategoryId()%>" class="list-group-item"><%=c.getCategoryTitle()%></a>
        <%
          }
        %>
      </div>
      <div id="main-body">
        <!--show products-->
        <%
          for(Category cat:allCategories){
            if(category == null || category.trim().equals("all")){
        %>
        <hr>
        <h2><%=cat.getCategoryTitle()%></h2>
        <%
          }else{
            if(Integer.parseInt(category.trim()) == cat.getCategoryId()){
        %>
        <h2><%=cat.getCategoryTitle()%></h2>
        <%
              }
            }
        %>
        <div class="grid-container">
          <%
            for(Product prod:productList){
            if(prod.getCategory().getCategoryId() == cat.getCategoryId()){
          %>
          <!--product card-->
          <div class="card" id="product-card">
            <a href="view.jsp?search=num?product=<%=prod.getpId()%>">
            <div class="image-container">
              <img src="images/product-images/<%=prod.getpPhoto() %>" alt="<%=prod.getpPhoto() %>"/>
              <!--<img src="https://via.placeholder.com/200" alt=<%//=prod.getpPhoto() %> />-->
            </div>
            <div class="info-container">
              <p style="font-weight: 600"><%=prod.getpName() %></p>
              <p>NPR. <%=prod.getPriceAfterDiscount()%> <span class="text-secondary">NPR. <%=prod.getpPrice()%></span> <%=prod.getpDiscount()%>% off</p>
            </div>
            </a>
            <div class="add-to-cart-container">
              <form action="./AddToCart" method="post">
                <input type="text" name="productId" value="<%=prod.getpId()%>" hidden>
                <button type="submit" name="fromWhere" value="dashboard">Add To Cart</button>
              </form>
            </div>
          </div> 
          <%
              }
            }
          %>
        </div>
        <%
          }
          if(productList.size()==0){
            out.println("<h3>Coming Soon! </h3>");
          }
        %>

      </div>
    </div>

  </body>
</html>
