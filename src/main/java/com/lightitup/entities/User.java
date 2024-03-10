package com.lightitup.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;

@Entity
public class User {

  //primary key gerenrated value gives AutoIncrement
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(length = 10, name = "userId")
  private int userId;
  @Column(length = 100, name = "userName")
  private String userName;
  @Column(length = 100, name = "userEmail")
  private String userEmail;
  @Column(length = 1000, name = "userPassword")
  private String userPassword;
  @Column(length = 12, name = "userPhone")
  private String userPhone;
  @Column(length = 1500, name = "userPic")
  private String userPic;
  //specify lenght of column name
  @Column(length = 1500, name = "userAddress")
  private String userAddress;
  @Column(length = 1500, name = "userType")
  private String userType;

  @OneToMany(mappedBy = "cartUser")
  private List<Cart> cart = new ArrayList<>();
  @OneToMany(mappedBy = "orderUser")
  private List<OrderTable> orderTable = new ArrayList<>();

  public User() {
  }

  public User(int userId, String userName, String userEmail, String userPassword, String userPhone, String userPic, String userAddress, String userType) {
    this.userId = userId;
    this.userName = userName;
    this.userEmail = userEmail;
    this.userPassword = userPassword;
    this.userPhone = userPhone;
    this.userPic = userPic;
    this.userAddress = userAddress;
    this.userType = userType;
  }

  public User(String userName, String userEmail, String userPassword, String userPhone, String userPic, String userAddress, String userType) {
    this.userName = userName;
    this.userEmail = userEmail;
    this.userPassword = userPassword;
    this.userPhone = userPhone;
    this.userPic = userPic;
    this.userAddress = userAddress;
    this.userType = userType;
  }
  

  public int getUserId() {
    return userId;
  }

  public void setUserId(int userId) {
    this.userId = userId;
  }

  public String getUserName() {
    return userName;
  }

  public void setUserName(String userName) {
    this.userName = userName;
  }

  public String getUserEmail() {
    return userEmail;
  }

  public void setUserEmail(String userEmail) {
    this.userEmail = userEmail;
  }

  public String getUserPassword() {
    return userPassword;
  }

  public void setUserPassword(String userPassword) {
    this.userPassword = userPassword;
  }

  public String getUserPhone() {
    return userPhone;
  }

  public void setUserPhone(String userPhone) {
    this.userPhone = userPhone;
  }

  public String getUserPic() {
    return userPic;
  }

  public void setUserPic(String userPic) {
    this.userPic = userPic;
  }

  public String getUserAddress() {
    return userAddress;
  }

  public void setUserAddress(String userAddress) {
    this.userAddress = userAddress;
  }

  public String getUserType() {
    return userType;
  }

  public void setUserType(String userType) {
    this.userType = userType;
  }

  public List<Cart> getCart() {
    return cart;
  }

  public void setCart(List<Cart> cart) {
    this.cart = cart;
  }

  public List<OrderTable> getOrderTable() {
    return orderTable;
  }

  public void setOrderTable(List<OrderTable> orderTable) {
    this.orderTable = orderTable;
  }

}
