<%-- 
    Document   : cart
    Created on : 5 Mar 2024, 15:20:15
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="components/commonImport.jsp"%>

<% 
  User cuser =(User)session.getAttribute("logged_user");
  if(cuser == null){
    session.setAttribute("message", "You are not logged in! Please login first. ");
    response.sendRedirect("login.jsp");
    return;
  }
  else{
     if(cuser.getUserType().equals("admin")){
      session.setAttribute("message", "You are admin. You do not have a cart");
      response.sendRedirect("admin.jsp");
      return;
    }
  }
  int userId = cuser.getUserId();
  CartDao cartdao =new CartDao(FactoryProvider.getFactory());
  List<Cart> allCartItems = cartdao.getCartItemsByUserId(userId);
  ProductDao pdao =new ProductDao(FactoryProvider.getFactory());
  Product products = new Product();
%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>My Cart</title>
    <link rel="icon" type="image/png" href="images/l_img.png" />
    <style>
      .cart-body{
        margin-left: 50px;
      }
      .card-container {
        width: calc(100vw / 2);
        border-bottom: 1px solid #ccc;
        border-top-left-radius: 8px;
        border-top-right-radius: 0px;
        border-bottom-right-radius: 0px;
        border-bottom-left-radius: 8px;
        overflow: hidden;
        margin-bottom: 10px;
        padding-right: 10px;
        ;
      }

      .card-head {
        display: flex;
        align-items: center;
        justify-content: flex-end;
      }

      .image-container {
        max-width: 30%;
        border-top-left-radius: 8px;
        border-bottom-left-radius: 8px;
      }
      .product-image{
        width: 100%;
        height:auto;
        border-top-left-radius: inherit;
        border-bottom-left-radius: inherit;
      }

      .info-container {
        max-width: 40%;
      }
      .cards{
        width:50%;
      }
      .card-body {
        padding: 1rem;
      }

      .card-title {
        font-size: larger;
        margin-bottom: 0.5rem;
      }

      .card-text {
        margin-bottom: 0.5rem;
      }

      .text-body-secondary {
        font-size: 0.875rem;
        color: #6c757d;
      }

      .checkboxes{
        position: relative;
        margin-right: 45px;
      }
      input[type="checkbox"]{
        visibility: hidden;
        position: absolute;
      }
      input[type="checkbox"] + label:before{
        height:18px;
        width:18px;
        position: absolute;
        top: 50%;
        left: 0;
        margin-right: 2px;
        content: " ";
        display:inline-block;
        vertical-align: baseline;
        border: 2px solid var(--back);
        outline: 2px solid var(--action);
        /* border-radius: 53px; */
        cursor: pointer;
        border-radius:50%;
      }
      input[type="checkbox"]:checked + label:before{
        background-color: var(--action);
        outline: 2px solid var(--action);
      }
      .form{
        display: flex;
        justify-content: space-evenly;
      }
      .bill{
        display: flex;
        flex-direction: column;
        align-self: flex-end;
        margin: 50px;
        padding: 30px;
      }
      .total,.bill-card{
        display: flex;
        gap: 20px;
      }
      .total p{
        margin: 6px;
      }
      .bill-image-container{
        max-width: 100px;
      }
      .bill-image-container img{
        width: 100%;
        height:auto;
      }
      .changeBtn{
        width: 25px;
        height: auto;
        border:none;
      }
      input.changeBtn{
        padding-left: 18px;
      }
      #myorders{
        float: right;
        margin-right: 50px;
      }
      h3{
        margin-top: 50px;
      }
      #checkoutButton{
        border-radius: 20px;
        padding: 5px 20px;
        cursor: pointer;
        margin: 30px;
        font-size: medium;
        font-family: inherit;
        background-color: var(--back);
        border: 2px solid var(--action);
        color: var(--text);
        transition: 0.3s;
      }
      #checkoutButton:hover{
        background-color: var(--action);
        color: var(--back);
      }
    </style>
  </head>
  <body>
    <%@include file="components/nav.jsp"%>
    <link rel="stylesheet" href="css/displaybody.css" />
    <div class="cart-body">
      <h3>My Cart</h3>
      <a href="customer-order.jsp" id="myorders">My Orders</a>
      <form id="cartForm" action="./CartCheckoutServlet" method="get">
        <input name="userId" value="<%=userId%>" hidden>

        <div class="form">
          <div class="cards">
            <%
              for(Cart c :allCartItems){
                products = pdao.getProductById(c.getCartProduct().getpId());
                int productId = products.getpId();
            %>
            <div class="card-container" style="max-width: 540px;">
              <div class="card-head">
                <div class="image-container">
                  <img src="images/product-images/<%=products.getpPhoto()%>" class="product-image prod<%=productId%>" alt="img">
                </div>
                <div class="info-container">
                  <div class="card-body">
                    <h5 class="card-title prod<%=productId%>"><%=Helper.get10Words(products.getpName())%></h5>
                    <hr>
                    <p class="card-text"><%=Helper.get10Words(products.getpDescription())%>
                    </p>
                    <p class="card-text"><%=products.getPriceAfterDiscount()%></p>
                    <label class="prod<%=productId%>" hidden><%=products.getpPrice()%></label>
                    <label class="prod<%=productId%>" hidden><%=products.getpDiscount()%></label>
                    <div class="change" style="max-width: fit-content;">
                      <button type="button" class="changeBtn" onclick="decreaseValue('quantity_prod<%=productId%>')" >-</button><input type="text" class="prod<%=productId%> changeBtn" name="cartqty-<%=productId%>" id="quantity_prod<%=productId%>" value="<%=c.getQuantity()%>" /><button type="button" class="changeBtn" onclick="increaseValue('quantity_prod<%=productId%>')" >+</button>
                    </div>
                  </div>
                </div>
                <div class="checkboxes">
                  <input type="checkbox" class="checkbox" name="checkbox" value="<%=productId%>" id="<%=productId%>">
                  <label for="<%=productId%>"></label>
                </div>
              </div>
            </div>
            <%
              }
            %>
          </div>
          <div class="bill">
            <h2>Place Order</h2>
            <div class="bill-body" id="bill-body">
            </div>
            <div class="total">
              <div class="total-text">
                <p>Total</p>
                <p>Discount</p>
                <p>Grand Total</p>
              </div>
              <div class="total-num">
                <p id="total"></p>
                <p id="discount"></p>
                <p id="gtotal"></p>
              </div>
            </div>
            <!--<button type="submit" onclick="sendCheckedInputs()">Check Out</button>-->
            <button type="submit" id="checkoutButton">Check Out</button>
          </div>
        </div>
      </form>
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
