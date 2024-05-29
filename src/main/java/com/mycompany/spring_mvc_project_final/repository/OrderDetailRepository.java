package com.mycompany.spring_mvc_project_final.repository;


import com.mycompany.spring_mvc_project_final.entities.OrderDetailEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;


@Repository
public interface OrderDetailRepository extends CrudRepository<OrderDetailEntity,Long> {
    List<OrderDetailEntity> findByOrderList_OrderDate(LocalDateTime dateTime);
}
