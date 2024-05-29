package com.mycompany.spring_mvc_project_final.entities;

import javax.persistence.*;

@Entity
@Table(name = "fix")
public class FixEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "fixId")
    private long fixId;
    @Column(name = "fixName")
    private String fixName;
    @Column(name = "fixPrice")
    private double fixPrice;

    public long getFixId() {
        return fixId;
    }

    public void setFixId(long fixId) {
        this.fixId = fixId;
    }

    public String getFixName() {
        return fixName;
    }

    public void setFixName(String fixName) {
        this.fixName = fixName;
    }

    public double getFixPrice() {
        return fixPrice;
    }

    public void setFixPrice(double fixPrice) {
        this.fixPrice = fixPrice;
    }
}
