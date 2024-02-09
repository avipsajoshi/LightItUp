
package com.lightitup.dao;


import com.lightitup.entities.Product;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class ProductDao {
  private SessionFactory factory;

  public ProductDao(SessionFactory factory) {
    this.factory = factory;
  }
  
  //save to product table
  public boolean addProduct(Product item) {
    boolean f = false;
    try{
      Session session = this.factory.openSession();
      Transaction tx = session.beginTransaction();
      session.persist(item);
      tx.commit();
      session.close();
      f=true;
    }
    catch(Exception e){
      e.printStackTrace();
      f = false;
    }
    return f;
  }
}
