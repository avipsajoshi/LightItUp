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
    <style>
      p{
        color:black;
      }
    </style>
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
        int getmore=0;
        if(category == null || category.trim().equals("all")){
          productList = getProductsDao.getProductsByCategory();
          getmore=0;
        }
        else{
          int catId=Integer.parseInt(category.trim());
          productList = getProductsDao.getProductsByCategoryId(catId);
          getmore = 8;
        }
        if(search!=null && search.trim().equals("num")){
          String productId = request.getParameter("product");
          int productIdSearch = Integer.parseInt(productId);
          productList = getProductsDao.getProductsById(productIdSearch);
        }
        else if(search!=null && search.trim().equals("nan")){
          String searchname = request.getParameter("searchname");
          productList = getProductsDao.getProductsBySearch(searchname);
        }
        else{
        
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
            if(getmore == 0){
              int count = 0;
              for(Product prod:productList){
              if(prod == null){
              out.println("<h3>Coming Soon! </h3>");
              }
              else if(prod != null && prod.getCategory().getCategoryId() == cat.getCategoryId()){
              count++;
          %>
          <!--product card for each category-->
          <div class="card" id="product-card">
            <a href="view.jsp?search=num?product=<%=prod.getpId()%>">
              <div class="image-container">
                <img src="images/product-images/<%=prod.getpPhoto() %>" alt="<%=prod.getpPhoto() %>"/>
              </div>
              <div class="info-container">
                <p style="font-weight: 600"><%=Helper.get10Words(prod.getpName())%></p>
                <p>NPR. <%=prod.getPriceAfterDiscount()%> 
                  <%
                    if(prod.getpDiscount() != 0){
                  %>
                  <span class="text-secondary">NPR. <%=prod.getpPrice()%></span> <%=prod.getpDiscount()%>% off
                  <%
                    }
else{
                  %><span class="text-secondary"> </span>
                  <%
}
                  %>
                </p>
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
              }if(count == 6){
              break;
              }
            } 
            }else{
              for(Product prod:productList){
                if(prod == null){
                out.println("<h3>Coming Soon! </h3>");
                }
                else if(prod != null && prod.getCategory().getCategoryId() == cat.getCategoryId()){
          %>
          <!--product card particular category-->
          <div class="card" id="product-card">
            <a href="view.jsp?search=num?product=<%=prod.getpId()%>">
              <div class="image-container">
                <img src="images/product-images/<%=prod.getpPhoto() %>" alt="<%=prod.getpPhoto() %>"/>
              </div>
              <div class="info-container">
                <p style="font-weight: 600"><%=Helper.get10Words(prod.getpName())%></p>
                <p>NPR. <%=prod.getPriceAfterDiscount()%> 
                  <%
                    if(prod.getpDiscount() != 0){
                  %>
                  <span class="text-secondary">NPR. <%=prod.getpPrice()%></span> <%=prod.getpDiscount()%>% off <%
                    }
else{
                  %><span class="text-secondary"> </span>
                  <%
}
                  %>
                </p>
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