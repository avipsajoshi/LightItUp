package com.lightitup.dao;

import com.lightitup.entities.Category;
import com.lightitup.entities.Product;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class CategoryDao {

  private SessionFactory factory;

  public CategoryDao(SessionFactory factory) {
    this.factory = factory;
  }

  //save the category to db
  public boolean addCategory(Category cat) {
    boolean f = false;
    try {
      Session session = this.factory.openSession();
      Transaction tx = session.beginTransaction();
      session.persist(cat);
      tx.commit();
      session.close();
      f = true;
    } catch (Exception e) {
      e.printStackTrace();
      f = false;
    }
    return f;
  }

  public List<Category> getAllCategory() {
    Session s = this.factory.openSession();
    List<Category> listOfCategorys = s.createQuery("From Category", Category.class).list();
    s.close();
    return listOfCategorys;
  }

  public Category getCategoryById(int categoryId) {
    Category cat = null;
    try {
      Session session = this.factory.openSession();
      //use get or load - get will return null value
      cat = session.get(Category.class, categoryId);
      session.close();
    } catch (Exception w) {
      w.printStackTrace();
    }
    return cat;
  }

  public int getNumberOfProductsInCategory(int categoryId) {
    int num = 0;
    try {
      Session session = this.factory.openSession();
      Query pq = session.createQuery("from Product where p.category.categoryId =:catid", Product.class);
      pq.setParameter("catid", categoryId);
      List<Product> list = pq.list();
      num=list.size();
      session.close();
    } catch (Exception w) {
      w.printStackTrace();
    }
    return num;
  }

}
