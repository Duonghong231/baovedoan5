package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.Session.CartSession;
import com.mycompany.spring_mvc_project_final.entities.*;
import com.mycompany.spring_mvc_project_final.repository.*;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.data.domain.Page;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

@Controller
@RequestMapping("/user")
public class CartController {

    @Autowired
    JavaMailSender javaMailSender;
    @Autowired
    ProductRepository productRepository;
    @Autowired
    CategoryRepository categoryRepository;
    @Autowired
    CustomerRepository customerRepository;
    @Autowired
    OrderRepository orderRepository;
    @Autowired
    OrderDetailRepository orderDetailRepository;

    private double SumCartSession(List<CartSession> cartSessions){
        double totalSum =0.0;
        for(CartSession cartSession:cartSessions){
            totalSum +=cartSession.getTotalPriceCart();
        }
        return totalSum;
    }

    @RequestMapping(value = "/Cart", method = RequestMethod.GET)
    public ModelAndView GetUserHome(ModelAndView model, HttpServletRequest request, HttpSession session) {
        List<CartSession> cartSessions = (List<CartSession>) request.getSession().getAttribute("cartSessions");
        List<CategoryEntity> categoryEntities = (List<CategoryEntity>) categoryRepository.findAll();
        session.setAttribute("cartSessions", cartSessions);
        model.addObject("cartList", cartSessions);
        double totalSum1 =SumCartSession(cartSessions);
        model.addObject("cateList", categoryEntities);
        model.addObject("totalSumCart",totalSum1);
        model.setViewName("CheckOutPay/Payment");
        return model;
    }


    @RequestMapping(value = "/addToCart/{productId}", method = RequestMethod.GET)
    public String GetCartonProduct(ModelAndView model, HttpServletRequest request, HttpSession session, @PathVariable("productId") long productId) {
        ProductEntity productsEntity = (ProductEntity) productRepository.findById(productId).get();

        List<CartSession> cartSessions = (List<CartSession>) request.getSession().getAttribute("cartSessions");
        if (cartSessions == null) {
            cartSessions = new ArrayList<CartSession>();
        }
        boolean found = false;

        for (CartSession cartSession : cartSessions) {
            if (cartSession.getProduct().getProductId() == productId) {
                cartSession.setQuantity(cartSession.getQuantity() + 1);
                cartSession.setTotalPriceCart(cartSession.getProduct().getProductPrice() * cartSession.getQuantity());
                found = true;
                break;
            }
        }

        double total = productsEntity.getProductPrice();


        if (!found) {
            CartSession cart = new CartSession();
            cart.setQuantity(1);
            cart.setTotalPriceCart(total);

            cart.setProduct(productsEntity);
            cartSessions.add(cart);
        }
        session.setAttribute("cartSessions", cartSessions);

        model.addObject("cartList", cartSessions);
        return "redirect:/user/Cart";
    }

    @RequestMapping(value = "/removeToCart/{productId}", method = RequestMethod.GET)
    public String GetDeleteOnProduct(ModelAndView model, @PathVariable("productId") long productId, HttpServletRequest request, HttpSession session) {

        List<CartSession> cartSessions = (List<CartSession>) request.getSession().getAttribute("cartSessions");
        if (cartSessions != null) {
            for (CartSession cartSession : cartSessions) {
                if (cartSession.getProduct().getProductId() == productId) {
                    cartSessions.remove(cartSession);

                }
                session.setAttribute("cartSessions", cartSessions);
                break;
            }

        }

        return "redirect:/user/Cart";
    }

    @RequestMapping(value = "/checkOut",method = RequestMethod.POST)
    public String PostCustomer(HttpServletRequest request,@RequestParam("customerName") String customerName,@RequestParam("customerEmail") String customerEmail,@RequestParam("customerPhone")  String customerPhone,@RequestParam("customerAddress") String customerAddress){
        CustomerEntity customerEntity =new CustomerEntity();
        customerEntity.setCustomerName(customerName);
        customerEntity.setCustomerEmail(customerEmail);
        customerEntity.setCustomerPhone(customerPhone);
        customerEntity.setCustomerAddress(customerAddress);
        customerEntity.setCustomerCheckout("Checking");
        customerRepository.save(customerEntity);

        OrderEntity orderEntity =new OrderEntity();
        orderEntity.setOrderDate(LocalDateTime.now());
        orderEntity.setPaymentDate(LocalDateTime.now());
        orderEntity.setCustomers(customerEntity);
        orderRepository.save(orderEntity);

        List<CartSession> cartSessions = (List<CartSession>) request.getSession().getAttribute("cartSessions");
        if (cartSessions == null) {
            cartSessions = new ArrayList<CartSession>();
        }

        if(cartSessions !=null){
           for(CartSession cartSession:cartSessions){
               OrderDetailEntity orderDetailEntity =new OrderDetailEntity();
               orderDetailEntity.setProductList(cartSession.getProduct());
               orderDetailEntity.setOrderList(orderEntity);
               orderDetailEntity.setQuantity(cartSession.getQuantity());
               orderDetailEntity.setTotalPrice(cartSession.getTotalPriceCart());
               orderDetailRepository.save(orderDetailEntity);
           }
        }

        SendEmail(customerEmail,"Thank you have buy it","<h1    style='font-size:39px; color:grey; text-align:center;'>Mobile Store</h1><img src='https://i.postimg.cc/vDFJmCqX/smartphones-mockup-banner-copy-space-gray-background-smartphone-top-view-flat-lay-new-frameless-back.webp' border='0' alt='smartphones-mockup-banner-copy-space-gray-background-smartphone-top-view-flat-lay-new-frameless-back'/><h3 style='font-size:30px; color:black; font-weight:500; text-align:center;'>You have successfully purchased</h3><p style='font-size:30px; text-align:center; color:gray; font-weight:300;'>Thank you for using the purchasing service at Mobile Store.Please,You can Check in have buy a product to be paid or unpaid</p><p style='font-size:19px; font-weight:300; text-align:center;'>Enjoy And use a product in Mobile Store</p>");

        return "redirect:/user/complete";


    }

    @RequestMapping(value = "/complete",method = RequestMethod.GET)
    public ModelAndView GetComplete(ModelAndView model){
        List<CategoryEntity> categoryEntities = (List<CategoryEntity>) categoryRepository.findAll();
        model.addObject("cateList", categoryEntities);
        model.setViewName("CheckComplete/Complete");
        return model;
    }

    @RequestMapping(value = "/completePayPal",method = RequestMethod.GET)
    public ModelAndView GetCompletePayPal(ModelAndView model){
        List<CategoryEntity> categoryEntities = (List<CategoryEntity>) categoryRepository.findAll();
        model.addObject("cateList", categoryEntities);
        model.setViewName("CheckComplete/CompletePayPal");
        return model;
    }

    @RequestMapping(value = "/CheckOrderDetail",method = RequestMethod.GET)
    public ModelAndView GetOrderDetail(ModelAndView model){
        List<OrderDetailEntity> orderDetailEntities =(List<OrderDetailEntity>) orderDetailRepository.findAll();
        List<CategoryEntity> categoryEntities = (List<CategoryEntity>) categoryRepository.findAll();
        model.addObject("orderDetailList",orderDetailEntities);
        model.addObject("cateList", categoryEntities);
        model.setViewName("CheckOutPay/PayOrderDetail");
        return model;
    }

    public void SendEmail(String recipient, String subject,String templateName){
        MimeMessage message =javaMailSender.createMimeMessage();
        Context context =new Context();
        try{
            MimeMessageHelper helper =new MimeMessageHelper(message,true);
            helper.setTo(recipient);
            helper.setSubject(subject);

            helper.setText(templateName,true);
            javaMailSender.send(message);
        }catch (Exception e){
            e.printStackTrace();
        }

    }

}
