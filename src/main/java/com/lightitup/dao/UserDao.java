package com.lightitup.dao;

//authenticatoion dao layer (data access object)
import com.lightitup.entities.User;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

public class UserDao {

  private SessionFactory factory;

  public UserDao(SessionFactory factory) {
    this.factory = factory;
  }

  //get user by email and password 
  public User getUserByEmailandPass(String email, String pass) {
    User user = null;
    try {
      //using Hibernate Query HQL
      String query = "From User WHERE userEmail = :e AND userPassword = :p";
      Session session = this.factory.openSession();
//      Query q = session.createQuery(query);
//      
//      q.setParameter("e", email);
//      q.setParameter("p", pass);
//      q.executeUpdate();
//      user = (User)q.uniqueResult();
      List<User> results = session.createQuery(query, User.class)
              .setParameter("e", email)
              .setParameter("p", pass)
              .getResultList();
      if (!results.isEmpty()) {
        user = results.get(0);//returns single user object(row)
      }
      session.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
    return user;
  }

  public List<User> getUserByType(String type) {
    Session s = this.factory.openSession();
    Query q = s.createQuery("count(*) as Num From User WHERE userType = :type", User.class);
    q.setParameter("type", type);
    List<User> list = q.list();
    return list;
  }

}
