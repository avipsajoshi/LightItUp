/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.lightitup.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Dell
 */
public class VerifyServlet extends HttpServlet {

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
      /* TODO output your page here. You may use following sample code. */
      // Retrieving parameters from the request
        String transactionId = request.getParameter("transaction_id");
        String totalAmount = request.getParameter("total_amount");
        // Generating HTML response
        StringBuilder htmlResponse = new StringBuilder();
        htmlResponse.append("<html>");
        htmlResponse.append("<head><title>Payment Successful!</title></head>");
        htmlResponse.append("<body>");
        htmlResponse.append("<div class=\"success-container\">");
        htmlResponse.append("<h1>Payment Successful!</h1>");
        htmlResponse.append("<p>Transaction ID : <b>").append(transactionId).append("</b></p><br/>");
        htmlResponse.append("<p>Amount: <b>").append(totalAmount).append("</b></p><br/>");
        htmlResponse.append("<a href=\"dashboard.jsp\">Okay</a>");
        htmlResponse.append("</div>");
        htmlResponse.append("</body>");
        htmlResponse.append("</html>");
        
        // Sending the HTML response
        response.setContentType("text/html");
        response.getWriter().println(htmlResponse.toString());
        
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
