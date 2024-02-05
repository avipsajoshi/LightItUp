package com.lightitup.dao;



//authenticatoion dao layer (data access object)

import com.lightitup.entities.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

public class UserDao {
  private SessionFactory factory;

  public UserDao(SessionFactory factory) {
    this.factory = factory;
  }
  //get user by email and password 
  public User getUserByEmailandPass(String email, String pass){
    User user = null;
    try{
      //using Hibernate Query HQL
      String query ="from User where userEmail =: e and userPassword =: p";
      Session session = this.factory.openSession();
      Query q = session.createQuery(query);
      
      q.setParameter("e", email);
      q.setParameter("p", pass);
      q.executeUpdate();
      user = (User) q.uniqueResult();
    }
    catch(Exception e){
      e.printStackTrace();
    }
    return user;
  }
}
