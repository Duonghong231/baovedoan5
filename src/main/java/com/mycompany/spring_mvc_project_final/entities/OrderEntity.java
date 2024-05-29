package com.mycompany.spring_mvc_project_final.entities;



import javax.persistence.*;
import java.time.LocalDateTime;

import java.util.List;

@Entity
@Table(name = "order3")
public class OrderEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "orderId")
    private long orderId;
    @Column(name = "orderDate")
    private LocalDateTime orderDate;
    @Column(name = "paymentDate")
    private LocalDateTime paymentDate;

    @ManyToOne
    @JoinColumn(name = "customerId")
    private CustomerEntity customers;

    @OneToMany(mappedBy = "orderList",fetch = FetchType.EAGER)
    private List<OrderDetailEntity> orderDetail;

    public CustomerEntity getCustomers() {
        return customers;
    }

    public void setCustomers(CustomerEntity customers) {
        this.customers = customers;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public long getOrderId() {
        return orderId;
    }

    public void setOrderId(long orderId) {
        this.orderId = orderId;
    }

    public LocalDateTime getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(LocalDateTime paymentDate) {
        this.paymentDate = paymentDate;
    }

    public List<OrderDetailEntity> getOrderDetail() {
        return orderDetail;
    }

    public void setOrderDetail(List<OrderDetailEntity> orderDetail) {
        this.orderDetail = orderDetail;
    }
}
