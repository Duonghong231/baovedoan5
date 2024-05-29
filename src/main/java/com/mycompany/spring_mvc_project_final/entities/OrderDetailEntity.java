package com.mycompany.spring_mvc_project_final.entities;

import javax.persistence.*;

@Entity
@Table(name = "orderDetail")
public class OrderDetailEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "orderDetailId")
    private long orderDetailId;
    @Column(name = "quantity")
    private int quantity;
    @Column(name = "totalPrice")
    private double totalPrice;


    @ManyToOne
    @JoinColumn(name = "productId")
    private ProductEntity productList;

    @ManyToOne
    @JoinColumn(name = "orderId")
    private OrderEntity orderList;


    public long getOrderDetailId() {
        return orderDetailId;
    }

    public void setOrderDetailId(long orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public OrderEntity getOrderList() {
        return orderList;
    }

    public void setOrderList(OrderEntity orderList) {
        this.orderList = orderList;
    }

    public ProductEntity getProductList() {
        return productList;
    }

    public void setProductList(ProductEntity productList) {
        this.productList = productList;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }
}