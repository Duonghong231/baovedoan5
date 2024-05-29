package com.mycompany.spring_mvc_project_final.entities;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "customer")
public class CustomerEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "customerId")
    private long customerId;
    @Column(name = "customerName")
    private String customerName;
    @Column(name = "customerEmail")
    private String customerEmail;
    @Column(name = "customerAddress")
    private String customerAddress;
    @Column(name = "customerPhone")
    private String customerPhone;
    @Column(name = "customerCheckout")
    private String customerCheckout;

    @OneToMany(mappedBy = "customers",fetch = FetchType.EAGER)
    private List<OrderEntity> orderEntityList;

    public String getCustomerCheckout() {
        return customerCheckout;
    }

    public void setCustomerCheckout(String customerCheckout) {
        this.customerCheckout = customerCheckout;
    }

    public String getCustomerAddress() {
        return customerAddress;
    }

    public void setCustomerAddress(String customerAddress) {
        this.customerAddress = customerAddress;
    }

    public long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(long customerId) {
        this.customerId = customerId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }


    public List<OrderEntity> getOrderEntityList() {
        return orderEntityList;
    }

    public void setOrderEntityList(List<OrderEntity> orderEntityList) {
        this.orderEntityList = orderEntityList;
    }
}
