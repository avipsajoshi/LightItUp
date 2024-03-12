package com.lightitup.dao;

import com.lightitup.entities.Category;
import com.lightitup.entities.Product;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class ProductDao {

  private SessionFactory factory;

  public ProductDao(SessionFactory factory) {
    this.factory = factory;
  }

  //save to product table
  public boolean addProduct(Product item) {
    boolean f = false;
    try {
      Session session = this.factory.openSession();
      Transaction tx = session.beginTransaction();
      session.persist(item);
      tx.commit();
      session.close();
      f = true;
    } catch (Exception e) {
      e.printStackTrace();
      f = false;
    }
    return f;
  }

  public List<Product> getAllProducts() {
    Session s = this.factory.openSession();
    Query q = s.createQuery("from Product as p Order By p.category.categoryId ASC", Product.class);
    List<Product> list = q.list();
    return list;
  }

  public List<Product> getProductsByCategory() {
    Session s = this.factory.openSession();
    Query cq = s.createQuery("from Category", Category.class);
    List<Category> cat_list = cq.list();
    List<Product> list = new ArrayList();
    for (Category c : cat_list) {
      //retrieve product according to category
      Query pq = s.createQuery("from Product as p Where p.category.categoryId= :catid", Product.class).setParameter("catid", c.getCategoryId());
      List<Product> list1 = pq.list();
      //add each product from retrieved list to final list
      for (Product p : list1) {
        list.add(p);
      }
    }
    return list;
  }

  public List<Product> getProductsByCategoryId(int cid) {
    Session s = this.factory.openSession();
    Query pq = s.createQuery("from Product as p where p.category.categoryId =:catid", Product.class);
    pq.setParameter("catid", cid);
    List<Product> list = pq.list();
    return list;
  }

  public List<Product> getProductsById(int productId) {
    Session s = this.factory.openSession();
    Query pq = s.createQuery("from Product as p where p.pId =:pid", Product.class);
    pq.setParameter("pid", productId);
    List<Product> list = pq.list();
    return list;
  }

  public Product getProductById(int productId) {
    Product p = null;
    try {
      Session session = this.factory.openSession();
      Query pq = session.createQuery("from Product as p WHERE p.pId =:pid", Product.class);
      pq.setParameter("pid", productId);
      List<Product> list = pq.list();
      if (!list.isEmpty()) {
        p = list.get(0);//returns single user object(row)
      }
      session.close();
    } catch (Exception w) {
      w.printStackTrace();

    }
    return p;
  }

  public List<Product> getProductsBySearch(String searchname) {
    Session s = this.factory.openSession();
    Query pq = s.createQuery("from Product where pName LIKE %:search%", Product.class);
    pq.setParameter("search", searchname);
    List<Product> list = pq.list();
    return list;
  }
}
