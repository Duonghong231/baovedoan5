package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.*;
import com.mycompany.spring_mvc_project_final.enums.Role;
import com.mycompany.spring_mvc_project_final.enums.UserStatus;
import com.mycompany.spring_mvc_project_final.repository.*;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;


@Controller
@RequestMapping("/admin")
public class ProductController {
	@Autowired
	JavaMailSender javaMailSender;
	@Autowired
	ProductRepository studentRepository;
	@Autowired
	RoleRepository roleRepository;
	@Autowired
	AccountRepository accountRepository;
	@Autowired
	BCryptPasswordEncoder bCryptPasswordEncoder;
	@Autowired
	CategoryRepository categoryRepository;
	@Autowired
	CustomerRepository customerRepository;
    @Autowired
	OrderDetailRepository orderDetailRepository;
	@Autowired
	OrderRepository orderRepository;
	@Autowired
	FixRepository fixRepository;

	@RequestMapping(value = {"/"}, method = RequestMethod.GET)
	public ModelAndView welcomePage(ModelAndView model) {
		if (createAccountDefault())
			model.addObject("msg","Please login with account: admin@gmail.com and pass is: 123456");
		List<ProductEntity> listStu = (List<ProductEntity>) studentRepository.findAll();
        Map<String,Integer> categoryData =getCategoryProductCount();
		model.addObject("categoryDataValue",categoryData);
		model.addObject("listStu", listStu);
		model.setViewName("home");
		return model;
	}

	@RequestMapping(value = "/ProductList", method = RequestMethod.GET)
	public ModelAndView ProductPage(ModelAndView model) {
		List<ProductEntity> listStu = (List<ProductEntity>) studentRepository.findAll();

		model.addObject("listStu", listStu);
		model.setViewName("product/Product");
		return model;
	}

	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public ModelAndView SearchPage(@RequestParam(value = "keyword", required = false) String productName, ModelAndView model) {
		List<ProductEntity> searchResults;
		if (productName == null || productName.isEmpty()) {
			searchResults = (List<ProductEntity>) studentRepository.findAll();
		} else {
			searchResults = studentRepository.findByProductNameContaining(productName);
		}

		model.addObject("listStu", searchResults);

		model.setViewName("adminSearch/home");

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

	@RequestMapping(value = "/addCategories",method = RequestMethod.POST,consumes = MediaType.MULTIPART_FORM_DATA_VALUE,
			produces = {MediaType.APPLICATION_JSON_UTF8_VALUE,"text/plain;charset=UTF-8"})
	public String PostCategory(@RequestParam("categoriesName") String categoryName){
		CategoryEntity categoryEntity =new CategoryEntity();
		categoryEntity.setCategoryName(categoryName);
		categoryRepository.save(categoryEntity);
		return "redirect:/admin/CategoryList";
	}

	@RequestMapping(value = "/addCategory",method = RequestMethod.GET)
	public ModelAndView GetAddCategory(ModelAndView model){

		model.setViewName("product/addCategory");
		return model;
	}

	@RequestMapping(value = "/CategoryList",method = RequestMethod.GET)
	public ModelAndView GetCategory(ModelAndView model){
		List<CategoryEntity> categoryEntities =(List<CategoryEntity>) categoryRepository.findAll();
		model.addObject("categories",categoryEntities);
		model.setViewName("product/category");
		return model;
	}


	@RequestMapping(value = "/searchCategory", method = RequestMethod.GET)
	public ModelAndView SearchPage1(@RequestParam(value = "keyword1", required = false) String categoryName, ModelAndView model) {
		List<CategoryEntity> searchResults1;
		if (categoryName == null || categoryName.isEmpty()) {
			searchResults1 = (List<CategoryEntity>) categoryRepository.findAll();
		} else {
			searchResults1 = categoryRepository.findByCategoryNameContaining(categoryName);
		}

		model.addObject("categories", searchResults1);

		model.setViewName("adminSearch/homeCategory");

		return model;
	}




	@RequestMapping(value = "/insertImage", method = RequestMethod.POST,
			consumes = MediaType.MULTIPART_FORM_DATA_VALUE,
			produces = {MediaType.APPLICATION_JSON_UTF8_VALUE,"text/plain;charset=UTF-8"})
	public ModelAndView saveProduct(@RequestParam("name") String name, @RequestParam("quantity") BigDecimal quantity,
							 @RequestParam("description") String description,@RequestPart("photo") MultipartFile photo,@RequestParam("price") double price,@RequestParam("categoriesId") long categoryId) {

		try {
			CategoryEntity categoryEntity =(CategoryEntity)  categoryRepository.findById(categoryId).get();

			ProductEntity s = new ProductEntity();
			//String decodedText = URLDecoder.decode(name, "UTF-8");
			s.setProductName(name);
			s.setProductPrice(price);
			s.setProductDescription(description);
			s.setCategories(categoryEntity);
			s.setQuantity(quantity);
			s.setProductPhoto(photo.getBytes());
			studentRepository.save(s);
			return new ModelAndView( "redirect:/admin/ProductList");
			//return new ModelAndView("stu", "msg", "Records succesfully inserted into database.");

		} catch (Exception e) {
			return new ModelAndView("student/index", "msg", "Error: " + e.getMessage());
		}
	}


	@RequestMapping(value = "/getProductPhoto/{productId}")
	public void getStudentPhoto(HttpServletResponse response, @PathVariable("productId") long productId) throws Exception {
		response.setContentType("image/jpeg");

		ProductEntity s = studentRepository.findById(productId).get();
		byte[] ph = s.getProductPhoto();
		InputStream inputStream = new ByteArrayInputStream(ph);
		IOUtils.copy(inputStream, response.getOutputStream());
	}



	@RequestMapping("/addProduct")
	public String viewHome(Model model, HttpSession session) {

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String username = principal.toString();

		if (principal instanceof UserDetails) {
			username = ((UserDetails) principal).getUsername();
			session.setAttribute("username", username);

		}

		List<CategoryEntity> categoryEntities =(List<CategoryEntity>) categoryRepository.findAll();
		model.addAttribute("categories",categoryEntities);
		return "product/index";
	}

	@RequestMapping(value = "/DeleteProduct/{productId}",method = RequestMethod.GET)
	public String DeleteProduct(@PathVariable("productId") long productId){
		studentRepository.deleteById(productId);
		return "redirect:/admin/ProductList";
	}

	@RequestMapping(value = "/DeleteCategory/{categoryId}",method = RequestMethod.GET)
	public String DeleteCategory(@PathVariable("categoryId") long categoryId){
		categoryRepository.deleteById(categoryId);
		return "redirect:/admin/CategoryList";
	}

	@RequestMapping(value = "/EditProduct/{productId}",method = RequestMethod.GET)
	public ModelAndView EditProduct(ModelAndView model,@PathVariable("productId") long productId){
		 ProductEntity productEntity = (ProductEntity) studentRepository.findById(productId).get();
		 model.addObject("productText",productEntity);
		List<CategoryEntity> categoryEntities =(List<CategoryEntity>) categoryRepository.findAll();
		model.addObject("categories",categoryEntities);
		 model.setViewName("Edit/EditProduct");
		 return model;
	}

	@RequestMapping(value = "/EditCategory/{categoryId}",method = RequestMethod.GET)
	public ModelAndView EditCategory(ModelAndView model,@PathVariable("categoryId") long categoryId){
		CategoryEntity categoryEntity =(CategoryEntity) categoryRepository.findById(categoryId).get();
		model.addObject("categoryText",categoryEntity);
		model.setViewName("Edit/EditCategory");
		return model;
	}

	@RequestMapping(value = "/EditProduct/{productId}/save", method = RequestMethod.POST,
			consumes = MediaType.MULTIPART_FORM_DATA_VALUE,
			produces = {MediaType.APPLICATION_JSON_UTF8_VALUE,"text/plain;charset=UTF-8"})
	public ModelAndView saveEditProduct(@PathVariable("productId") long productId,@RequestParam("name") String name, @RequestParam("quantity") BigDecimal quantity,
									@RequestParam("description") String description,@RequestPart("photo") MultipartFile photo,@RequestParam("price") double price,@RequestParam("categoriesId") long categoryId) {

		try {
			CategoryEntity categoryEntity =(CategoryEntity)  categoryRepository.findById(categoryId).get();

			ProductEntity s = (ProductEntity) studentRepository.findById(productId).get();
			//String decodedText = URLDecoder.decode(name, "UTF-8");
			s.setProductName(name);
			s.setProductPrice(price);
			s.setProductDescription(description);
			s.setCategories(categoryEntity);
			s.setQuantity(quantity);
			s.setProductPhoto(photo.getBytes());
			studentRepository.save(s);
			return new ModelAndView( "redirect:/admin/ProductList");
			//return new ModelAndView("stu", "msg", "Records succesfully inserted into database.");

		} catch (Exception e) {
			return new ModelAndView("student/index", "msg", "Error: " + e.getMessage());
		}
	}

	@RequestMapping(value = "/EditCategory/{categoryId}/save",method = RequestMethod.POST,consumes = MediaType.MULTIPART_FORM_DATA_VALUE,
			produces = {MediaType.APPLICATION_JSON_UTF8_VALUE,"text/plain;charset=UTF-8"})
    public String EditCategorySave(@PathVariable("categoryId") long categoryId,@RequestParam("categoriesName") String categoryName){
		try{
			CategoryEntity categoryEntity =(CategoryEntity) categoryRepository.findById(categoryId).get();
			categoryEntity.setCategoryName(categoryName);
			categoryRepository.save(categoryEntity);
			return "redirect:/admin/CategoryList";
		}catch(Exception e){
			throw new RuntimeException("Error edit Category",e);
		}
	}

	@RequestMapping(value = "/CustomerList",method = RequestMethod.GET)
	public ModelAndView GetCustomer(ModelAndView model){
		List<CustomerEntity> customerEntities =(List<CustomerEntity>) customerRepository.findAll();
		model.addObject("customerList",customerEntities);
		model.setViewName("Checkcustomer/customercheck");
		return model;
	}

	@RequestMapping(value = "/searchCustomer",method = RequestMethod.GET)
	public ModelAndView GetSearchCustomer(ModelAndView model,@RequestParam(value = "keyword3",required = false) String customerName){
		List<CustomerEntity> customerEntityList;
		if(customerName ==null || customerName.isEmpty()){
			customerEntityList =(List<CustomerEntity>) customerRepository.findAll();
		}else{
			customerEntityList =(List<CustomerEntity>) customerRepository.findByCustomerNameContaining(customerName);
		}

		model.addObject("customerList",customerEntityList);
		model.setViewName("adminSearch/homeCustomer");

		return model;
	}

	@RequestMapping(value = "/CheckList",method = RequestMethod.GET)
	public ModelAndView GetCheckPay(ModelAndView model){
		List<OrderDetailEntity> orderDetailEntities =(List<OrderDetailEntity>) orderDetailRepository.findAll();
		model.addObject("orderDetailList",orderDetailEntities);
		model.setViewName("Checkcustomer/customerpay");
		return model;
	}

    @RequestMapping(value = "/EditCheckPay/{customerId}",method = RequestMethod.GET)
	public ModelAndView GetCheckPayCustomer(ModelAndView model,@PathVariable("customerId") long customerId){
		CustomerEntity customerEntity=(CustomerEntity) customerRepository.findById(customerId).get();
		model.addObject("customerCheck",customerEntity);
		model.setViewName("CheckCustomerPay/Customer");
		return model;
	}

	@RequestMapping(value = "/customerToCheck/{customerId}/save",method = RequestMethod.POST)
	public ModelAndView PostCheckPay(ModelAndView model,@PathVariable("customerId") long customerId,@RequestParam("customerCheck") String customerCheck){
		try{
			CustomerEntity customerEntity =(CustomerEntity) customerRepository.findById(customerId).get();
			customerEntity.setCustomerCheckout(customerCheck);
			customerRepository.save(customerEntity);
			model.setViewName("redirect:/admin/CustomerList");
		}catch (Exception e){
			throw  new RuntimeException("Error customer Check",e);
		}
		return model;
	}



	public Map<String,Integer> getCategoryProductCount(){
		Map<String,Integer> categoryData = new HashMap<>();
		categoryRepository.findAll().forEach(category -> {
			categoryData.put(category.getCategoryName(),category.getProductEntityList().size());
		});
		return categoryData;
	}

	@RequestMapping(value = "/chartData",method = RequestMethod.GET)
	@ResponseBody
	public List<Map<String,Object>> getOrderDetail(){
		return getOrderSummary();
	}

	public List<Map<String, Object>> getOrderSummary() {
		List<OrderDetailEntity> orderDetailEntities =(List<OrderDetailEntity>) orderDetailRepository.findAll();
		return orderDetailEntities.stream().collect(Collectors.groupingBy(orderDetailEntity -> orderDetailEntity.getOrderList().getOrderDate().getMonth(),Collectors.collectingAndThen(Collectors.toList(),list->{
			int totalQuantity =list.stream().mapToInt(OrderDetailEntity::getQuantity).sum();
			double totalPriceOrder =list.stream().mapToDouble(OrderDetailEntity::getTotalPrice).sum();
			OrderEntity orderEntity =list.get(0).getOrderList();
			Map<String,Object> map=new HashMap<>();
			map.put("orderDate",orderEntity.getOrderDate().getMonth());
			map.put("totalQuantity",totalQuantity);
			map.put("totalPrice",totalPriceOrder);
			return map;
		}))).values().stream().collect(Collectors.toList());
	}

	@RequestMapping(value = "/ChartRevenue",method = RequestMethod.GET)
	public ModelAndView GetChart(ModelAndView model){
		model.setViewName("ChartRevenue/Chart");
		return model;
	}

	@RequestMapping(value = "/ChartCategory",method = RequestMethod.GET)
	public ModelAndView GetCategoryChart(ModelAndView model){
		Map<String,Integer> categoryData =getCategoryProductCount();
		model.addObject("categoryDataValue",categoryData);
		model.setViewName("ChartCategory/Charts");
		return model;
	}

    public List<Map<String,Object>> getOrderDateSummary(){
		List<OrderDetailEntity> orderDetailEntities =(List<OrderDetailEntity>) orderDetailRepository.findAll();
		return orderDetailEntities.stream().collect(Collectors.groupingBy(orderDetailEntity ->
			orderDetailEntity.getOrderList().getOrderDate(),Collectors.collectingAndThen(Collectors.toList(),list->{
				int totalQuantity = list.stream().mapToInt(OrderDetailEntity::getQuantity).sum();
				double totalPrice =list.stream().mapToDouble(OrderDetailEntity::getTotalPrice).sum();
				OrderEntity orderEntity =list.get(0).getOrderList();
				Map<String,Object> mapList =new HashMap<>();
				mapList.put("orderDate",orderEntity.getOrderDate().toLocalDate().getDayOfMonth());
				mapList.put("totalQuantity",totalQuantity);
				mapList.put("totalPrice",totalPrice);
				return mapList;
		}))).values().stream().collect(Collectors.toList());

	}

	@RequestMapping(value = "/ChartDataToDay",method = RequestMethod.GET)
	@ResponseBody
	public List<Map<String,Object>> GetChartRevenue(){
		return getOrderDateSummary();
	}


	@RequestMapping(value = "/Fix",method = RequestMethod.GET)
	public ModelAndView GetFix(ModelAndView model){
         List<FixEntity> fixEntities =(List<FixEntity>) fixRepository.findAll();
		 model.addObject("fixList",fixEntities);
		 model.setViewName("Fix/fixControl");
		 return model;
	}

	@RequestMapping(value = "/searchFix",method = RequestMethod.GET)
	public ModelAndView GetSearchFix(ModelAndView model,@RequestParam(value = "keyFix",required = false) String keySearchFix){
		List<FixEntity> searchFix;
		if(keySearchFix==null|| keySearchFix.isEmpty()) {
			searchFix = (List<FixEntity>) fixRepository.findAll();
		}else{
			searchFix= fixRepository.findByFixNameContaining(keySearchFix);
		}
		model.addObject("fixList",searchFix);
		model.setViewName("Fix/fixSearch");
		return model;
	}

	@RequestMapping(value = "/addFix",method = RequestMethod.GET)
	public ModelAndView GetAddFix(ModelAndView model){
		model.setViewName("Fix/AddFix");
		return model;
	}

	@RequestMapping(value = "/AddFix", method = RequestMethod.POST,
			consumes = MediaType.MULTIPART_FORM_DATA_VALUE,
			produces = {MediaType.APPLICATION_JSON_UTF8_VALUE,"text/plain;charset=UTF-8"})
	public String PostFix(@RequestParam("nameFix") String nameFix,@RequestParam("priceFix") double priceFix){
		try{
			FixEntity fixEntity =new FixEntity();
			fixEntity.setFixName(nameFix);
			fixEntity.setFixPrice(priceFix);
			fixRepository.save(fixEntity);
			return "redirect:/admin/Fix";
		}catch (Exception e){
			throw new RuntimeException("Error Fix in service",e);
		}
	}

	@RequestMapping(value = "/EditFix/{fixId}",method = RequestMethod.GET)
	public ModelAndView EditFix(ModelAndView model,@PathVariable("fixId") long fixId){
		FixEntity fixEntity =(FixEntity) fixRepository.findById(fixId).get();
		model.addObject("fixControl",fixEntity);
		model.setViewName("Fix/EditFix");
		return model;
	}

	@RequestMapping(value = "/AddToFix/{fixId}/save", method = RequestMethod.POST,
			consumes = MediaType.MULTIPART_FORM_DATA_VALUE,
			produces = {MediaType.APPLICATION_JSON_UTF8_VALUE,"text/plain;charset=UTF-8"})
	public String PostEditFix(@PathVariable("fixId") long fixId,@RequestParam("nameFix") String nameFix,@RequestParam("priceFix") double priceFix){
		try{
			FixEntity fixEntity =(FixEntity) fixRepository.findById(fixId).get();
			fixEntity.setFixName(nameFix);
			fixEntity.setFixPrice(priceFix);
			fixRepository.save(fixEntity);
			return "redirect:/admin/Fix";
		}catch (Exception e){
			throw new RuntimeException("Error Fix Edit in service",e);
		}
	}

	@RequestMapping(value = "/DeleteFix/{fixId}",method = RequestMethod.GET)
	public String DeleteFix(@PathVariable("fixId") long fixId){
       fixRepository.deleteById(fixId);
		return "redirect:/admin/Fix";
	}

}
