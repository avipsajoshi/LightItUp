<%-- 
    Document   : admin
    Created on : 5 Feb 2024, 14:40:08
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.lightitup.entities.User" %>
<%@page import="com.lightitup.entities.OrderTable" %>
<%@page import="com.lightitup.helper.FactoryProvider" %>
<%@page import="com.lightitup.dao.CategoryDao" %>
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
     if(user.getUserType().equals("customer")){
      session.setAttribute("message", "You donot have access to this page.");
      response.sendRedirect("login.jsp");
      return;
    }
  }
  
  UserDao udao =new UserDao(FactoryProvider.getFactory());
  List<User> allCustomerUsers = udao.getUserByType("customer");
  ProductDao pdao =new ProductDao(FactoryProvider.getFactory());
  List<Product> allProducts = pdao.getAllProducts();
  OrderDao odao =new OrderDao(FactoryProvider.getFactory());
  List<OrderTable> allOrdersCompleted = odao.getOrdersByStatus("completed");
  List<OrderTable> allOrdersPending = odao.getOrdersByStatus("pending");

%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin Panel</title>
    <link rel="stylesheet" href="css/fontAndColors.css" />
    <link rel="stylesheet" href="css/cardStyle.css" />
    <link rel="stylesheet" href="css/adminCardForms.css" />
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
  </head>
  <body>
    <%@include file="components/nav.jsp"%>
    <%@include file="components/message.jsp"%>

    <div class="grid-container-admin">
      <div class="card">
        <div class="image-container">
          <a href="./admin-view.jsp?view=users&type=customer"><i class="fa-solid fa-user-group"></i></a>
        </div>
        <div class="info-container">
          <p class="description">Customers</p>
          <p class="number"><%=allCustomerUsers.size()%></p>
        </div>
      </div>
      <div class="card">
        <div class="image-container">
          <a href="./admin-view.jsp?view=allorders&status=pending"><i class="fa-solid fa-list"></i></a>
        </div>
        <div class="info-container">
          <p class="description">Order</p>
          <p class="number">Completed : <%=allOrdersCompleted.size()%></p>
          <p class="number">Pending: <%=allOrdersPending.size()%></p>
        </div>
      </div>


      <div class="card">
        <div class="image-container">
          <a href="./admin-view.jsp?view=categories"><i class="fa-solid fa-table-cells-large"></i></a>
        </div>
        <div class="info-container">
          <p class="description">Categories</p>
          <p class="number"><%=allCategories.size()%></p>
          <div class="add-container">
            <button onclick="openPopup(pop_c)">ADD</button>
          </div>
          <div id="popup-category" class="popup-container">
            <div class="close-button" onclick="closePopup(pop_c)">X</div>
            <form id="category-form" action="./ProductOperationServlet" method="post">
              <input type="hidden" value="1" name="operationType">
              <h3> Add New Category</h3>  
              <br>
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
          <a href="./admin-view.jsp?view=products"><i class="fa-solid fa-box-open"></i></a>
        </div>
        <div class="info-container">
          <p class="description">Products</p>
          <p class="number"><%=allProducts.size()%></p>
          <div class="add-container">
            <button onclick="openPopup(pop_p)">ADD</button>
          </div>
          <div id="popup-product" class="popup-container">
            <div class="close-button" onclick="closePopup(pop_p)">X</div>
            <form id="product-form" action="./ProductOperationServlet" method="post" enctype="multipart/form-data">
              <input type="hidden" value="2" name="operationType">
              <h3> Add New Product</h3>
              <br>
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
              <input type="text" id="product-quantity" name="product-quantity" />
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
              <label for="select-category">Category: </label>
              <br>
              <!--product category drop down-->

              <select name="catId" id="select-category">
                <%
                  for(Category pro_c : allCategories){                               %>
                <option value="<%=pro_c.getCategoryId()%>"><%=pro_c.getCategoryTitle()%></option>
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
      const nameInput = document.getElementById("category-name");
      const descriptionInput = document.getElementById("category-description");
      const nameError = document.getElementById("category-name-error");
      const descriptionError = document.getElementById("category-description-error");

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
        var flag =0;
        const nameregex = /^[a-zA-Z\s]+$/;
        if (namevalue === "") {
          setError(input, " Cannot be Empty", error);
          flag=1;
          return false;
        } else if (!nameregex.test(namevalue)) {
          setError(input, " Cannot contain number.", error);
          flag=1;
          return false;
        } else if(flag === 1 ){
          removeError(input, error);
          flag=0;
          return true;
        }else{
          flag=0;
          return true;
        }
      }
      // Set error message
      function setError(inputElement, message, errorId) {
        const errorElement = document.getElementById(errorId);
        errorElement.innerHTML = message;
        inputElement.classList.add("error-message");
      }

      // Remove error message
      function removeError(inputElement, errorId) {
        const errorElement = document.getElementById(errorId);
        errorElement.innerHTML = "";
        inputElement.classList.remove("error-message");
      }

    </script>
  </body>
</html>
