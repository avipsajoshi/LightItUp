package com.lightitup.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;

@Entity
public class Cart {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int cId;
  private int quantity;
  private double total;
  private String checkout;
  @ManyToMany
  //will create new column
  private User user;
  @ManyToMany
  private Product product;

  public Cart() {
  }
  public Cart(int cId, int quantity, double total, String checkout, User user, Product product) {
    this.cId = cId;
    this.quantity = quantity;
    this.total = total;
    this.checkout = checkout;
    this.user = user;
    this.product = product;
  }

  public Cart(int quantity, double total, String checkout, User user, Product product) {
    this.quantity = quantity;
    this.total = total;
    this.checkout = checkout;
    this.user = user;
    this.product = product;
  }
  public int getQuantity() {
    return quantity;
  }

  public void setQuantity(int quantity) {
    this.quantity = quantity;
  }
  

  public int getcId() {
    return cId;
  }

  public void setcId(int cId) {
    this.cId = cId;
  }

  public double getTotal() {
    return total;
  }

  public void setTotal(double total) {
    this.total = total;
  }

  public String getCheckout() {
    return checkout;
  }

  public void setCheckout(String checkout) {
    this.checkout = checkout;
  }

  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }

  public Product getProduct() {
    return product;
  }

  public void setProduct(Product product) {
    this.product = product;
  }
  
  

}