package com.mycompany.spring_mvc_project_final.Session;

import com.mycompany.spring_mvc_project_final.entities.ProductEntity;

public class CartSession {
    private ProductEntity product;

    private double totalPriceCart;

    private Integer quantity;

    public ProductEntity getProduct() {
        return product;
    }

    public void setProduct(ProductEntity product) {
        this.product = product;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public double getTotalPriceCart() {
        return totalPriceCart;
    }

    public void setTotalPriceCart(double totalPriceCart) {
        this.totalPriceCart = totalPriceCart;
    }
}
