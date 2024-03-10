
package com.lightitup.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;

@Entity
@Table(name="OrderTable")
public class OrderTable {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int Id;
  private int quantity;
  private double total;
  private String status;
  @ManyToOne
  private User orderUser;
  @ManyToOne
  private Product orderProduct;
  
  public OrderTable() {
  }

  public OrderTable(int Id, int quantity, double total, String status, User orderUser, Product orderProduct) {
    this.Id = Id;
    this.quantity = quantity;
    this.total = total;
    this.status = status;
    this.orderUser = orderUser;
    this.orderProduct = orderProduct;
  }

  public OrderTable(int quantity, double total, String status, User orderUser, Product orderProduct) {
    this.quantity = quantity;
    this.total = total;
    this.status = status;
    this.orderUser = orderUser;
    this.orderProduct = orderProduct;
  }

  public int getId() {
    return Id;
  }

  public void setId(int Id) {
    this.Id = Id;
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

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public User getOrderUser() {
    return orderUser;
  }

  public void setOrderUser(User orderUser) {
    this.orderUser = orderUser;
  }

  public Product getOrderProduct() {
    return orderProduct;
  }

  public void setOrderProduct(Product orderProduct) {
    this.orderProduct = orderProduct;
  }

  @Override
  public String toString() {
    return "OrderTable{" + "Id=" + Id + ", quantity=" + quantity + ", total=" + total + ", status=" + status + ", orderUser=" + orderUser + ", orderProduct=" + orderProduct + '}';
  }
  
  

}
