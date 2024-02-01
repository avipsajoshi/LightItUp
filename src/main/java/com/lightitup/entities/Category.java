
package com.lightitup.entities;

import java.util.ArrayList;
import java.util.List;
import jakarta.persistence.Entity;
import jakarta.persistence.GenerationType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;

@Entity
public class Category {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int categoryId;
  private String CategoryTitle;
  private String categoryDescription;
  @OneToMany(mappedBy ="category")
  //will create new table "Product" so map the following to column "category" from product object inside the list
  private List<Product> products = new ArrayList<>();
  
  public Category() {
  }
  
  public Category(int categoryId, String CategoryTitle, String categoryDescription) {
    this.categoryId = categoryId;
    this.CategoryTitle = CategoryTitle;
    this.categoryDescription = categoryDescription;
  }

  public Category(String CategoryTitle, String categoryDescription, List<Product> products) {
    this.CategoryTitle = CategoryTitle;
    this.categoryDescription = categoryDescription;
    this.products = products;
  }
  
  

  public int getCategoryId() {
    return categoryId;
  }

  public void setCategoryId(int categoryId) {
    this.categoryId = categoryId;
  }

  public String getCategoryTitle() {
    return CategoryTitle;
  }

  public void setCategoryTitle(String CategoryTitle) {
    this.CategoryTitle = CategoryTitle;
  }

  public String getCategoryDescription() {
    return categoryDescription;
  }

  public void setCategoryDescription(String categoryDescription) {
    this.categoryDescription = categoryDescription;
  }

  public List<Product> getProducts() {
    return products;
  }

  public void setProducts(List<Product> products) {
    this.products = products;
  }
  

  @Override
  public String toString() {
    return "Category{" + "categoryId=" + categoryId + ", CategoryTitle=" + CategoryTitle + ", categoryDescription=" + categoryDescription + '}';
  }

  
  
}
