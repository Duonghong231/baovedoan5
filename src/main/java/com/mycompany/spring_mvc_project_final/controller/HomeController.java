package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.AccountEntity;
import com.mycompany.spring_mvc_project_final.entities.RoleEntity;
import com.mycompany.spring_mvc_project_final.entities.ProductEntity;
import com.mycompany.spring_mvc_project_final.enums.Role;
import com.mycompany.spring_mvc_project_final.enums.UserStatus;
import com.mycompany.spring_mvc_project_final.repository.AccountRepository;
import com.mycompany.spring_mvc_project_final.repository.ProductRepository;
import com.mycompany.spring_mvc_project_final.repository.RoleRepository;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.time.LocalDate;
import java.util.*;

@Controller
public class HomeController {
    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;
    @Autowired
    RoleRepository roleRepository;

    @Autowired
    ProductRepository productRepository;
    @Autowired
    AccountRepository accountRepository;

     @RequestMapping(value = {"/","/home"},method = RequestMethod.GET)
     public ModelAndView GetHome(ModelAndView model){
         LocalDate date =LocalDate.now();
         model.addObject("year",date.getYear());
         model.setViewName("WebShow/showHome");
         return model;
     }

    private void createRoleDefault(){
        List<RoleEntity> roleEntityList = roleRepository.findAll();
        if(roleEntityList.isEmpty()){
            // insert role into data database
            List<Role> roleList = new ArrayList<>();
            roleList.add(Role.ROLE_ADMIN);
            roleList.add(Role.ROLE_USER);
            roleList.add(Role.ROLE_SELLER);
            roleList.add(Role.ROLE_MANAGER);
            for (Role role: roleList){
                RoleEntity entity = new RoleEntity();
                entity.setRole(role);
                roleRepository.save(entity);
            }
        }
    }
    private boolean createAccountDefault(){
        List<AccountEntity> accountEntityList = (List<AccountEntity>) accountRepository.findAll();
        if(accountEntityList.isEmpty()){
            createRoleDefault();
            List<RoleEntity> roleEntityList = (List<RoleEntity>) roleRepository.findAll();
            Set<RoleEntity> roleEntitySet = new LinkedHashSet<>(roleEntityList);
            if(!roleEntityList.isEmpty()){
                AccountEntity accountEntity = new AccountEntity();
                accountEntity.setEmail("admin@gmail.com");
                accountEntity.setPassword(bCryptPasswordEncoder.encode("123456"));
                accountEntity.setUserRoles(roleEntitySet);
                accountEntity.setStatus(UserStatus.ACTIVE);
                accountRepository.save(accountEntity);
                return true;
            }
        }
        return false;
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String Postregister(Model model, @RequestParam("name") String name, @RequestParam("username") String username, @RequestParam("phone") String phone, @RequestParam("address") String address, @RequestParam("password") String password) {
        if (accountRepository.existsByEmail(username)) {
            model.addAttribute("error", "account in exist");
            return "Signup";
        }

        AccountEntity accountEntity = new AccountEntity();
        RoleEntity roleEntity = (RoleEntity) roleRepository.findById(2L).get();
        Set<RoleEntity> roleEntitySet = new LinkedHashSet<>();
        roleEntitySet.add(roleEntity);
        accountEntity.setName(name);
        accountEntity.setEmail(username);
        accountEntity.setPhone(phone);
        accountEntity.setAddress(address);
        accountEntity.setPassword(bCryptPasswordEncoder.encode(password));
        accountEntity.setUserRoles(roleEntitySet);
        accountEntity.setStatus(UserStatus.ACTIVE);
        accountRepository.save(accountEntity);
        return "redirect:/Signup";
    }


    @RequestMapping(value = "/getProductPhoto/{productId}")
    public void getStudentPhoto(HttpServletResponse response, @PathVariable("productId") long productId) throws Exception {
        response.setContentType("image/jpeg");

        ProductEntity s = productRepository.findById(productId).get();
        byte[] ph = s.getProductPhoto();
        InputStream inputStream = new ByteArrayInputStream(ph);
        IOUtils.copy(inputStream, response.getOutputStream());
    }
}
