package com.lightitup.dao;

import com.lightitup.entities.Category;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

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
    List<Category> listOfCategorys = s.createQuery("from Category", Category.class).list();
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

}
