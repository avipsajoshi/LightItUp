<%-- 
    Document   : view
    Created on : 11 Mar 2024, 16:04:08
    Author     : Dell
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>    
<%@include file="components/commonImport.jsp"%>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>View</title>
  </head>
  <body>
    <%@include file="components/nav.jsp"%>
    <link rel="stylesheet" href="css/displaybody.css" />
    <%@include file="components/message.jsp"%>
    <%
      String search = request.getParameter("search");
      int searchWho=1;
      ProductDao getProductsDao = new ProductDao(FactoryProvider.getFactory());
      List<Product> productList = new ArrayList<>();
      if(search!=null && search.trim().equals("num")){
        String productId = request.getParameter("product");
        int productIdSearch = Integer.parseInt(productId);
        searchWho = 1;
        productList = getProductsDao.getProductsById(productIdSearch);
      }
      else if(search!=null && search.trim().equals("nan")){
        String searchname = request.getParameter("searchname");
        searchWho = 2;
        productList = getProductsDao.getProductsBySearch(searchname);
      }
      else{
      }
      if(searchWho == 2){
    %>
    <link rel="stylesheet" href="css/cardStyle.css" />
    <%
      }else if(searchWho == 1){
    %>
    <link rel="stylesheet" href="css/viewCardStyle.css" />
    <%
    }else{
      session.setAttribute("message", "There was some error. Please try again!");
      response.sendRedirect("./index.jsp");
    }
    %>
    <div class="grid-container">
      <%
        for(Product prod:productList){
      %>
      <!--product card-->
      <div class="card" id="product-card">
        <div class="image-container">
          <img src="images/product-images/<%=prod.getpPhoto() %>" alt="<%=prod.getpPhoto() %>"/>
        </div>
        <div class="info-container">
          <p style="font-weight: 600"><%=prod.getpName() %></p>
          <p>NPR. <%=prod.getPriceAfterDiscount()%> <span class="text-secondary">NPR. <%=prod.getpPrice()%></span><%=prod.getpDiscount()%>% off</p>
        </div>
        <div class="change" style="max-width: fit-content;">
          <button type="button" class="changeBtn" onclick="decreaseValue('quantity_prod<%=prod.getpId()%>')" >-</button>
          <input type="text" class="prod<%=prod.getpId()%> changeBtn" name="cart-qty" value="1" />
          <button type="button" class="changeBtn" onclick="increaseValue('quantity_prod<%=prod.getpId()%>')" >+</button>
        </div>
        <div class="add-to-cart-container">
          <form action="./AddToCart" method="post">
            <input type="text" name="productId" value="<%=prod.getpId()%>" hidden>
            <button type="submit" name="fromWhere" value="view">Add To Cart</button>
          </form>
        </div>
        <div class="add-to-cart-container">
          <form action="./BuyNowServlet" method="post">
            <input type="text" name="productId" value="<%=prod.getpId()%>" hidden>
            <button type="submit" name="fromWhere" value="view">Add To Cart</button>
          </form>
        </div>
      </div> 
      <%
        }
      %>
    </div>
    <script>
      function increaseValue(qtyId) {
        var qty = document.getElementById(qtyId);
        var number = parseInt(qty.getAttribute('value'));
        if (number != 10) {
          number++;
          qty.setAttribute('value', number);
        }

        console.log(number);
      }
      function decreaseValue(qtyId) {
        var qty = document.getElementById(qtyId);
        var number = parseInt(qty.getAttribute('value'));
        if (number != 0) {
          number--;
          qty.setAttribute('value', number);
        }
        console.log(number);
      }
    </script>
  </body>
</html>
