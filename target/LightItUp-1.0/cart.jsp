<%-- 
    Document   : cart
    Created on : 5 Mar 2024, 15:20:15
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.lightitup.entities.OrderTable" %>
<%@page import="com.lightitup.entities.Cart" %>
<%@page import="com.lightitup.dao.UserDao" %>
<%@page import="com.lightitup.dao.CartDao" %>
<%@page import="com.lightitup.dao.ProductDao" %>
<%@page import="com.lightitup.dao.OrderDao" %>
<%@page import="java.util.List" %>
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
  CartDao cartdao =new CartDao(FactoryProvider.getFactory());
  List<Cart> allCartItems = cartdao.getCartItemsByUserId(cuser.getUserId());
  
  ProductDao pdao =new ProductDao(FactoryProvider.getFactory());
  Product products = new Product();
%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Your Cart</title>
    <link rel="icon" type="image/png" href="images/l_img.png" />
    <style>
      .card-container {
        max-width: 540px;
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
      }

      .image-container {
        max-width: 40%;
      }

      .info-container {
        max-width: 60%;
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
        gap: 100px;
      }
      .bill{
        margin-left: 50px;
      }
      .total,.bill-card{
        display: flex;
        gap: 20px;
      }
      .bill-image-container{
        max-width: 100px;
      }
      .bill-image-container img{
        width: 100%;
        height:auto;
      }
      .changeBtn{
        width: max-content;
        height: auto;
        border:none;
      }
      h3{
        margin-top: 50px;
      }
      a{
        color: black;
        text-decoration: none;
      }
    </style>
  </head>
  <body>
    <%@include file="components/nav.jsp"%>
    <link rel="stylesheet" href="css/displaybody.css" />
    <h3>Your Cart</h3>
    <a href="customer-order.jsp">Your Orders</a>
    <form action="/CartCheckoutServlet" method="post">
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
                  <input class="jsGet" name="prodID" value="prodS<%=productId%>" hidden>
                  <h5 class="card-title prod<%=productId%>"><%=products.getpName()%></h5>
                  <hr>
                  <p class="card-text"><%=products.getpDescription()%></p>
                  <p class="card-text"><%=products.getPriceAfterDiscount()%></p>
                  <label class="prod<%=productId%>" hidden><%=products.getpPrice()%></label>
                  <label class="prod<%=productId%>" hidden><%=products.getpDiscount()%></label>
                  <div class="change" style="max-width: fit-content;">
                    <button type="button" class="changeBtn" onclick="decreaseValue('quantity_prod<%=productId%>')" >-</button><input type="text" class="prod<%=productId%> changeBtn" name="cart-qty" id="quantity_prod<%=productId%>" value="<%=c.getQuantity()%>" /><button type="button" class="changeBtn" onclick="increaseValue('quantity_prod<%=productId%>')" >+</button>
                  </div>
                </div>
              </div>
              <div class="checkboxes">
                <input type="checkbox" class="checkbox" name="checkbox" id="<%=productId%>">
                <label for="<%=productId%>"></label>
              </div>
            </div>
          </div>
          <%
            }
          %>
        </div>


        <div class="bill">
          <h2>Your Items</h2>
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
          <button type="submit" name="userId" value="<%=cuser.getUserId()%>">Check Out</button>
        </div>
      </div>
    </form>
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

      document.addEventListener("DOMContentLoaded", function () {
        const checkboxes = document.querySelectorAll(".checkbox");
        const bill_card = document.getElementById("bill-body");
        const total = document.getElementById("total");
        const discount = document.getElementById("discount");
        const gtotal = document.getElementById("gtotal");
        checkboxes.forEach(function (checkbox) {
          checkbox.addEventListener("change", function () {
            var t = 0, d = 0, g = 0, ch = 0;
            const checkboxId = this.id;
            const checkboxProduct = this.getElementsByClassName('prod' + checkboxId);
            const divId = "div" + checkboxId.charAt(checkboxId.length - 1);
            let divToRemove = document.getElementById(divId);
            if (this.checked) {
              if (!divToRemove) {
                ch++;
                const newDiv = document.createElement("div");
                newDiv.id = divId;
                newDiv.classList.add("bill-card")
                newDiv.classList.add("content");
                newDiv.innerHTML = "<div class='bill-image-container'><img src='images/product-images/" + checkboxProduct[0] + "' alt='Image' /></div><div class='bil-info-container'><p class='product-name'>" + checkboxProduct[1] + "</p><p class='product-price'>" + checkboxProduct[2] + "</p><p class='product-qty'>Qty:" + checkboxProduct[4] + "</p></div>";
                t = t + parseFloat(checkboxProduct[2].innerText);
                d = d + parseFloat(checkboxProduct[3].innerText);
                g = g + (parseFloat(checkboxProduct[2].innerText) - (parseFloat(checkboxProduct[2].innerText) * parseFloat(checkboxProduct[3].innerText) / 100));
                bill_card.appendChild(newDiv);
              }
            } else {
              if (divToRemove) {
                ch--;
                if (t !== 0 && g !== 0 && d !== 0) {
                  t = t - parseFloat(checkboxProduct[2].innerText);
                  d = d - parseFloat(checkboxProduct[3].innerText);
                  g = g - (parseFloat(checkboxProduct[2].innerText) - (parseFloat(checkboxProduct[2].innerText) * parseFloat(checkboxProduct[3].innerText) / 100));
                } else {
                  t = 0;
                  d = 0;
                  g = 0;
                }
                bill_card.removeChild(divToRemove);
              }
              total.innerText = t;
              discount.innerText = d / ch + "%";
              gtotal.innerText = g;

            }
          });
        });
      });


    </script>
  </body>
</html>
