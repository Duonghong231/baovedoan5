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
  <div class="container">
        <div class="row">
          <div class="col-lg-12 p-5 bg-white rounded shadow-sm mb-5">


            <div class="table-responsive">
              <table class="table">
                <thead>
                  <tr>
                    <th scope="col" class="border-0 bg-light">
                      <div class="p-2 px-3 text-uppercase">Product</div>
                    </th>
                    <th scope="col" class="border-0 bg-light">
                      <div class="py-2 text-uppercase">Price</div>
                    </th>
                    <th scope="col" class="border-0 bg-light">
                      <div class="py-2 text-uppercase">Quantity</div>
                    </th>
                    <th scope="col" class="border-0 bg-light">
                      <div class="py-2 text-uppercase">Order Date</div>
                    </th>
                      <th scope="col" class="border-0 bg-light">
                           <div class="py-2 text-uppercase">Payment Date</div>
                         </th>
                         <th scope="col" class="border-0 bg-light">
                            <div class="py-2 text-uppercase">Customer Name</div>
                          </th>
                            <th scope="col" class="border-0 bg-light">
                                                      <div class="py-2 text-uppercase">Customer Address</div>
                                                    </th>
                               <th scope="col" class="border-0 bg-light">
                                           <div class="py-2 text-uppercase">Customer Check</div>
                                </th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="orderDetail"  items="${orderDetailList}">
                        <tr>
                                           <th scope="row" class="border-0">
                                             <div class="p-2">
                                               <img src="/user/getProductPhoto/<c:out value='${orderDetail.productList.productId}'/>" alt="" width="70" class="img-fluid rounded shadow-sm">
                                               <div class="ml-3 d-inline-block align-middle">
                                                 <h5 class="mb-0"> <a href="#" class="text-dark d-inline-block align-middle">${orderDetail.productList.productName}</a></h5><span class="text-muted font-weight-normal font-italic d-block">Category: ${orderDetail.productList.categories.categoryName}</span>
                                               </div>
                                             </div>
                                           </th>
                                           <td class="border-0 align-middle"><strong>$ ${orderDetail.productList.productPrice}</strong></td>
                                           <td class="border-0 align-middle"><strong>${orderDetail.quantity}</strong></td>
                                           <td class="border-0 align-middle">
                                                   <strong>${orderDetail.orderList.orderDate}</strong>
                                           </td>
                                           <td class="border-0 align-middle">
                                                   <strong>${orderDetail.orderList.paymentDate}</strong>
                                           </td>
                                           <td class="border-0 align-middle">
                                                   <strong>${orderDetail.orderList.customers.customerName}</strong>
                                           </td>
                                            <td class="border-0 align-middle">
                                                   <strong>${orderDetail.orderList.customers.customerAddress}</strong>
                                            </td>
                                          <td class="border-0 align-middle">
                                                  <strong>${orderDetail.orderList.customers.customerCheckout}</strong>
                                            </td>
                                         </tr>
                  </c:forEach>

                </tbody>
              </table>
            </div>
           </div>
           </div>
          </div>
</main>
</body>
</html>