
package com.lightitup.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;

@Entity
public class Product {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY )
  private int pId;
  private String pName;
  @Column(length=3000)
  private String pDescription;
  private String pPhoto;
  private double pPrice;
  private double pDiscount;
  private int pQuantity;
  @ManyToOne
  //will create new column
  private Category category;

  public Product() {
  }

//  public Product(int pId, String pName, String pDescription, String pPhoto, double pPrice, double pDiscount, int pQuantity) {
//    this.pId = pId;
//    this.pName = pName;
//    this.pDescription = pDescription;
//    this.pPhoto = pPhoto;
//    this.pPrice = pPrice;
//    this.pDiscount = pDiscount;
//    this.pQuantity = pQuantity;
//  }

  public Product(String pName, String pDescription, String pPhoto, double pPrice, double pDiscount, int pQuantity, Category category ) {
    this.pName = pName;
    this.pDescription = pDescription;
    this.pPhoto = pPhoto;
    this.pPrice = pPrice;
    this.pDiscount = pDiscount;
    this.pQuantity = pQuantity;
    this.category = category;
  }

  //getter setter methods for variables
  public int getpId() {
    return pId;
  }

  public void setpId(int pId) {
    this.pId = pId;
  }

  public String getpName() {
    return pName;
  }

  public void setpName(String pName) {
    this.pName = pName;
  }

  public String getpDescription() {
    return pDescription;
  }

  public void setpDescription(String pDescription) {
    this.pDescription = pDescription;
  }

  public String getpPhoto() {
    return pPhoto;
  }

  public void setpPhoto(String pPhoto) {
    this.pPhoto = pPhoto;
  }

  public double getpPrice() {
    return pPrice;
  }

  public void setpPrice(double pPrice) {
    this.pPrice = pPrice;
  }

  public double getpDiscount() {
    return pDiscount;
  }

  public void setpDiscount(double pDiscount) {
    this.pDiscount = pDiscount;
  }

  public int getpQuantity() {
    return pQuantity;
  }

  public void setpQuantity(int pQuantity) {
    this.pQuantity = pQuantity;
  }

  public Category getCategory() {
    return category;
  }

  public void setCategory(Category category) {
    this.category = category;
  }
  
  

  @Override
  public String toString() {
    return "Product{" + "pId=" + pId + ", pName=" + pName + ", pDescription=" + pDescription + ", pPhoto=" + pPhoto + ", pPrice=" + pPrice + ", pDiscount=" + pDiscount + ", pQuantity=" + pQuantity + '}';
  }

  
  //calculate price after discount
  public double getPriceAfterDiscount(){
    int d = (int)((this.getpDiscount()/100.0)*this.getpPrice());
    return this.getpPrice()- d;
  } 
  
  
  
}
