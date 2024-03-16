package com.lightitup.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

public class Initiate extends HttpServlet {

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
      String url = "https://a.khalti.com/api/v2/epayment/initiate/";
      String return_url = request.getParameter("return_url");
      String purchase_order_id = request.getParameter("purchase_order_id");
      String purchase_order_name = "name" + purchase_order_id;
      String am = request.getParameter("amount");
      String username = request.getParameter("username");
      String userEmail = request.getParameter("userEmail");
      String userPhone = request.getParameter("userPhone");
//      String username = ; 
//      String userEmail = "avipsa.joshi@gmail.com"; 
//      String userPhone = "9840789960"; 
      String totalAmountStr = am.replaceAll("[^\\d.]", ""); // Remove non-numeric characters
      double amount = Double.parseDouble(totalAmountStr);
      String payload = "{\"return_url\":\"" + return_url + ",\"website_url\":\"http://localhost:9080\",\"amount\":" + amount + ",\"purchase_order_id\":\"" + purchase_order_id + "\",\"purchase_order_name\":\"" + purchase_order_name + "\",\"customer_info\":{\"name\":\"" + username + "\",\"email\":\"" + userEmail + "\",\"phone\":\"" + userPhone + "\"}}";
      String testkey = "key a7d08a7866c04958b986d77d0daf28a2";
      String headers = "{'Authorization': '" + testkey + "','Content-Type': 'application/json',}";
      try {
        URL apiUrl = new URL(url);
        HttpURLConnection connection = (HttpURLConnection) apiUrl.openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Authorization", testkey);
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setDoOutput(true);
        try (DataOutputStream outputStream = new DataOutputStream(connection.getOutputStream())) {
          outputStream.writeBytes(payload);
          outputStream.flush();
        }
      } catch (IOException e) {
        e.printStackTrace();
        // Handle exceptions
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
