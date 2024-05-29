package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.CategoryEntity;
import com.mycompany.spring_mvc_project_final.entities.FixEntity;
import com.mycompany.spring_mvc_project_final.entities.ProductEntity;
import com.mycompany.spring_mvc_project_final.repository.CategoryRepository;
import com.mycompany.spring_mvc_project_final.repository.FixRepository;
import com.mycompany.spring_mvc_project_final.repository.ProductRepository;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.*;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    ProductRepository productRepository;
    @Autowired
    CategoryRepository categoryRepository;
    @Autowired
    FixRepository fixRepository;

    @RequestMapping(value = "/",method = RequestMethod.GET)
    public ModelAndView GetUserHome(ModelAndView model,@RequestParam(defaultValue = "0") int page){
        Page<ProductEntity> productEntities = findPaginated(page,10);
        List<CategoryEntity> categoryEntities = (List<CategoryEntity>) categoryRepository.findAll();
        model.addObject("productList",productEntities.getContent());
        model.addObject("currentPage",page);
        model.addObject("totalPage",productEntities.getTotalPages());
        model.addObject("totalItems", productEntities.getTotalElements());
        model.addObject("cateList",categoryEntities);
        model.setViewName("UserHome/home");
        return model;
    }

   @RequestMapping(value = "/products/{categoryId}",method = RequestMethod.GET)
   public ModelAndView GetUserCategory(ModelAndView model,@PathVariable("categoryId") long categoryId){
        List<ProductEntity> productEntities =(List<ProductEntity>) productRepository.findByCategories_CategoryId(categoryId);
       List<CategoryEntity> categoryEntities = (List<CategoryEntity>) categoryRepository.findAll();
       model.addObject("productList",productEntities);
       model.addObject("cateList",categoryEntities);
       model.setViewName("UserHome/homeCategory");
        return model;
   }

   @RequestMapping(value = "/searchProductList",method = RequestMethod.GET)
   public ModelAndView GetSearchUser(ModelAndView model, @RequestParam(value = "searchKey",required = false) String searchKey){
        List<ProductEntity> productEntities;
        if(searchKey ==null|| searchKey.isEmpty()){
            productEntities =(List<ProductEntity>) productRepository.findAll();
        }else{
            productEntities =(List<ProductEntity>) productRepository.findByProductNameContaining(searchKey);
        }
       model.addObject("productList",productEntities);
       List<CategoryEntity> categoryEntities = (List<CategoryEntity>) categoryRepository.findAll();
       model.addObject("cateList",categoryEntities);
       model.setViewName("UserSearch/home");
        return  model;
   }



    @RequestMapping(value = "/getProductPhoto/{productId}")
    public void getStudentPhoto(HttpServletResponse response, @PathVariable("productId") long productId) throws Exception {
        response.setContentType("image/jpeg");

        ProductEntity s = productRepository.findById(productId).get();
        byte[] ph = s.getProductPhoto();
        InputStream inputStream = new ByteArrayInputStream(ph);
        IOUtils.copy(inputStream, response.getOutputStream());
    }

    @RequestMapping(value = "/getDetail/{productId}",method = RequestMethod.GET)
    public ModelAndView GetDetailProduct(ModelAndView model,@PathVariable("productId") long productId){
        List<CategoryEntity> categoryEntities = (List<CategoryEntity>) categoryRepository.findAll();
        List<ProductEntity> productEntities =(List<ProductEntity>)productRepository.findAll();
        ProductEntity products =(ProductEntity) productRepository.findById(productId).get();
        model.addObject("cateList",categoryEntities);
        model.addObject("productList",productEntities);
        model.addObject("productListDetail",products);

        model.setViewName("UserDetail/Detail");
        return model;
    }

    @RequestMapping(value = "/RepairService",method = RequestMethod.GET)
    public ModelAndView GetFix(ModelAndView model){
        List<FixEntity> fixEntities =(List<FixEntity>) fixRepository.findAll();
        List<CategoryEntity> categoryEntities = (List<CategoryEntity>) categoryRepository.findAll();
        model.addObject("cateList",categoryEntities);
        model.addObject("fixList",fixEntities);
        model.setViewName("FixControlUser/FixControl");
        return  model;
    }



    public Page<ProductEntity> findPaginated(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return productRepository.findAll(pageable);
    }




}
