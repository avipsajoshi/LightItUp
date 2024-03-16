/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.lightitup.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.lightitup.dao.UserDao;
import com.lightitup.entities.User;
import com.lightitup.dao.ProductDao;
import com.lightitup.entities.Product;

public class CartCheckoutServlet2 extends HttpServlet {

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
      // Read the JSON data sent in the request body
//      BufferedReader reader = request.getReader();
//      String requestBody = reader.lines().collect(Collectors.joining(System.lineSeparator()));
      String data = request.getQueryString();
      out.println(data);
      try {
        int[][] cartQtyArray = new int[10][2]; // Assuming maximum 10 cart-qty values

        // Split the data on "&" to get individual key-value pairs
        String[] keyValuePairs = data.split("&");

        // Extract userId
        int userId = -1; // Default value for user ID
        for (String pair : keyValuePairs) {
          String[] parts = pair.split("=");
          String key = parts[0];
          String value = parts.length > 1 ? parts[1] : "";

          if (key.equals("userId")) {
            userId = Integer.parseInt(value);
          }
          if (key.startsWith("cartqty-")) {
            String[] subparts = key.split("-");
            int index = Integer.parseInt(subparts[1]);
            int productId = index;
            int quantity = Integer.parseInt(value);
            cartQtyArray[index - 1][0] = productId;
            cartQtyArray[index - 1][1] = quantity;
          }
        }
        // For example, print the values
        out.println("User ID: " + userId + "<br>");
        for(int i = 0; i < cartQtyArray.length; i++) {
          if(cartQtyArray[i][1]!=0 ){
          int productId = cartQtyArray[i][0];
          int quantity = cartQtyArray[i][1];
          out.println("Product ID: " + productId + ", Quantity: " + quantity + "<br>");
          }
        }

      } catch(Exception e) {
        e.printStackTrace();
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
