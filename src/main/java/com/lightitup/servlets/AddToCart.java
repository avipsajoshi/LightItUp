package com.lightitup.servlets;

import com.lightitup.dao.CartDao;
import com.lightitup.dao.ProductDao;
import com.lightitup.entities.Cart;
import com.lightitup.entities.Product;
import com.lightitup.entities.User;
import com.lightitup.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AddToCart extends HttpServlet {

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
            try {
              String productID = request.getParameter("productId");
              if (productID.isEmpty()) {
                httpSession.setAttribute("message", "Unsuccessful. Please Try Again!");
                response.sendRedirect("dashboard.jsp");
              } else {
                Cart cart = new Cart();
                CartDao cart1 = new CartDao(FactoryProvider.getFactory());
                int prodId = Integer.parseInt(productID);
                String fromWhere = request.getParameter("fromWhere");
                if (fromWhere.trim().equals("dashboard")) {
                  boolean existing = cart1.checkCartItemByUserIdAndProductId(alreadyLogged.getUserId(), prodId);
                  if (existing == true) {
                    Cart cartToUpdate = cart1.getCartItemByUserIdAndProductId(alreadyLogged.getUserId(), prodId);
                    boolean updated = cart1.updateCart(cartToUpdate, cartToUpdate.getQuantity() + 1);
                    if (updated == true) {
                      httpSession.setAttribute("message", "Product Added to Cart!");
                    } else {
                      httpSession.setAttribute("message", "Error Adding Product to Cart. Please Try again!");
                    }
                  } else {
                    cart.setQuantity(1);
                    ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
                    Product productitem = pdao.getProductById(prodId);
                    cart.setCartProduct(productitem);
                    cart.setCartUser(alreadyLogged);
                    cart.setCheckout("not checked out");
                    cart.setTotal(productitem.getPriceAfterDiscount());
                    CartDao cartDao = new CartDao(FactoryProvider.getFactory());
                    boolean added = cartDao.addCart(cart);
                    if (added == true) {
                      httpSession.setAttribute("message", "Product Added to Cart!");
                    } else {
                      httpSession.setAttribute("message", "Error Adding Product to Cart. Please Try again!");
                    }
                  }
                } else if (fromWhere.trim().equals("view")) {
                  String newQty = request.getParameter("view-qty");
                  int qty = Integer.parseInt(newQty);
                  boolean existing = cart1.checkCartItemByUserIdAndProductId(alreadyLogged.getUserId(), prodId);
                  if (existing == true) {
                    Cart cartToUpdate = cart1.getCartItemByUserIdAndProductId(alreadyLogged.getUserId(), prodId);
                    boolean updated = cart1.updateCart(cartToUpdate, cartToUpdate.getQuantity() + qty);
                    if (updated == true) {
                      httpSession.setAttribute("message", "Product Added to Cart!");
                    } else {
                      httpSession.setAttribute("message", "Error Adding Product to Cart. Please Try again!");
                    }
                  } else {
                    cart.setQuantity(qty);
                    ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
                    Product productitem = pdao.getProductById(prodId);
                    cart.setCartProduct(productitem);
                    cart.setCartUser(alreadyLogged);
                    cart.setCheckout("not checked out");
                    cart.setTotal(productitem.getPriceAfterDiscount());
                    CartDao cartDao = new CartDao(FactoryProvider.getFactory());
                    boolean added = cartDao.addCart(cart);
                    if (added == true) {
                      httpSession.setAttribute("message", "Product Added to Cart!");
                    } else {
                      httpSession.setAttribute("message", "Error Adding Product to Cart. Please Try again!");
                    }
                  }
                }
              }
            } catch (Exception e) {
              //print error in console
              e.printStackTrace();
            }
            response.sendRedirect("dashboard.jsp");
          } else {
          }
        } else {
          httpSession.setAttribute("message", "Please Login First");
          response.sendRedirect("./login.jsp");
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
