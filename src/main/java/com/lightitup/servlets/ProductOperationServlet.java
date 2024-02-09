package com.lightitup.servlets;

import com.lightitup.dao.CategoryDao;
import com.lightitup.dao.ProductDao;
import com.lightitup.entities.Category;
import com.lightitup.entities.Product;
import com.lightitup.helper.FactoryProvider;
import jakarta.servlet.ServletContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;

//a multipart configuration data accept
@MultipartConfig
public class ProductOperationServlet extends HttpServlet {

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
      //fetch operation value
      String operation = request.getParameter("operationType");
      if (operation.trim().equals("1")) {
        //add category
        //fetching category data
        String title = request.getParameter("category-name");
        String description = request.getParameter("category-description");
        Category category = new Category();
        category.setCategoryTitle(title);
        category.setCategoryDescription(description);

        //save this to database through CategoryDao
        CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());

        boolean isAdded = categoryDao.addCategory(category);
        HttpSession session = request.getSession();
        if (isAdded == true) {
          session.setAttribute("message", "Category Added Successfully!");
          response.sendRedirect("admin.jsp");
        }
        else{
          session.setAttribute("message", "Error Adding Category. Please Try again!");
          response.sendRedirect("admin.jsp");
        }
      } 
      //PRODUCT OPERATION -------------
      else if (operation.trim().equals("2")) {
        //add product
        String pName = request.getParameter("product-name");
        String pDesc = request.getParameter("product-description");
        Double pPrice = Double.parseDouble(request.getParameter("product-price"));
        Double pDiscount = Double.parseDouble(request.getParameter("product-discount"));
        int pQty = Integer.parseInt(request.getParameter("product-quantity"));
        int catId = Integer.parseInt(request.getParameter("catId"));
        //to get file 
        Part file = request.getPart("product-image");
        Product product = new Product();
        product.setpName(pName);
        product.setpDescription(pDesc);
        product.setpPrice(pPrice);
        product.setpQuantity(pQty);
        product.setpDiscount(pDiscount);
        //saving photo to path "product-images"
        ServletContext context = request.getServletContext();
        String path = context.getRealPath("/images/")+File.separator+"product-images";
        product.setpPhoto(file.getSubmittedFileName());
        
//getting categoryto set category column with the object 
        CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
        Category productcategory = cdao.getCategoryById(catId);
        product.setCategory(productcategory);
       
        //save this to database through ProductDao
        ProductDao productDao = new ProductDao(FactoryProvider.getFactory());
        boolean added = productDao.addProduct(product);
        HttpSession session = request.getSession();

        if (added == true) {
          session.setAttribute("message", "Product Added Successfully!");
          response.sendRedirect("admin.jsp");
        }
        else{
          session.setAttribute("message", "Error Adding Product. Please Try again!");
          response.sendRedirect("admin.jsp");
        
        }
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
