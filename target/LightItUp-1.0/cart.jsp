<%-- 
    Document   : cart
    Created on : 5 Mar 2024, 15:20:15
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.lightitup.entities.OrderTable" %>
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
     if(user.getUserType().equals("admin")){
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
    </style>
  </head>
  <body>
    <%@include file="components/nav.jsp"%>
    <link rel="stylesheet" href="css/displaybody.css" />
    <h3>Your Cart</h3>
    <form action="/CartCheckoutServlet">
      <div class="form">
        <div class="cards">
          <div class="card-container" style="max-width: 540px;">
            <div class="card-head">
              <div class="image-container">
                <img src="https://via.placeholder.com/200" class="product-image" alt="img">
              </div>
              <div class="info-container">
                <div class="card-body">
                  <h5 class="card-title">Product Title</h5>
                  <hr>
                  <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                  <div class="change" style="max-width: fit-content;">
                    <button type="button" onclick="decreaseValue('quantity')" >-</button>
                    <input type="text" name="cart-qty" id="quantity" value="1" />
                    <button type="button" onclick="increaseValue('quantity')" >+</button>
                  </div>
                </div>
              </div>
              <div class="checkboxes">
                <input type="checkbox" name="checkbox" id="01" <%=something%>><label for="01" <%=something%>></label>
              </div>
            </div>
          </div>

        </div>


        <div class="bill">
          <h2>BILL</h2>
          <div class="bill-body">
            <div class="bill-card">
              <div class="bill-image-container">
                <img src="https://via.placeholder.com/200" alt="Image" />
              </div>
              <div class="bil-info-container">
                <p class="product-name">Name</p>
                <p class="product-price">NPR. </p>
                <p class="product-qty">Qty: </p>
              </div>
            </div>
            <hr>
          </div>
          <div class="total">
            <div class="total-text">
              <p>Total</p>
              <p>Discount</p>
              <p>Grand Total</p>
            </div>
            <div class="total-num">
              <p>123124</p>
              <p>12 %</p>
              <p>3346475</p>
            </div>
          </div>
        </div>
      </div>
      <button type="submit">Check Out</button>
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
    </script>
  </body>
</html>
