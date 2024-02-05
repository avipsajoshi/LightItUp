<%-- 
    Document   : admin
    Created on : 5 Feb 2024, 14:40:08
    Author     : Dell
--%>
<%@page import="com.lightitup.entities.User" %>
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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin Panel</title>
    <link rel="stylesheet" href="css/fontAndColors.css" />
    <link rel="stylesheet" href="css/cardStyle.css" />

  </head>
  <body>

    <%@include file="components/nav.jsp"%>
    <script>
      pop_p = "popup-product";
      pop_c = "popup-category";
      function openPopup(popup) {
        document.getElementById(popup).style.display = "block";
      }

      function closePopup(popup) {
        document.getElementById(popup).style.display = "none";
      }
    </script>
    <div class="grid-container-admin">
      <div class="card">
        <div class="image-container">
          <i class="fa-solid fa-user-group"></i>
        </div>
        <div class="info-container">
          <div class="description">Users</div>
          <div class="number">300</div>
        </div>
      </div>


      <div class="card">
        <div class="image-container">
          <i class="fa-solid fa-list"></i>
        </div>
        <div class="info-container">
          <div class="description">Categories</div>
          <div class="number">40</div>
          <div class="add-container">
            <button onclick="openPopup(pop_c)">ADD</button>
          </div>
          <div id="popup-category" class="popup-container">
            <div class="close-button" onclick="closePopup(pop_c)">X</div>
            <form id="category-form" action="./CategoryServlet" method="post">
              <label for="category-name">Category Name:</label>
              <small id="category-name-error" class="error"></small>
              <br>
              <input type="text" id="category-name" name="category-name" />
              <br>
              <label for="category-description">Category Description:</label>
              <small id="category-description-error" class="error"></small>
              <br>
              <input type="text" id="category-description" name="category-description" />
              <br>
              <button type="submit" class="submitBtn-category">Submit</button>
            </form>
          </div>
        </div>
      </div>


      <div class="card">
        <div class="image-container">
          <i class="fa-solid fa-bag-shopping"></i>
        </div>
        <div class="info-container">
          <div class="description">Products</div>
          <div class="number">100</div>
          <div class="add-container">
            <button onclick="openPopup(pop_p)">ADD</button>
          </div>
          <div id="popup-product" class="popup-container">
            <div class="close-button" onclick="closePopup(pop_p)">X</div>
            <form id="product-form" action="./ProductServlet" method="post">
              <label for="product-name">Product Name:</label>
              <small id="product-name-error" class="error"></small>
              <br>
              <input type="text" id="product-name" name="product-name" />
              <br>
              <label for="product-description">Product Description:</label>
              <small id="product-description-error" class="error"></small>
              <br>
              <input type="text" id="product-description" name="product-description" />
              <br>
              <button type="submit" class="submitBtn-product">Submit</button>
            </form>
          </div>
        </div>
      </div>
    </div>
    <script>


      //validation
      const categoryForm = document.querySelector("#category-form");
//      const productForm = document.querySelector("#product-form");
// const myform = document.getElementById("myForm");
      const c - btn = document.getElementByClass("submitBtn-category");
              const p - btn = document.getElementByClass("submitBtn-product");
      const nameInput = document.getElementById("category-name");
      const descriptionInput = document.getElementById("category-description");
      const nameError = document.getElementById("category-name-error");
      const descriptionError = document.getElementById("email-error");

      categoryForm.addEventListener("submit", function (event) {
        event.preventDefault();
        if (
                validateText(nameInput, nameError) &&
                validateText(descriptionInput, descriptionError)
                ) {
          categoryForm.submit();
        }
      });

//      productForm.addEventListener("submit", function (event) {
//        event.preventDefault();
//        if (
//                validateText(nameInput, nameError) &&
//                validateText(descriptionInput, descriptionError)
//                ) {
//          loginForm.submit();
//        }
//      });

      function validateText(input, error_class) {
        const namevalue = input.value.trim();
        const error = error_class;
        const nameregex = /^[a-zA-Z\s]+$/;
        if (namevalue === "") {
          setError(input, " Cannot be Empty", error);
          return false;
        } else if (!nameregex.test(namevalue)) {
          setError(input, " Cannot contain number.", error);
          return false;
        } else {
          removeError(input, error);
          return true;
        }
      }
      // Set error message
      function setError(inputElement, message, errorId) {
        const errorElement = document.getElementById(errorId);
        errorElement.textContent = message;
        inputElement.classList.add("error-message");
      }

      // Remove error message
      function removeError(inputElement, errorId) {
        const errorElement = document.getElementById(errorId);
        errorElement.textContent = "";
        inputElement.classList.remove("error-message");
      }

    </script>
  </body>
</html>
