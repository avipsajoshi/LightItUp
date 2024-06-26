<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.lightitup.dao.CategoryDao" %>
<%@page import="com.lightitup.dao.CartDao" %>
<%@page import="com.lightitup.dao.ProductDao" %>
<%@page import="com.lightitup.dao.UserDao" %>
<%@page import="com.lightitup.dao.OrderDao" %>
<%@page import="com.lightitup.helper.FactoryProvider" %>
<%@page import="com.lightitup.helper.Helper" %>
<%@page import="com.lightitup.entities.User" %>
<%@page import="com.lightitup.entities.Category" %>
<%@page import="com.lightitup.entities.Product" %>
<%@page import="com.lightitup.entities.OrderTable" %>
<%@page import="com.lightitup.entities.Cart" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Nav</title>
    <link rel="stylesheet" href="css/fontAndColors.css" />
    <link rel="stylesheet" href="css/navbarStyle.css" />
    <link rel="icon" type="image/png" href="LightItUp-1.0/webapp/images/l_img.png" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
      integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
      />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script>
      function showSidebar() {
        const sidebar = document.querySelector(".sidebar");
        // sidebar.style.display = "flex";
        if (sidebar) {
          sidebar.style.display = "flex";
        } else {
          console.error("Sidebar element not found");
        }
      }
      function hideSidebar() {
        const sidebar = document.querySelector(".sidebar");
        if (sidebar) {
          sidebar.style.display = "none";
        } else {
          console.error("Sidebar element not found");
        }
      }

      function toggleDropdown() {
        let dropdown = document.querySelector(".dropdown");
        let dropdownList = document.querySelector(".dropdownList");
        let category = document.querySelector("#categories-dropdown");
        if (category.style.display === "none") {
          category.style.display = "block";
          category.setAttribute("class", "drop-open");
          // category.style.position = "relative";
        } else {
          category.style.display = "none";
          category.setAttribute("class", "drop-close");
          // category.remove(".drop-open");
        }
      }
      function toggleDropdownUser() {
        let dropdown = document.querySelector(".dropdown");
        let dropdownList = document.querySelector(".dropdownList");
        let user = document.querySelector("#user-dropdown");
        if (user.style.display === "none") {
          user.style.display = "block";
          user.setAttribute("class", "drop-open");
        } else {
          user.style.display = "none";
          user.setAttribute("class", "drop-close");
        }
      }

      window.onclick = function (e) {
        let dropdown = document.querySelector(".dropdown");
        let dropdownList = document.querySelector(".dropdownList");
        const category = document.querySelector("#categories-dropdown");
        const toggleList = document.querySelector(".toggleList");
        const user = document.querySelector("#user-dropdown");
        const toggleListUser = document.querySelector(".toggleListUser");
        if (
                !dropdown.contains(e.target) &&
                !dropdownList.contains(e.target) &&
                !category.contains(e.target) &&
                !toggleList.contains(e.target)
                ) {
          if (category.style.display === "block") {
            category.style.display = "none";
            category.setAttribute("class", "drop-close");
          }
        }
        if (
                !dropdown.contains(e.target) &&
                !dropdownList.contains(e.target) &&
                !user.contains(e.target) &&
                !toggleListUser.contains(e.target)
                ) {
          if (user.style.display === "block") {
            user.style.display = "none";
            user.setAttribute("class", "drop-close");
          }
        }
      };
    </script>
  </head>
  <body>
    <!--    <h2>Creating Session factory object <% 
          FactoryProvider.getFactory();
    %>-->
    <%
      User user1 =(User)session.getAttribute("logged_user");
    %>
    <nav>
      <ul class="sidebar">
        <li onclick="hideSidebar()">
          <a href="#" class="close"
             ><svg
              xmlns="http://www.w3.org/2000/svg"
              height="24"
              viewBox="0 -960 960 960"
              width="24"
              >
            <path
              d="m256-200-56-56 224-224-224-224 56-56 224 224 224-224 56 56-224 224 224 224-56 56-224-224-224 224Z"
              /></svg
            ></a>
        </li>
        <li>
          <div class="search-container">
            <form action="" method="post" class="search-form">
              <button
                type="submit"
                id="search_button"
                style="border: none; background: none"
                >
                <i class="fa-solid fa-magnifying-glass" id="mag-glass"></i>
              </button>
              <input
                type="text"
                name="searchname"
                id="searchname"
                placeholder="Search"
                />
            </form>
          </div>
        </li>
        <li><a href="index.jsp">Home</a></li>
        <li class="toggleList" onclick="toggleDropdown()">
          <a href="#">Categories</a>
          <div class="dropdown">
            <%
                CategoryDao cdao =new CategoryDao(FactoryProvider.getFactory());
                List<Category> allCategories = cdao.getAllCategory();
            %>
            <ul class="dropdownList" id="categories-dropdown">
              <%
                for(Category c : allCategories){
              %>
              <li><a href="search.jsp/<%= c.getCategoryId()%>"><%= c.getCategoryTitle()%></a></li>
                <%
                  }
                %>
            </ul>
          </div>
        </li>
        <li><a href="#">About</a></li>
        <li>
          <div style="width:fit-content; position: relative;">
            <a href="#"><i class="fa-solid fa-cart-shopping"></i></a>
            <button class="cart-notification"><span class="cart-items">0</span></button>
          </div>
        </li>
        <li class="toggleListUser" onclick="toggleDropdownUser()">
          <a href="#"><i class="fa-solid fa-user"></i></a>
          <div class="dropdown" id="user-dropdown">
            <ul class="dropdownList">
              <li><a href="./login.jsp">Login</a></li>
              <li><a href="./register.jsp">Sign Up</a></li>
            </ul>
          </div>
        </li>
      </ul>

      <ul class="navbar">
        <li class="menu-button" onclick="showSidebar()">
          <a href="#"
             ><svg
              xmlns="http://www.w3.org/2000/svg"
              height="24"
              viewBox="0 -960 960 960"
              width="24"
              >
            <path
              d="M120-240v-80h720v80H120Zm0-200v-80h720v80H120Zm0-200v-80h720v80H120Z"
              /></svg
            ></a>
        </li>
        <li>
          <a href="./index.jsp" id="navImageAnchor"><img src="images/l_text.png" alt="logo"  id="navImage"/></a>
        </li>
        <li class="hideOnMobile search">
          <div class="search-container">
            <form action="./view.jsp?search=nan" method="get" class="search-form">
              <button
                type="submit"
                id="search_button"
                style="border: none; background: none"
                >
                <i class="fa-solid fa-magnifying-glass" id="mag-glass"></i>
              </button>
              <input
                type="text"
                name="searchname"
                id="searchname"
                placeholder="Search"
                />
            </form>
          </div>
        </li>
        <li class="hideOnMobile"><a href="./index.jsp">Home</a></li>
        <li class="hideOnMobile">
          <a href="#">Categories</a>
          <div id="categories-dropdown">
            <ul>
              <%
                for(Category c : allCategories){ 
              %>
              <li><a href="./search.jsp/<%= c.getCategoryId()%>"><%= c.getCategoryTitle()%></a></li>
                <%
                  }
                %>
            </ul>
          </div>
        </li>
        <li class="hideOnMobile"><a href="#">About</a></li>
        <li class="hideOnMobile">
          <a href="./cart.jsp"><i class="fa-solid fa-cart-shopping"></i></a>
        </li>
        <li class="hideOnMobile">
          <a href="#"><i class="fa-solid fa-user"></i></a>
          <div class="dropdown" id="user-dropdown">
            <ul class="dropdownList">
              <%
                if(user1==null){
              %>
              <li><a href="./login.jsp">Login</a></li>
              <li><a href="./register.jsp">Sign Up</a></li>
                <%
                  }
                  else{
                %>
              <li><a href="./profile.jsp"><%= user1.getUserName() %></a></li>
              <li><a href="./LogoutServlet">Logout</a></li>
                <%
                  }
                %>

            </ul>
          </div>
        </li>
      </ul>
    </nav>
  </body>
</html>
