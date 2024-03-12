/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.lightitup.servlets;

import com.lightitup.dao.UserDao;
import com.lightitup.entities.User;
import com.lightitup.dao.ProductDao;
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
      HttpSession httpSession = request.getSession();
      String[] prodIds = request.getParameterValues("prodId");
      int userId = Integer.parseInt(request.getParameter("userId"));
      String[] cartQtys = request.getParameterValues("cart-qty");
      int minLength = Math.min(prodIds.length, cartQtys.length);

      OrderTable newOrder = null;
      UserDao userDao = new UserDao(FactoryProvider.getFactory());
      User currentUser = userDao.getUserById(userId);
      ProductDao productDao = new ProductDao(FactoryProvider.getFactory());
      OrderDao orderDao = new OrderDao(FactoryProvider.getFactory());
      int count = 0;
      double total = 0;
      for (int i = 0; i < minLength; i++) {
        int productId = Integer.parseInt(prodIds[i]);
        int qty = Integer.parseInt(cartQtys[i]);
        Product addProduct = productDao.getProductById(productId);
        newOrder.setOrderProduct(addProduct);
        newOrder.setOrderUser(currentUser);
        newOrder.setQuantity(qty);
        newOrder.setStatus("pending");
        newOrder.setPayment("unpaid");
        newOrder.setTotal(addProduct.getPriceAfterDiscount() * qty);
        total += newOrder.getTotal();
        boolean added = orderDao.addNewOrder(newOrder);
        if (added == true) {
          count++;
          //add cartDao to delete the checked out item through prodId and userId
        } else {
          count--;
        }
      }
      if (count == minLength) {
        httpSession.setAttribute("message", "Order Placed!");
        httpSession.setAttribute("total", total);
        response.sendRedirect("checkout.jsp");
      } else {
        httpSession.setAttribute("message", "Error in placing Order!");
        response.sendRedirect("cart.jsp");
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
