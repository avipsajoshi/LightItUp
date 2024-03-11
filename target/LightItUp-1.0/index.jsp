<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.lightitup.helper.FactoryProvider" %>
<%@page import="com.lightitup.dao.ProductDao" %>
<%@page import="java.util.List" %>
<%
    User user =(User) session.getAttribute("logged_user");
    if(user != null){
      if(user.getUserType().equals("admin")){
        response.sendRedirect("admin.jsp");
        return;
      }
      else if(user.getUserType().equals("customer")){
        response.sendRedirect("dashboard.jsp");
        return;
      }
    }
%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Dashboard</title>
    <link rel="icon" type="image/png" href="images/l_img.png"/>

  </head>
  <body>
    <%@include file="components/nav.jsp"%>
    <link rel="stylesheet" href="css/displaybody.css" />
    <link rel="stylesheet" href="css/cardStyle.css" />
    <%@include file="components/message.jsp"%>

    <div id="main">
      <%
        String category = request.getParameter("cat");
        String search = request.getParameter("search");
        ProductDao getProductsDao = new ProductDao(FactoryProvider.getFactory());
        List<Product> productList = null;
        if(category == null || category.trim().equals("all")){
          productList = getProductsDao.getProductsByCategory();
        }
        else{
          int catId=Integer.parseInt(category.trim());
          productList = getProductsDao.getProductsByCategoryId(catId);
        }
        if(search.trim().equal("num")){
          String productId = request.getParameter("product");
          int productIdSearch = Integer.parseInt(productId);
          productList = getProductsDao.getProductsById(productIdSearch);
        }
        else if(search.trim().equal("nan")){
          String searchname = request.getParameter("searchname");
          productList = getProductsDao.getProductsBySearch(searchname);
        }
      %>
      <div class="list-group" id="main-sidebar">
        <!--show categories-->
        <a href="index.jsp?cat=all" class="list-group-item active" >
          All Products
        </a>
        <%
          for(Category c : allCategories){
        %>

        <a href="index.jsp?cat=<%=c.getCategoryId()%>" class="list-group-item"><%=c.getCategoryTitle()%></a>
        <%
          }
        %>
      </div>
      <div id="main-body">
        <!--show products-->
        <%
          for(Category cat:allCategories){
        %>
        <p><%=cat.getCategoryTitle()%></p>
        <div class="grid-container">
          
          <%
            for(Product prod:productList){
            if(prod.getCategory().getCategoryId() == cat.getCategoryId()){
          %>
          <!--product card-->
          <div class="card" id="product-card">
            <a href="index.jsp?search=num?product=<%=prod.getpId()%>">
            <div class="image-container">
              <img src="images/product-images/<%=prod.getpPhoto() %>" alt="<%=prod.getpPhoto() %>"/>
              <!--<img src="https://via.placeholder.com/200" alt=<%//=prod.getpPhoto() %> />-->
            </div>
            <div class="info-container">
              <p style="font-weight: 600"><%=prod.getpName() %></p>
              <p>NPR. <%=prod.getPriceAfterDiscount()%> <span class="text-secondary">NPR. <%=prod.getpPrice()%>, <%=prod.getpDiscount()%>% off</span></p>
            </div>
            </a>
            <div class="add-to-cart-container">
              <form action="./AddToCart" method="post">
                <input type="text" name="productId" value="<%=prod.getpId()%>" hidden>
                <button type="submit" name="fromWhere" value="index">Add To Cart</button>
              </form>
            </div>
            
          </div> 
          <%
              }
            }
          %>
        </div>
        <hr>
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