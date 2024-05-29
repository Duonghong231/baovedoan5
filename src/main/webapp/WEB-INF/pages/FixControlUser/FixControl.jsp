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
 <div class="container">
   <h1 class="fs-1 font-bold text-center text-dark">MobileService Repair Service</h1>
 </div>
 <div class="container">
  <div class="d-flex justify-content-center">
        <p class="fs-5  text-center font-bolder text-info">reference price list</p>
  </div>
   <br>
   <div class="d-flex justify-content-center rounded-3">
   <div class="card bg-while shadow-2-strong">
                 <div class="card-body">
        <div class="table-responsive">
      <table class="table table-while table-bordered mb-0">
                         <thead >
                           <tr>
                             <th scope="col"  style="width:190px;">Machine series</th>
                             <th scope="col" style="width:190px;">Expense</th>
                           </tr>
                         </thead>
                         <tbody>

                       <c:forEach var="fixControl" items="${fixList}">
                            <tr>
                            <th scope="row">${fixControl.fixName}</th>
                            <td>${fixControl.fixPrice}</td>
                            <tr>
                       </c:forEach>
                         </tbody>
                       </table>
                    </div>
             </div>
         </div>
   </div>
 </div>
 <br>
 <div class="container">
    <div class="d-flex justify-content-center">
     <p class="fs-1 font-bold text-center text-dark">Reasons to choose MobileService</p>
    </div>
    <br>
    <div class="row row-cols-1 row-cols-md-3 g-4">
       <div class="container card border border-white">
         <div class="container card border border-white">
             <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 384 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M318.7 268.7c-.2-36.7 16.4-64.4 50-84.8-18.8-26.9-47.2-41.7-84.7-44.6-35.5-2.8-74.3 20.7-88.5 20.7-15 0-49.4-19.7-76.4-19.7C63.3 141.2 4 184.8 4 273.5q0 39.3 14.4 81.2c12.8 36.7 59 126.7 107.2 125.2 25.2-.6 43-17.9 75.8-17.9 31.8 0 48.3 17.9 76.4 17.9 48.6-.7 90.4-82.5 102.6-119.3-65.2-30.7-61.7-90-61.7-91.9zm-56.6-164.2c27.3-32.4 24.8-61.9 24-72.5-24.1 1.4-52 16.4-67.9 34.9-17.5 19.8-27.8 44.3-25.6 71.9 26.1 2 49.9-11.4 69.5-34.3z"/></svg>
         </div>
         <div class="container card border border-white">
           <h1 class="text-dark">Genuine Apple</h1>
           <p class="text-light-emphasis">TopCare is Apple official authorized service center. All repair components at TopCare are provided by genuine Apple.</p>
         </div>
       </div>
       <div class="container card border border-white">
            <div class="container card border border-white">
                <svg version="1.0" width="100" height="100" xmlns="http://www.w3.org/2000/svg"
                 width="88.000000pt" height="88.000000pt" viewBox="0 0 88.000000 88.000000"
                 preserveAspectRatio="xMidYMid meet">

                <g transform="translate(0.000000,88.000000) scale(0.100000,-0.100000)"
                fill="#000000" stroke="none">
                <path d="M354 789 c-55 -16 -127 -72 -159 -123 -51 -84 -47 -237 10 -304 24
                -28 25 -37 25 -148 0 -66 4 -126 10 -134 8 -12 21 -11 93 13 46 15 92 27 103
                27 10 0 55 -12 98 -26 44 -13 85 -23 93 -20 10 4 13 35 13 126 0 113 2 123 25
                158 131 191 -5 446 -234 441 -25 0 -60 -5 -77 -10z m159 -40 c47 -13 112 -70
                138 -121 62 -121 9 -272 -116 -329 -53 -25 -147 -24 -200 0 -85 39 -138 125
                -137 221 1 166 151 275 315 229z"/>
                <path d="M420 604 c-6 -16 -13 -35 -15 -41 -2 -7 -20 -13 -40 -13 -41 0 -45
                -13 -10 -36 23 -15 25 -21 19 -60 -3 -24 -3 -44 0 -44 4 0 20 10 36 21 l28 22
                27 -22 c35 -27 46 -19 34 25 -9 32 -8 37 15 55 35 28 33 37 -11 41 -31 3 -38
                8 -47 35 -16 46 -24 50 -36 17z"/>
                </g>
                </svg>
                </div>
                <div class="container card border border-white">
                  <h1 class="text-dark">Apple Certification</h1>
                  <p class="text-light-emphasis">100% of MobileService team of experts and technicians are trained and certified by Apple.</p>
                </div>
              </div>
               <div class="container card border border-white">
                      <div class="container card border border-white">
                           <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-shield-lock-fill" viewBox="0 0 16 16">
                             <path fill-rule="evenodd" d="M8 0c-.69 0-1.843.265-2.928.56-1.11.3-2.229.655-2.887.87a1.54 1.54 0 0 0-1.044 1.262c-.596 4.477.787 7.795 2.465 9.99a11.8 11.8 0 0 0 2.517 2.453c.386.273.744.482 1.048.625.28.132.581.24.829.24s.548-.108.829-.24a7 7 0 0 0 1.048-.625 11.8 11.8 0 0 0 2.517-2.453c1.678-2.195 3.061-5.513 2.465-9.99a1.54 1.54 0 0 0-1.044-1.263 63 63 0 0 0-2.887-.87C9.843.266 8.69 0 8 0m0 5a1.5 1.5 0 0 1 .5 2.915l.385 1.99a.5.5 0 0 1-.491.595h-.788a.5.5 0 0 1-.49-.595l.384-1.99A1.5 1.5 0 0 1 8 5"/>
                           </svg>
                      </div>
                      <div class="container card border border-white">
                             <h1 class="text-dark">Absolute security</h1>
                            <p class="text-light-emphasis">Information provided by customers is strictly protected according to the highest control standards.</p>
                     </div>
               </div>
                <div class="container card border border-white">
                      <div class="container card border border-white">
                            <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 576 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M316.9 18C311.6 7 300.4 0 288.1 0s-23.4 7-28.8 18L195 150.3 51.4 171.5c-12 1.8-22 10.2-25.7 21.7s-.7 24.2 7.9 32.7L137.8 329 113.2 474.7c-2 12 3 24.2 12.9 31.3s23 8 33.8 2.3l128.3-68.5 128.3 68.5c10.8 5.7 23.9 4.9 33.8-2.3s14.9-19.3 12.9-31.3L438.5 329 542.7 225.9c8.6-8.5 11.7-21.2 7.9-32.7s-13.7-19.9-25.7-21.7L381.2 150.3 316.9 18z"/></svg>
                      </div>
                      <div class="container card border border-white">
                            <h1 class="text-dark">Classy service</h1>
                            <p class="text-light-emphasis">With the customer-centric motto, MobileService is committed to providing outstanding service quality to customers.</p>
                      </div>
                </div>
                 <div class="container card border border-white">
                      <div class="container card border border-white">
                          <svg xmlns="http://www.w3.org/2000/svg"  width="100" height="100" viewBox="0 0 576 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M400 96l0 .7c-5.3-.4-10.6-.7-16-.7H256c-16.5 0-32.5 2.1-47.8 6c-.1-2-.2-4-.2-6c0-53 43-96 96-96s96 43 96 96zm-16 32c3.5 0 7 .1 10.4 .3c4.2 .3 8.4 .7 12.6 1.3C424.6 109.1 450.8 96 480 96h11.5c10.4 0 18 9.8 15.5 19.9l-13.8 55.2c15.8 14.8 28.7 32.8 37.5 52.9H544c17.7 0 32 14.3 32 32v96c0 17.7-14.3 32-32 32H512c-9.1 12.1-19.9 22.9-32 32v64c0 17.7-14.3 32-32 32H416c-17.7 0-32-14.3-32-32V448H256v32c0 17.7-14.3 32-32 32H192c-17.7 0-32-14.3-32-32V416c-34.9-26.2-58.7-66.3-63.2-112H68c-37.6 0-68-30.4-68-68s30.4-68 68-68h4c13.3 0 24 10.7 24 24s-10.7 24-24 24H68c-11 0-20 9-20 20s9 20 20 20H99.2c12.1-59.8 57.7-107.5 116.3-122.8c12.9-3.4 26.5-5.2 40.5-5.2H384zm64 136a24 24 0 1 0 -48 0 24 24 0 1 0 48 0z"/></svg>
                      </div>
                      <div class="container card border border-white">
                           <h1 class="text-dark">Save</h1>
                           <p class="text-light-emphasis">MobileService regularly has incentive programs to help customers save more when repairing products.</p>
                      </div>
                 </div>
    </div>
 </div>
 <br>
 <hr>
 <div class="container">
    <div class="d-flex justify-content-center">
       <p class="fs-1 font-bold text-center text-dark">Genuine Apple accessories at MobileService</p>
    </div>
     <br>
     <div class="row row-cols-1 row-cols-md-4 g-4">
        <div class="container text-center">
        <img src="<c:url value="/resources/img/login/img_1.png"/>" alt="image" class="rounded" >
        <br>
        <div class="container mt-3">
          <p class="fs-5 font-bolder text-dark text-center">Earphone</p>
        </div>
        </div>
          <div class="container text-center">
                <img src="<c:url value="/resources/img/login/img_2.png"/>" alt="image" class="rounded" >
                <br>
                <div class="container mt-3">
                  <p class="fs-5 font-bolder text-dark text-center">Cable | Charging</p>
                </div>
                </div>
                 <div class="container text-center">
                    <img src="<c:url value="/resources/img/login/img_3.png"/>" alt="image" class="rounded" >
                     <br>
                     <div class="container mt-3">
                         <p class="fs-5 font-bolder text-dark text-center">Back cover | Holster</p>
                     </div>
                </div>
                 <div class="container text-center">
                      <img src="<c:url value="/resources/img/login/img_4.png"/>" alt="image" class="rounded" >
                       <br>
                       <div class="container mt-3">
                         <p class="fs-5 font-bolder text-dark text-center">Apple Watch Band</p>
                       </div>
                 </div>
                  <div class="container text-center">
                       <img src="<c:url value="/resources/img/login/img_5.png"/>" alt="image" class="rounded" >
                       <br>
                       <div class="container mt-3">
                           <p class="fs-5 font-bolder text-dark text-center">AirTag</p>
                       </div>
                  </div>
                  <div class="container text-center">
                       <img src="<c:url value="/resources/img/login/img_6.png"/>" alt="image" class="rounded" >
                       <br>
                       <div class="container mt-3">
                            <p class="fs-5 font-bolder text-dark text-center">Mouse | Trackpad</p>
                       </div>
                  </div>
                  <div class="container text-center">
                       <img src="<c:url value="/resources/img/login/img_7.png"/>" alt="image" class="rounded" >
                       <br>
                       <div class="container mt-3">
                            <p class="fs-5 font-bolder text-dark text-center">Apple TV</p>
                       </div>
                  </div>
                   <div class="container text-center">
                       <img src="<c:url value="/resources/img/login/img_8.png"/>" alt="image" class="rounded" >
                       <br>
                       <div class="container mt-3">
                           <p class="fs-5 font-bolder text-dark text-center">Keyboard</p>
                       </div>
                   </div>
     </div>
     <br>
     <div class="d-flex justify-content-left">
           <p class="fs-5 text-left font-medium text-dark-emphasis">Note: Products are displayed at MobileService. Please come and buy directly with many attractive promotions.</p>
     </div>
 </div>
 <br>
 <hr>
 <div class="container">
      <div class="d-flex justify-content-center">
      <p class="fs-1 font-bold text-center text-body-secondary">MobileService warranty process</p>
      </div>
      <br>
      <div class="d-flex justify-content-around align-items-center">
       <div class="container ">
         <div class="container text-center">
         <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100"    viewBox="0 0 384 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M280 64h40c35.3 0 64 28.7 64 64V448c0 35.3-28.7 64-64 64H64c-35.3 0-64-28.7-64-64V128C0 92.7 28.7 64 64 64h40 9.6C121 27.5 153.3 0 192 0s71 27.5 78.4 64H280zM64 112c-8.8 0-16 7.2-16 16V448c0 8.8 7.2 16 16 16H320c8.8 0 16-7.2 16-16V128c0-8.8-7.2-16-16-16H304v24c0 13.3-10.7 24-24 24H192 104c-13.3 0-24-10.7-24-24V112H64zm128-8a24 24 0 1 0 0-48 24 24 0 1 0 0 48z"/></svg>
         </div>
         <div class="container text-center mt-3">
         <p class="font-bold  text-dark">1. General check before repair</p>
         </div>
       </div>
         <div class="container ">
                <div class="container text-center">
               <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M50.7 58.5L0 160H208V32H93.7C75.5 32 58.9 42.3 50.7 58.5zM240 160H448L397.3 58.5C389.1 42.3 372.5 32 354.3 32H240V160zm208 32H0V416c0 35.3 28.7 64 64 64H384c35.3 0 64-28.7 64-64V192z"/></svg>
                </div>
                <div class="container text-center mt-3">
                <p class="font-bold  text-dark">2.  Place components</p>
                </div>
          </div>
           <div class="container ">
                <div class="container text-center">
                   <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M78.6 5C69.1-2.4 55.6-1.5 47 7L7 47c-8.5 8.5-9.4 22-2.1 31.6l80 104c4.5 5.9 11.6 9.4 19 9.4h54.1l109 109c-14.7 29-10 65.4 14.3 89.6l112 112c12.5 12.5 32.8 12.5 45.3 0l64-64c12.5-12.5 12.5-32.8 0-45.3l-112-112c-24.2-24.2-60.6-29-89.6-14.3l-109-109V104c0-7.5-3.5-14.5-9.4-19L78.6 5zM19.9 396.1C7.2 408.8 0 426.1 0 444.1C0 481.6 30.4 512 67.9 512c18 0 35.3-7.2 48-19.9L233.7 374.3c-7.8-20.9-9-43.6-3.6-65.1l-61.7-61.7L19.9 396.1zM512 144c0-10.5-1.1-20.7-3.2-30.5c-2.4-11.2-16.1-14.1-24.2-6l-63.9 63.9c-3 3-7.1 4.7-11.3 4.7H352c-8.8 0-16-7.2-16-16V102.6c0-4.2 1.7-8.3 4.7-11.3l63.9-63.9c8.1-8.1 5.2-21.8-6-24.2C388.7 1.1 378.5 0 368 0C288.5 0 224 64.5 224 144l0 .8 85.3 85.3c36-9.1 75.8 .5 104 28.7L429 274.5c49-23 83-72.8 83-130.5zM56 432a24 24 0 1 1 48 0 24 24 0 1 1 -48 0z"/></svg>
                </div>
                <div class="container text-center mt-3">
                <p class="font-bold  text-dark">3.   Repair | Replace</p>
                </div>
           </div>
           <div class="container ">
                   <div class="container text-center">
                    <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 384 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M192 0c-41.8 0-77.4 26.7-90.5 64H64C28.7 64 0 92.7 0 128V448c0 35.3 28.7 64 64 64H320c35.3 0 64-28.7 64-64V128c0-35.3-28.7-64-64-64H282.5C269.4 26.7 233.8 0 192 0zm0 64a32 32 0 1 1 0 64 32 32 0 1 1 0-64zM305 273L177 401c-9.4 9.4-24.6 9.4-33.9 0L79 337c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l47 47L271 239c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9z"/></svg>
                   </div>
                   <div class="container text-center mt-3">
                     <p class="font-bold  text-dark">4.   General check after repair</p>
                   </div>
            </div>
            <div class="container ">
                    <div class="container text-center">
                    <svg version="1.0" width="100" height="100" xmlns="http://www.w3.org/2000/svg"
                     width="512.000000pt" height="512.000000pt" viewBox="0 0 512.000000 512.000000"
                     preserveAspectRatio="xMidYMid meet">

                    <g transform="translate(0.000000,512.000000) scale(0.100000,-0.100000)"
                    fill="#000000" stroke="none">
                    <path d="M1281 5102 c-28 -14 -91 -102 -341 -477 -169 -254 -315 -475 -324
                    -492 -14 -29 -16 -127 -16 -1033 l0 -1000 -240 0 c-222 0 -244 -2 -280 -20
                    -26 -13 -47 -34 -60 -60 -20 -38 -20 -57 -20 -970 0 -913 0 -932 20 -970 13
                    -26 34 -47 60 -60 37 -19 58 -20 374 -20 208 0 355 4 388 11 71 15 150 55 204
                    102 l44 38 137 -35 c157 -40 306 -69 473 -93 97 -13 250 -17 975 -20 761 -4
                    871 -2 958 12 213 36 401 127 556 271 43 39 202 242 471 601 434 579 446 598
                    457 723 15 179 -93 371 -248 442 l-49 23 0 1013 c0 918 -2 1016 -16 1045 -9
                    17 -155 238 -324 492 -264 396 -312 462 -344 478 -34 16 -123 17 -1429 16
                    -1285 0 -1395 -2 -1426 -17z m829 -582 l0 -300 -540 0 -540 0 200 300 200 300
                    340 0 340 0 0 -300z m900 0 l0 -300 -300 0 -300 0 0 300 0 300 300 0 300 0 0
                    -300z m1180 0 l200 -300 -540 0 -540 0 0 300 0 300 340 0 340 0 200 -300z
                    m-2080 -1148 c0 -514 1 -549 19 -582 22 -42 83 -80 129 -80 44 0 66 12 274
                    152 l178 118 197 -132 c224 -149 253 -159 327 -116 79 46 76 24 76 640 l0 548
                    605 0 605 0 0 -924 0 -925 -22 -7 c-64 -20 -139 -87 -358 -322 -128 -139 -235
                    -252 -236 -252 -2 0 -16 26 -31 58 -34 70 -131 170 -196 201 -100 48 -126 51
                    -557 51 -514 0 -488 -6 -690 148 -105 79 -238 145 -366 179 -89 24 -116 27
                    -264 26 -146 0 -176 -3 -264 -26 -120 -32 -262 -99 -349 -166 l-65 -49 -59 57
                    c-32 31 -82 67 -110 81 l-53 25 0 922 0 923 605 0 605 0 0 -548z m900 158 l0
                    -390 -102 68 c-197 132 -199 132 -376 13 l-122 -81 0 390 0 390 300 0 300 0 0
                    -390z m-1015 -1695 c96 -26 196 -80 291 -155 49 -38 121 -85 159 -104 137 -69
                    143 -69 630 -75 396 -5 443 -8 472 -24 38 -20 73 -82 73 -128 0 -46 -39 -108
                    -82 -130 -35 -18 -67 -19 -608 -19 -552 0 -572 -1 -610 -20 -45 -23 -80 -80
                    -80 -130 0 -50 35 -107 80 -130 38 -19 57 -20 667 -20 377 0 646 4 673 10 56
                    13 114 37 164 70 22 14 199 196 394 405 194 209 368 388 385 398 120 66 264
                    -73 201 -195 -30 -58 -761 -1023 -815 -1076 -75 -73 -177 -135 -289 -174 l-95
                    -33 -865 0 c-1001 0 -1018 1 -1392 91 l-148 36 0 576 0 577 71 60 c136 116
                    242 172 379 201 82 17 263 11 345 -11z m-1175 -55 c26 -13 47 -34 60 -60 19
                    -38 20 -58 20 -670 0 -612 -1 -632 -20 -670 -13 -26 -34 -47 -60 -60 -36 -18
                    -58 -20 -280 -20 l-240 0 0 750 0 750 240 0 c222 0 244 -2 280 -20z"/>
                    <path d="M3398 2379 c-43 -22 -78 -81 -78 -129 0 -50 35 -107 80 -130 37 -19
                    58 -20 370 -20 312 0 333 1 370 20 45 23 80 80 80 130 0 50 -35 107 -80 130
                    -37 19 -58 20 -372 20 -312 -1 -335 -2 -370 -21z"/>
                    </g>
                    </svg>
                    </div>
                     <div class="container text-center mt-3">
                        <p class="font-bold  text-dark">5.   Return the product
</p>
                     </div>
            </div>
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