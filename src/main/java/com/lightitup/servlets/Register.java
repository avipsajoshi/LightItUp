
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
import org.hibernate.Session;
import org.hibernate.Transaction;

public class Register extends HttpServlet {

//  use processRequest as both post and get will call it
  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
      /* TODO output your page here. You may use following sample code. */
      try{
        String userName = request.getParameter("user_name");
        String userEmail = request.getParameter("user_email");
        String userPhone = request.getParameter("user_phone");
        String userAddress = request.getParameter("user_address");
        String userPassword = request.getParameter("user_password");
      // validations
      if(userName.isEmpty()){
        out.println("Name Cannot be blank");
      }
      //creating new user object to store in db
      User user =new User(userName, userEmail, userPassword, userPhone, "./images/user.png", userAddress, "customer");
      
      //if using JDBC put code here
      //open session 
      Session hibernateSession = FactoryProvider.getFactory().openSession();
        //first open transaction which will help us save work (ACID property of DB)
        Transaction tx = hibernateSession.beginTransaction();
        //save will take an object and saves data in user table return an id (same with persist but it doesnot return anything)
//        int userId = (int) hibernateSession.save(user);
        hibernateSession.persist(user);
        //commit the changes
        tx.commit();
      hibernateSession.close();
      
        // store message in HTTP session ( an object that can store value temporarily) (basically just session object)
        HttpSession httpSession = request.getSession();
        // if more than one value needs to be sent, make an object of the httpSession and sent it if not:
        if(httpSession == null){
          httpSession.setAttribute("message", "Unsuccessful. Please Try Again");
        // ("key", "value");
          response.sendRedirect("register.jsp"); // redirects to page
        }
        else{
          httpSession.setAttribute("logged_user",user);
          response.sendRedirect("./LoginServlet");
        }
        return; //so that code below this is not executed
      }
      catch(Exception e){
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
