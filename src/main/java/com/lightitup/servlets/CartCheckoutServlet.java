/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.lightitup.servlets;

import com.lightitup.entities.User;
import com.lightitup.entities.Cart;
import com.lightitup.dao.ProductDao;
import com.lightitup.dao.CartDao;
import com.lightitup.entities.Product;
import com.lightitup.dao.OrderDao;
import com.lightitup.entities.OrderTable;
import com.lightitup.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Dell
 */
public class CartCheckoutServlet extends HttpServlet {

  /**
   * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
   * methods.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
      String data = request.getQueryString();
      out.println(data + "<br>");
      HttpSession httpSession = request.getSession();
      if (httpSession.getAttribute("logged_user") != null) {
        User alreadyLogged = (User) httpSession.getAttribute("logged_user");
        int userId = alreadyLogged.getUserId();
        out.println("try" + "<br>");
        ProductDao productDao = new ProductDao(FactoryProvider.getFactory());
        CartDao cartDao = new CartDao(FactoryProvider.getFactory());
        OrderDao orderDao = new OrderDao(FactoryProvider.getFactory());
        int[][] cartQtyArray = new int[10][2]; // Assuming maximum 10 cart-qty values
        int count = -1, checkFlag = -1, arrayIndex = -1;
        boolean[] checkboxArray = new boolean[10];
        int[] check = new int[10];
        // Split the data on "&" to get individual key-value pairs
        String[] keyValuePairs = data.split("&");
        for (String pair : keyValuePairs) {
          String[] parts = pair.split("=");
          String key = parts[0];
          String value = parts.length > 1 ? parts[1] : "";
          out.println(key + ":" + value);
          if (key.equals("userId")) {
            userId = Integer.parseInt(value);
            continue;
          }
          if (key.startsWith("cartqty-")) {
            String[] qtyparts = key.split("-");
            String qtykey = qtyparts[0];
            String qtyvalue = qtyparts.length > 1 ? qtyparts[1] : "";
            int indexs = Integer.parseInt(qtyvalue);
            int productId = indexs;
            arrayIndex++;
            int quantity = Integer.parseInt(value);
            cartQtyArray[arrayIndex][0] = productId;
            cartQtyArray[arrayIndex][1] = quantity;
            out.println(cartQtyArray[arrayIndex][0] + " = ");
            out.println(cartQtyArray[arrayIndex][1]);
            continue;
          }
          if (key.equals("checkbox")) {
            checkFlag++;
            out.println("here3");
            check[checkFlag] = Integer.parseInt(value);
            out.println(check[checkFlag]);
            out.println("flag" + checkFlag);
            out.println("flag" + checkFlag);
            continue;
          } else {
            out.println("?????????????");
          }
          out.println(checkboxArray[checkFlag]);
          out.println(checkFlag);
        }
        double total = 0;
        for (int j = 0; j <= checkFlag; j++) {
          for (int i = 0; i <= arrayIndex; i++) {
            if (check[j] == cartQtyArray[i][0] && cartQtyArray[i][1] != 0) {
              int productId = cartQtyArray[i][0];
              int quantity = cartQtyArray[i][1];
              out.println("Product ID: " + productId + ", Quantity: " + quantity + "<br>");
              Product addOrderProduct = productDao.getProductById(productId);
              out.println(addOrderProduct.getpName());
              out.println("<br>1234567890<br>");
              out.println("gvjhbkiigucuc");
              OrderTable newOrder = new OrderTable();
              newOrder.setOrderProduct(addOrderProduct);
              newOrder.setOrderUser(alreadyLogged);
              newOrder.setQuantity(quantity);
              newOrder.setStatus("pending");
              newOrder.setPayment("paid");
              newOrder.setTotal(addOrderProduct.getPriceAfterDiscount() * quantity);
              total += newOrder.getTotal();
              boolean added = orderDao.addNewOrder(newOrder);
              if (added == true) {
                count++;
                out.println(count);
              }
            } 
          }
        }
        out.println("count ");
        out.println(count);
        out.println(checkFlag);
        total = total * 100;
        if (count == checkFlag) {
          httpSession.setAttribute("message", "Order Placed!");
          httpSession.setAttribute("total", total);
          response.sendRedirect("./checkout.jsp");
//          for (int j = 0; j <= 1; j++) {
//          for (int i = j; i <= 1; i++) {
//            if (check[j] == cartQtyArray[i][0]) {
//              int productId = cartQtyArray[i][0];
//              Cart cr = cartDao.getCartItemByUserIdAndProductId(userId, productId);
//              boolean deleted = cartDao.deleteCart(cr);
//              if (deleted == true) {
//                out.println("YE");
//              }
//              else{
//                continue;
//              }
//            }
//          }
//        }
          out.println(httpSession.getAttribute("message"));
          out.println(httpSession.getAttribute("total"));
        } else {
          httpSession.setAttribute("message", "Error placing Order!");
          out.println(httpSession.getAttribute("message"));
          response.sendRedirect("cart.jsp");
        }
      } else {
        httpSession.setAttribute("message", "Error");
        response.sendRedirect("./login.jsp");
      }
    }
  }

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
  /**
   * Handles the HTTP <code>GET</code> method.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    processRequest(request, response);
  }

  /**
   * Handles the HTTP <code>POST</code> method.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    processRequest(request, response);
  }

  /**
   * Returns a short description of the servlet.
   *
   * @return a String containing servlet description
   */
  @Override
  public String getServletInfo() {
    return "Short description";
  }// </editor-fold>

}
