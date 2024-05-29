package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.FixEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FixRepository extends CrudRepository<FixEntity,Long> {
   List<FixEntity> findByFixNameContaining(String keyFix);
}
