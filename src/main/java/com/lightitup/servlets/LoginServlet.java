package com.lightitup.servlets;

import com.lightitup.dao.UserDao;
import com.lightitup.entities.User;
import com.lightitup.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

  //  use processRequest as both post and get will call it
  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
      /* TODO output your page here. You may use following sample code. */
      HttpSession httpSession = request.getSession();
      try {
        if (httpSession.getAttribute("logged_user") != null) {
          User alreadyLogged = (User) httpSession.getAttribute("logged_user");
//          response.sendRedirect("index.jsp");
          if (alreadyLogged.getUserType().equals("admin")) {
            //admin.jsp
            response.sendRedirect("admin.jsp");
          } else if (alreadyLogged.getUserType().equals("customer")) {
            //client.jsp
            response.sendRedirect("customer.jsp");
          } else {
          }
        }
      } catch (Exception e) {
        //print error in console
        e.printStackTrace();
      }
      try {
        //get request from form
        String userEmail = request.getParameter("user_email");
        String userPassword = request.getParameter("user_password");
        // validations
        if (userEmail.isEmpty()) {
          out.println("Email Cannot be blank");
        }
        //creating new user object to fetch data
        //authenticatoion dao layer (data access object)
        UserDao userDao = new UserDao(FactoryProvider.getFactory());
        User logged_user = userDao.getUserByEmailandPass(userEmail, userPassword);
        if (logged_user == null) {
          httpSession.setAttribute("message", "Unsuccessful. Please Try Again!");
          // ("key", "value");
          response.sendRedirect("login.jsp");
          return;
        } else {
          httpSession.setAttribute("logged_user", logged_user);
//          response.sendRedirect("index.jsp");
          if (logged_user.getUserType().equals("admin")) {
            //admin.jsp
            response.sendRedirect("admin.jsp");
          } else if (logged_user.getUserType().equals("customer")) {
            //client.jsp
            response.sendRedirect("customer.jsp");
          } else {
            out.println("Error identifying user");
          }
        }
      } catch (Exception e) {
        //print error in console
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
