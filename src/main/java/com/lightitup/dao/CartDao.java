package com.lightitup.dao;

import com.lightitup.entities.Cart;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class CartDao {

  private SessionFactory factory;

  public CartDao(SessionFactory factory) {
    this.factory = factory;
  }

  //save the category to db
  public boolean addCart(Cart cart) {
    boolean f = false;
    try {
      Session session = this.factory.openSession();
      Transaction tx = session.beginTransaction();
      session.persist(cart);
      tx.commit();
      session.close();
      f = true;
    } catch (Exception e) {
      e.printStackTrace();
      f = false;
    }
    return f;
  }

  public boolean deleteCart(Cart cart) {
    boolean f = false;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      Cart cat = session.get(Cart.class, cart.getcId());
      if (cat != null) {
        // Step 2: Delete the object from the database
        session.remove(cat);
        session.getTransaction().commit();
        tx.commit();
      }
      f = true;
    } catch (HibernateException e) {
      e.printStackTrace();
      session.getTransaction().rollback();
      f = false;
    }

    session.close();
    return f;
  }

  public boolean updateCart(Cart cart, int qty) {
    boolean f = false;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      Cart cat = session.get(Cart.class, cart.getcId());
      Query query = session.createQuery("from Cart as c SET c.qty = :newQty WHERE c.Id = :cartId", Cart.class);
      if (cat != null) {
        query.setParameter("cartId", cat.getcId());
      }
      query.setParameter("newQty", qty);

      // Execute the update query
      int rowCount = query.executeUpdate();
      System.out.println("Rows affected: " + rowCount);

      session.getTransaction().commit();
      tx.commit();
      f = true;
    } catch (HibernateException e) {
      e.printStackTrace();
      session.getTransaction().rollback();
      f = false;
    }
    session.close();
    return f;
  }

}
