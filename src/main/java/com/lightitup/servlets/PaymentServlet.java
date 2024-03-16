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
import java.net.HttpURLConnection;
import java.net.URL;

/**
 *
 * @author Dell
 */
public class PaymentServlet extends HttpServlet {

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
   try (PrintWriter out = response.getWriter()) {
      String url = "https://a.khalti.com/api/v2/epayment/initiate/";
      String return_url = request.getParameter("return_url"); 
      String purchase_order_id = request.getParameter("purchase_order_id"); 
      String purchase_order_name = "name"+purchase_order_id; 
      String am = request.getParameter("amount"); 
      Double amount = Double.parseDouble(am);
      String payload = "{\"return_url\":\""+return_url+",\"website_url\":\"http://localhost:9080\",\"amount\":"+amount+",\"purchase_order_id\":\""+purchase_order_id+"\",\"purchase_order_name\":\""+purchase_order_name+"\"}";
      String testkey = "59d6e256a2df425995429ec2ae7b0245";
      String headers = "{'Authorization': '"+testkey+"','Content-Type': 'application/json',}";
      try {
        URL apiUrl = new URL(url);
        HttpURLConnection connection = (HttpURLConnection) apiUrl.openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Authorization", testkey);
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setDoOutput(false);
      }catch(IOException e){
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
