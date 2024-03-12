package com.lightitup.dao;

import com.lightitup.entities.Cart;
import com.lightitup.entities.OrderTable;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class OrderDao {

  private SessionFactory factory;

  public OrderDao(SessionFactory factory) {
    this.factory = factory;
  }

  //save the category to db
  public boolean addNewOrder(OrderTable order) {
    boolean f = false;
    try {
      Session session = this.factory.openSession();
      Transaction tx = session.beginTransaction();
      session.persist(order);
      tx.commit();
      session.close();
      f = true;
    } catch (Exception e) {
      e.printStackTrace();
      f = false;
    }
    return f;
  }

  public boolean cancelFromOrder(OrderTable or, int uid, int pid) {
    boolean f = false;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      OrderTable temp_order = session.get(OrderTable.class, or.getId());
      Query query = session.createQuery("DELETE from OrderTable as o WHERE o.Id = :orderId and o.user.userId = :uid and o.product.pId = :pid", OrderTable.class);
      if (temp_order != null) {
        query.setParameter("cartId", temp_order.getId());
      }
      query.setParameter("uid", uid);
      query.setParameter("pid", pid);
      int rowCount = query.executeUpdate();
      System.out.println("Rows affected: " + rowCount);
      if (rowCount >= 1) {
        f = true;
      }
    } catch (HibernateException e) {
      e.printStackTrace();
      session.getTransaction().rollback();
      f = false;
    }

    session.close();
    return f;
  }

  public boolean updateOrderByAdmin(OrderTable or, int uid, int pid) {
    boolean f = false;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      OrderTable temp_order = session.get(OrderTable.class, or.getId());
      Query query = session.createQuery("Update OrderTable as o SET o.status = 'completed' WHERE o.Id = :orderId and o.user.userId = :uid and o.product.pId = :pid", OrderTable.class);
      if (temp_order != null) {
        query.setParameter("cartId", temp_order.getId());
      }
      query.setParameter("uid", uid);
      query.setParameter("pid", pid);
      int rowCount = query.executeUpdate();
      System.out.println("Rows affected: " + rowCount);
      if (rowCount >= 1) {
        f = true;
      }
    } catch (HibernateException e) {
      e.printStackTrace();
      session.getTransaction().rollback();
      f = false;
    }
    session.close();
    return f;
  }
  public boolean updateOrderByPayment(OrderTable or, int uid, int pid) {
    boolean f = false;
    Session session = this.factory.openSession();
    Transaction tx = session.beginTransaction();
    try {
      OrderTable temp_order = session.get(OrderTable.class, or.getId());
      Query query = session.createQuery("Update OrderTable as o SET o.payment = 'paid' WHERE o.Id = :orderId and o.user.userId = :uid and o.product.pId = :pid", OrderTable.class);
      if (temp_order != null) {
        query.setParameter("cartId", temp_order.getId());
      }
      query.setParameter("uid", uid);
      query.setParameter("pid", pid);
      int rowCount = query.executeUpdate();
      System.out.println("Rows affected: " + rowCount);
      if (rowCount >= 1) {
        f = true;
      }
    } catch (HibernateException e) {
      e.printStackTrace();
      session.getTransaction().rollback();
      f = false;
    }
    session.close();
    return f;
  }
  public List<OrderTable> getAllOrders() {
    Session s = this.factory.openSession();
    Query q = s.createQuery("from OrderTable", OrderTable.class);
    List<OrderTable> list = q.list();
    return list;
  }

  public List<OrderTable> getOrdersByUser(int userId) {
    Session s = this.factory.openSession();
    Query q = s.createQuery("from OrderTable as ot WHERE ot.orderUser.userId = :uid Order By user ASC", OrderTable.class);
    q.setParameter("uid", userId);
    List<OrderTable> list = q.list();
    return list;
  }

  public List<OrderTable> getOrdersByCategory(int catId) {
    Session s = this.factory.openSession();
    Query q = s.createQuery("from OrderTable as ot WHERE ot.orderProduct.category.categoryId = :cid Order By user ASC", OrderTable.class);
    q.setParameter("cid", catId);
    List<OrderTable> list = q.list();
    return list;
  }
  
  public List<OrderTable> getOrdersByProduct(int catId) {
    Session s = this.factory.openSession();
    Query q = s.createQuery("from OrderTable as ot WHERE ot.orderProduct.pId = :cid Order By user ASC", OrderTable.class);
    q.setParameter("cid", catId);
    List<OrderTable> list = q.list();
    return list;
  }

  public List<OrderTable> getOrdersByStatus(String status) {
    Session s = this.factory.openSession();
    Query q = s.createQuery("from OrderTable WHERE status = :st Order By status DESC", OrderTable.class);
    q.setParameter("st", status);
    List<OrderTable> list = q.list();
    return list;
  }

}
