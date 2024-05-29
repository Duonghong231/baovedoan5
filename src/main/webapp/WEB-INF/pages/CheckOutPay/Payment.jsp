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
  <c:if test="${cartList.isEmpty()}">
  <div class="container" style="margin-top:130px;">
       <div class="d-flex justify-content-center">
        <img src="<c:url value="/resources/img/login/images11.jpeg"/>" alt="Banner" class="image d-flex justify-content-center" style="width:300px; height:300px;">
        </div>
        <br>
        <div class="d-flex justify-content-center" style="padding-left:35px; padding-right:35px;">
        <p class="text-dark fs-3 text-center font-medium" style="width:500px;">Not yet in Cart.Please comeback in the page<a href="/user/" class="fs-3 font-medium text-primary"> add more To cart</a></p>
        </div>
  </div>
  </c:if>
  <c:if test="${not cartList.isEmpty()}">
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
                      <div class="py-2 text-uppercase">Remove</div>
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="cart"  items="${cartList}">
                        <tr>
                                           <th scope="row" class="border-0">
                                             <div class="p-2">
                                               <img src="/user/getProductPhoto/<c:out value='${cart.product.productId}'/>" alt="" width="70" class="img-fluid rounded shadow-sm">
                                               <div class="ml-3 d-inline-block align-middle">
                                                 <h5 class="mb-0"> <a href="#" class="text-dark d-inline-block align-middle">${cart.product.productName}</a></h5><span class="text-muted font-weight-normal font-italic d-block">Category: ${cart.product.categories.categoryName}</span>
                                               </div>
                                             </div>
                                           </th>
                                           <td class="border-0 align-middle"><strong>$ ${cart.product.productPrice}</strong></td>
                                           <td class="border-0 align-middle"><strong>${cart.quantity}</strong></td>
                                           <td class="border-0 align-middle"><a href="/user/removeToCart/${cart.product.productId}" class="text-dark">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" fill="currentColor" class="bi bi-trash-fill" viewBox="0 0 16 16">
                                                      <path d="M2.5 1a1 1 0 0 0-1 1v1a1 1 0 0 0 1 1H3v9a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V4h.5a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H10a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1zm3 4a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 .5-.5M8 5a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7A.5.5 0 0 1 8 5m3 .5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 1 0"/>
                                                    </svg>
                                           </a></td>
                                         </tr>
                  </c:forEach>

                </tbody>
              </table>
            </div>
           </div>
           <div class="row py-5 p-4 bg-white rounded shadow-sm">
                   <div class="col-lg-6">
                     <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">Customer information</div>
                     <div class="p-4">
                     <form action="/user/checkOut" method="post" enctype="multipart/form-data" novalidate>
                          <div class="form-floating mb-3">
                             <input type="text" name="customerName" class="form-control border border-primary" id="floatingInput" placeholder="Customer Name" required>
                              <label for="floatingInput">Customer Name</label>
                           </div>
                     <div class="form-floating mb-3">
                           <input type="email" name="customerEmail" class="form-control border border-primary" id="floatingPassword" placeholder="Customer Email" required>
                           <label for="floatingPassword">Customer Email</label>
                      </div>
                      <div class="form-floating mb-3">
                            <input type="text" name="customerPhone" class="form-control border border-primary" id="floatingPassword" placeholder="Customer Phone" required>
                            <label for="floatingPassword">Customer Phone</label>
                      </div>
                        <div class="form-floating mb-3">
                             <input type="text" name="customerAddress" class="form-control border border-primary" id="floatingPassword" placeholder="Customer Address" required>
                             <label for="floatingPassword">Customer Address</label>
                        </div>
                         <div class="invalid-feedback">
                                Please choose a information customer
                              </div>
                         <div class="form-floating mb-3">
                             <input type="submit"  class="btn btn-dark rounded-pill py-2 btn-block" style="width:550px;" value="Pay now">
                         </div>
                         <div class="form-floating mb-3">
                             <p class="text-center fs-5 text-dark font-medium">----------------or------------------</p>
                         </div>
                          <div id="paypal-button-container"></div>

                        </form>
                     </div>
                   </div>
                   <div class="col-lg-6">
                     <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">Order summary </div>
                     <div class="p-4">
                       <p class="font-italic mb-4">Shipping and additional costs are calculated based on values you have entered.</p>
                       <ul class="list-unstyled mb-4">
                         <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Order Subtotal </strong><strong>$ ${totalSumCart}</strong></li>
                         <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Shipping and handling</strong><strong>Free ship</strong></li>
                         <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Tax</strong><strong>$0.00</strong></li>
                         <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Total</strong>
                           <h5 class="font-weight-bold">$ ${totalSumCart}</h5>
                         </li>
                       </ul>

                     </div>
                   </div>
                 </div>

           </div>
           </c:if>
          </div>
</main>
 <script src="https://www.paypal.com/sdk/js?client-id=AR7lVKxKs9EDBJNJz5-QsMpsW3e_T2XT0fQPjm3xvwo9k-o-Iz7g4ah71pJSs-cpVgVxrGRSjdJlRHgP"></script>
<script>
paypal.Buttons({
  style: {
    layout: 'horizontal', // Set layout to horizontal
    color: 'gold', // Specify button color
    shape: 'pill', // Specify button shape
    label: 'paypal', // Specify button label
    tagline: false // Disable tagline
  },
  createOrder: function(data, actions) {
    return actions.order.create({
      purchase_units: [{
        amount: {
          value: '${totalSumCart}' // Specify the amount
        }
      }]
    });
  },
  onApprove: function(data, actions) {
    return actions.order.capture().then(function(details) {
      alert('Transaction completed by ' + details.payer.name.given_name);
        window.location.replace('/user/completePayPal');
    });
  }
}).render('#paypal-button-container');
</script>
</body>
</html>