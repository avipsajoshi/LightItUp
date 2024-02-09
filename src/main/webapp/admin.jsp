<%-- 
    Document   : admin
    Created on : 5 Feb 2024, 14:40:08
    Author     : Dell
--%>
<%@page import="com.lightitup.entities.User" %>
<%@page import="com.lightitup.dao.CategoryDao" %>
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
    <link rel="stylesheet" href="css/adminCardForms.css" />

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
    <div class="message-container">
      <%@include file="components/message.jsp"%>
    </div>
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
          <i class="fa-solid fa-user-group"></i>
        </div>
        <div class="info-container">
          <div class="description">Order</div>
          <div class="number">Completed : 200</div>
          <div class="number">Pending: 300</div>
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
            <form id="category-form" action="./ProductOperationServlet" method="post">
              <input type="hidden" value="1" name="operationType">
              <h3> Add New Category</h3>  
              <label for="category-name">Category Name:</label>
              <small id="category-name-error" class="error"></small>
              <br>
              <input type="text" id="category-name" name="category-name" />
              <br>
              <label for="category-description">Category Description:</label>
              <small id="category-description-error" class="error"></small>
              <br>
              <textarea id="category-description" name="category-description"></textarea>
              <br>
              <button type="submit" class="submitBtn-category">Add</button>
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
            <form id="product-form" action="./ProductOperationServlet" method="post" enctype="multipart/form-data">
              <input type="hidden" value="2" name="operationType">
              <h3> Add New Product</h3>
              <label for="product-name">Product Name:</label>
              <small id="product-name-error" class="error"></small>
              <br>
              <input type="text" id="product-name" name="product-name" />
              <br>
              <label for="product-description">Product Description:</label>
              <small id="product-description-error" class="error"></small>
              <br>
              <!--              <input type="text" id="product-description" name="product-description" />-->
              <textarea id="product-description" name="product-description"></textarea>
              <br>
              <label for="product-price">Price:</label>
              <small id="product-price-error" class="error"></small>
              <br>
              <input type="text" id="product-price" name="product-price" />
              <br>
              <label for="product-quantity">Quantity:</label>
              <small id="product-quantity-error" class="error"></small>
              <br>
              <input type="text" id="product-quantity" name="product-quatity" />
              <br>
              <label for="product-discount">Discount: </label>
              <small id="product-discount-error" class="error"></small>
              <br>
              <input type="text" id="product-discount" name="product-discount" />
              <br>
              <label for="product-image">Image</label>
              <small id="product-image-error" class="error"></small>
              <br>
              <input type="file" id="product-image" name="product-image" required />
              <br>

              <!--product category drop down-->

              <%
                CategoryDao cdao =new CategoryDao(FactoryProvider.getFactory());
                List<Category> allCategories =cdao.getAllCategory();
              %>
              <select name="catId" id="select-category">
                <%
                  for(Categrory c:allCategories){                               %>
                <option value="<%= c.getCategoryId();%>"><%= c.getCategoryTitle()%></option>
                <%
                  }
                %>
              </select>
              <button type="submit" class="submitBtn-product">Add</button>
            </form>
          </div>
        </div>
      </div>
    </div>
    <script>


      //validation
      const categoryForm = document.querySelector("#category-form");
      const productForm = document.querySelector("#product-form");
      const c_btn = document.getElementByClass("submitBtn-category");
      const p_btn = document.getElementByClass("submitBtn-product");
      const nameInput = document.getElementById("category-name");
      const descriptionInput = document.getElementById("category-description");
      const nameError = document.getElementById("category-name-error");

      //product from validation input
      const productNameInput = document.getElementById("product-name");
      const productDescriptionInput = document.getElementById("product-description");
      const productPriceInput = document.getElementById("product-price");
      const productQuantityInput = document.getElementById("product-quantity");
      const productDiscountInput = document.getElementById("product-discount");
      const productNameError = document.getElementById("product-name-error");
      const productDescriptionError = document.getElementById("product-description-error");
      const productPriceError = document.getElementById("product-price-error");
      const productQuantityError = document.getElementById("product-quantity-error");
      const productDiscountError = document.getElementById("product-discount-error");


//category form validation
      categoryForm.addEventListener("submit", function (event) {
        event.preventDefault();
        if (
                validateText(nameInput, nameError) &&
                validateText(descriptionInput, descriptionError)
                ) {
          categoryForm.submit();
        }
      });

      productForm.addEventListener("submit", function (event) {
        event.preventDefault();
        if (
                validateText(productNameInput, productNameError) &&
                validateText(productDescriptionInput, productDescriptionError) && validateText(productPriceInput, productPriceError) && validateText(productQuantityInput, productQuantityError) && validateText(productDiscountInput, productDiscountError)
                ) {
          productForm.submit();
        }
      });

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
