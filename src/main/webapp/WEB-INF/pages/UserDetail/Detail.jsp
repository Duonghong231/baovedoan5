<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib  uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" type="text/css" href='${pageContext.request.getContextPath()}/webjars/bootstrap/5.3.2/css/bootstrap.min.css' />
  <script type="text/javascript" src="${pageContext.request.getContextPath()}/webjars/bootstrap/5.3.2/js/bootstrap.min.js"></script>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-..." crossorigin="anonymous" />
 <title>Mobile Store</title>
</head>
<body>
<header>
<nav class="navbar navbar-expand-md navbar-light bg-light">
    <div class="container-fluid">
        <div class="navbar-collapse collapse w-100 order-1 order-md-0 dual-collapse2">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                                   <a class="nav-link" href="/user/CheckOrderDetail">Check</a>
                               </li>
                              <li class="nav-item">
                                  <a class="nav-link" href="/user/RepairService">MobileService</a>
                              </li>
                <c:forEach var="categories1" items="${cateList}">
                                     <li><a class="nav-link" href="/user/products/${categories1.categoryId}">${categories1.categoryName}</a></li>
                              </c:forEach>
            </ul>
        </div>
        <div class="mx-auto order-0">
            <a class="navbar-brand mx-auto" href="#">Mobile Store</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target=".dual-collapse2">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
        <div class="navbar-collapse collapse w-100 order-3 dual-collapse2">
            <ul class="navbar-nav ms-auto d-flex align-items-center"  >
                <li class="nav-item">
                    <a class="nav-link" href="/user/Cart">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-cart font-bolder" viewBox="0 0 16 16">
                                               <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5M3.102 4l1.313 7h8.17l1.313-7zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4m7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4m-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2m7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2"/>
                                             </svg>
                                       </a>
                </li>
                <li class="nav-item">
                      <sec:authorize access="isAuthenticated()">
                          <a class="text-decoration-none text-success"  href="<c:url value="/logout" />">Logout</a>
                      </sec:authorize>
                </li>
            </ul>
        </div>
    </div>
</nav>
</header>
<br>
<main>
<div class="d-flex container justify-content-around align-items-center">
   <div class="container-1">
      <img class="container" style="width:auto; height:auto;" src="/user/getProductPhoto/<c:out value='${productListDetail.productId}'/>">
   </div>
   <div class="container ">
   <p class="text-dark font-medium" style="font-size:19px;">SKU: BST-498</p>
    <h1 class="text-dark font-bolder" style="font-size:70px;">${productListDetail.productName}</h1>
    <h3 class="text-dark font-medium" style="font-size:30px;">price: $ ${productListDetail.productPrice}</h3>
    <p class="text-dark font-medium" style="font-size:30px;">Category: ${productListDetail.categories.categoryName}</p>
    <br>
    <p class="text-dark font-medium" style="font-size:30px;">${productListDetail.productDescription}</p>
    <p class="text-dark font-medium" style="font-size:30px;">quantity: ${productListDetail.quantity} products</p>
    <div class="container">
        <button type="button" class="btn btn-primary rounded-sm fs-3 py-2" onClick="window.location.href='/user/addToCart/${productListDetail.productId}'"  >
        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-cart" viewBox="0 0 16 16">
          <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5M3.102 4l1.313 7h8.17l1.313-7zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4m7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4m-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2m7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2"/>
        </svg>
        Add to Cart
        </button>
    </div>
   </div>
</div>
<br>
<hr>
<div class="container">
 <div class="d-flex justify-content-center">
  <p class="fs-3 font-bolder text-dark">Related products</p>
 </div>
 <div class="row row-cols-1 row-cols-md-3 g-4 container">
     <c:forEach var="products" items="${productList}">
             <div  id="productContainer" class="col ">
              <div class="card">
                       <div class="bg-image hover-zoom ripple ripple-surface ripple-surface-light"
                         data-mdb-ripple-color="light">
                         <img src="/user/getProductPhoto/<c:out value='${products.productId}'/>"
                           class="w-100"  alt="imageProduct" onClick="window.location.href='/user/getDetail/${products.productId}'" />
                         <p>
                           <div class="mask">
                             <div class="d-flex justify-content-start align-items-end h-100">
                               <h5><span class="badge bg-primary ms-2">New</span></h5>
                             </div>
                           </div>
                           <div class="hover-overlay">
                             <div class="mask" style="background-color: rgba(251, 251, 251, 0.15);"></div>
                           </div>
                         </a>
                       </div>
                       <div class="card-body">
                         <p class="text-reset">
                           <h5 class="card-title mb-3 text-center fs-3 font-bold">${products.productName}</h5>
                         </p>

                           <p class="text-muted mb-0 text-center">Available: <span class="fw-bold">${products.quantity}</span></p>
                         <p class="text-reset">
                           <p class="text-center font-medium">${products.categories.categoryName}</p>
                         </p>
                         <div class="d-flex justify-content-between align-items-center">
                              <h6 class="mb-3 font-bolder">$ ${products.productPrice}</h6>
                               <button class="btn btn-ghost align-items-center icon-link icon-link-hover" style="--bs-link-hover-color-rgb: 25, 135, 84;" onClick="window.location.href='/user/addToCart/${products.productId}'">
                                           <svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" fill="currentColor" class="bi bi-cart font-bolder" viewBox="0 0 16 16">
                                                <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5M3.102 4l1.313 7h8.17l1.313-7zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4m7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4m-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2m7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2"/>
                                           </svg>
                                         Add To Cart
                                     </button>
                         </div>
                       </div>
                     </div>
              </div>
              </c:forEach>
 </div>
</div>
     <br>
     <div class="container">
       <div class="text-center container">
        <p class="fs-5 font-medium text-dark">member in apple Store</p>
       </div>
        <div class="container text-center">
             <p class="fs-1 font-bold text-center text-dark" style="font-weight:700;">Mobile Store</p>
        </div>
          <div class="d-flex justify-content-center container">
                <p class="fs-5 font-medium text-dark text-center" style="width:550px;">At Mobile, customers who love the Apple ecosystem will find the most complete and diverse products such as iPhone, iPad, Apple Watch, MacBook and Apple accessories... with a classy, ​​modern shopping space. .</p>
               </div>
     </div>
</main>
<br>
<footer class="footer">
  <div class="bg-light py-3 py-md-5 py-xl-8 border-top border-light-subtle">
    <div class="container overflow-hidden">
      <div class="row gy-3 gy-md-5 gy-xl-0 align-items-sm-center">
        <div class="col-xs-12 col-sm-6 col-xl-3 order-0 order-xl-0">
          <div class="footer-logo-wrapper text-center text-sm-start">
            <p class="fs-3 font-bold text-dark">Mobile Store</p>
          </div>
        </div>

        <div class="col-xs-12 col-xl-6 order-2 order-xl-1">
          <ul class="nav justify-content-center">
            <div class="col">
                     <div class="footer-copyright-wrapper text-center">
                       &copy; 2024. All Rights Reserved.
                     </div>
                     <div class="credits text-secondary text-center mt-2 fs-7">
                       Built by Mobile Store with <span class="text-primary">&#9829;</span>
                     </div>
                   </div>
          </ul>
        </div>

        <div class="col-xs-12 col-sm-6 col-xl-3 order-1 order-xl-2">
          <ul class="nav justify-content-center justify-content-sm-end">
            <li class="nav-item">
              <a class="nav-link link-dark px-3" href="#!">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-facebook" viewBox="0 0 16 16">
                  <path d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951z" />
                </svg>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link link-dark px-3" href="#!">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-youtube" viewBox="0 0 16 16">
                  <path d="M8.051 1.999h.089c.822.003 4.987.033 6.11.335a2.01 2.01 0 0 1 1.415 1.42c.101.38.172.883.22 1.402l.01.104.022.26.008.104c.065.914.073 1.77.074 1.957v.075c-.001.194-.01 1.108-.082 2.06l-.008.105-.009.104c-.05.572-.124 1.14-.235 1.558a2.007 2.007 0 0 1-1.415 1.42c-1.16.312-5.569.334-6.18.335h-.142c-.309 0-1.587-.006-2.927-.052l-.17-.006-.087-.004-.171-.007-.171-.007c-1.11-.049-2.167-.128-2.654-.26a2.007 2.007 0 0 1-1.415-1.419c-.111-.417-.185-.986-.235-1.558L.09 9.82l-.008-.104A31.4 31.4 0 0 1 0 7.68v-.123c.002-.215.01-.958.064-1.778l.007-.103.003-.052.008-.104.022-.26.01-.104c.048-.519.119-1.023.22-1.402a2.007 2.007 0 0 1 1.415-1.42c.487-.13 1.544-.21 2.654-.26l.17-.007.172-.006.086-.003.171-.007A99.788 99.788 0 0 1 7.858 2h.193zM6.4 5.209v4.818l4.157-2.408L6.4 5.209z" />
                </svg>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link link-dark px-3" href="#!">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-twitter" viewBox="0 0 16 16">
                  <path d="M5.026 15c6.038 0 9.341-5.003 9.341-9.334 0-.14 0-.282-.006-.422A6.685 6.685 0 0 0 16 3.542a6.658 6.658 0 0 1-1.889.518 3.301 3.301 0 0 0 1.447-1.817 6.533 6.533 0 0 1-2.087.793A3.286 3.286 0 0 0 7.875 6.03a9.325 9.325 0 0 1-6.767-3.429 3.289 3.289 0 0 0 1.018 4.382A3.323 3.323 0 0 1 .64 6.575v.045a3.288 3.288 0 0 0 2.632 3.218 3.203 3.203 0 0 1-.865.115 3.23 3.23 0 0 1-.614-.057 3.283 3.283 0 0 0 3.067 2.277A6.588 6.588 0 0 1 .78 13.58a6.32 6.32 0 0 1-.78-.045A9.344 9.344 0 0 0 5.026 15z" />
                </svg>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link link-dark px-3" href="#!">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-linkedin" viewBox="0 0 16 16">
                  <path d="M0 1.146C0 .513.526 0 1.175 0h13.65C15.474 0 16 .513 16 1.146v13.708c0 .633-.526 1.146-1.175 1.146H1.175C.526 16 0 15.487 0 14.854V1.146zm4.943 12.248V6.169H2.542v7.225h2.401zm-1.2-8.212c.837 0 1.358-.554 1.358-1.248-.015-.709-.52-1.248-1.342-1.248-.822 0-1.359.54-1.359 1.248 0 .694.521 1.248 1.327 1.248h.016zm4.908 8.212V9.359c0-.216.016-.432.08-.586.173-.431.568-.878 1.232-.878.869 0 1.216.662 1.216 1.634v3.865h2.401V9.25c0-2.22-1.184-3.252-2.764-3.252-1.274 0-1.845.7-2.165 1.193v.025h-.016a5.54 5.54 0 0 1 .016-.025V6.169h-2.4c.03.678 0 7.225 0 7.225h2.4z" />
                </svg>
              </a>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
  <div class="bg-light py-3 py-md-5 border-top border-light-subtle">
    <div class="container overflow-hidden">
      <div class="row">
        <div class="col">

          <div class="credits text-secondary text-center align-items-center mt-2 fs-7">
             <p  class="link-secondary text-decoration-none">Support on order in customer by Mobile Store with </p> <span class="text-primary">
            <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19"  class="bi bi-apple" viewBox="0 0 16 16">
              <path d="M11.182.008C11.148-.03 9.923.023 8.857 1.18c-1.066 1.156-.902 2.482-.878 2.516s1.52.087 2.475-1.258.762-2.391.728-2.43m3.314 11.733c-.048-.096-2.325-1.234-2.113-3.422s1.675-2.789 1.698-2.854-.597-.79-1.254-1.157a3.7 3.7 0 0 0-1.563-.434c-.108-.003-.483-.095-1.254.116-.508.139-1.653.589-1.968.607-.316.018-1.256-.522-2.267-.665-.647-.125-1.333.131-1.824.328-.49.196-1.422.754-2.074 2.237-.652 1.482-.311 3.83-.067 4.56s.625 1.924 1.273 2.796c.576.984 1.34 1.667 1.659 1.899s1.219.386 1.843.067c.502-.308 1.408-.485 1.766-.472.357.013 1.061.154 1.782.539.571.197 1.111.115 1.652-.105.541-.221 1.324-1.059 2.238-2.758q.52-1.185.473-1.282"/>
              <path d="M11.182.008C11.148-.03 9.923.023 8.857 1.18c-1.066 1.156-.902 2.482-.878 2.516s1.52.087 2.475-1.258.762-2.391.728-2.43m3.314 11.733c-.048-.096-2.325-1.234-2.113-3.422s1.675-2.789 1.698-2.854-.597-.79-1.254-1.157a3.7 3.7 0 0 0-1.563-.434c-.108-.003-.483-.095-1.254.116-.508.139-1.653.589-1.968.607-.316.018-1.256-.522-2.267-.665-.647-.125-1.333.131-1.824.328-.49.196-1.422.754-2.074 2.237-.652 1.482-.311 3.83-.067 4.56s.625 1.924 1.273 2.796c.576.984 1.34 1.667 1.659 1.899s1.219.386 1.843.067c.502-.308 1.408-.485 1.766-.472.357.013 1.061.154 1.782.539.571.197 1.111.115 1.652-.105.541-.221 1.324-1.059 2.238-2.758q.52-1.185.473-1.282"/>
            </svg>
            </span>
          </div>
        </div>
      </div>
    </div>
  </div>

</footer>
</body>
</html>