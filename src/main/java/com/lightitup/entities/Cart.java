package com.lightitup.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name="Cart")
public class Cart {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int cId;
  private int quantity;
  private double total;
  private String checkout;
  @ManyToOne
  //will create a new column for user
  private User cartUser;
  @ManyToOne
  //create new column for product of user
  private Product cartProduct;

  public Cart() {
  }

  public Cart(int cId, int quantity, double total, String checkout, User cartUser, Product cartProduct) {
    this.cId = cId;
    this.quantity = quantity;
    this.total = total;
    this.checkout = checkout;
    this.cartUser = cartUser;
    this.cartProduct = cartProduct;
  }

  public Cart(int quantity, double total, String checkout, User cartUser, Product cartProduct) {
    this.quantity = quantity;
    this.total = total;
    this.checkout = checkout;
    this.cartUser = cartUser;
    this.cartProduct = cartProduct;
  }

  public int getcId() {
    return cId;
  }

  public void setcId(int cId) {
    this.cId = cId;
  }

  public int getQuantity() {
    return quantity;
  }

  public void setQuantity(int quantity) {
    this.quantity = quantity;
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

  public User getCartUser() {
    return cartUser;
  }

  public void setCartUser(User cartUser) {
    this.cartUser = cartUser;
  }

  public Product getCartProduct() {
    return cartProduct;
  }

  public void setCartProduct(Product cartProduct) {
    this.cartProduct = cartProduct;
  }

  @Override
  public String toString() {
    return "Cart{" + "cId=" + cId + ", quantity=" + quantity + ", total=" + total + ", checkout=" + checkout + ", cartUser=" + cartUser + ", cartProduct=" + cartProduct + '}';
  }
  
  

}