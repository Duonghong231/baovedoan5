<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib  uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Male_Fashion Template">
        <meta name="keywords" content="Male_Fashion, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
       <link rel="stylesheet" type="text/css" href='${pageContext.request.getContextPath()}/webjars/bootstrap/5.3.2/css/bootstrap.min.css' />
      <script type="text/javascript" src="${pageContext.request.getContextPath()}/webjars/bootstrap/5.3.2/js/bootstrap.min.js"></script>
       <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-FI/8gtitvds5Iexw5jv1Jb5AMd1EDSxzmVzJ6ft6N0U3vd4bXkvpJx3uZ1gHuvTX5xSl8YAG8ekn6Dr2Lrm3Ig==" crossorigin="anonymous" referrerpolicy="no-referrer" />
       <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <title>Mobile Shop</title>

    </head>

    <body>
    <header>
    <nav class="navbar bg-primary" data-bs-theme="dark">
      <div class="container-fluid">
        <a class="navbar-brand">Mobile Shop</a>
<sec:authorize access="isAuthenticated()">
              <p  class="nav-link fw-semibold mt-3" style="color:orange;">
                <sec:authentication property="principal.username"/>
              </p>
</sec:authorize>
      </div>
    </nav>
    </header>
    <main  class="container-1" >
<div class="container-fluid">
    <div class="row flex-nowrap">
        <div class="col-auto col-md-3 col-xl-2 px-sm-2 px-0 bg-dark">
            <div class="d-flex flex-column align-items-center align-items-sm-start px-3 pt-2 text-white min-vh-100">
                <p  class="d-flex align-items-center justify-content-center mt-3 pb-3 mb-md-0 me-md-auto text-white text-center text-decoration-none">
                    <span class="fs-5 d-none d-sm-inline text-center"> data management</span>
                </p>
                 <sec:authorize access="hasRole('ROLE_ADMIN')">
                 <ul class="nav nav-pills nav-flush flex-sm-column flex-row flex-nowrap mb-auto mx-auto text-center align-items-center">
                     <li class="nav-item">
                      <a class="fs-5 nav-link px-0 d-sm-inline text-center " style="color:green;" href="<c:url value="/admin/ProductList" />" >Product</a>
                     </li>
                     <li  class="nav-item">
                      <a class="fs-5 nav-link px-0  d-sm-inline text-center"  style="color:green;"  href="<c:url value="/admin/CategoryList" />">Category</a>
                    </li>
                    <li  class="nav-item">
                      <a class="fs-5 nav-link px-0  d-sm-inline text-center"  style="color:green;" href="<c:url value="/admin/CustomerList" />">Look up orders</a>
                    </li>
                      <li  class="nav-item">
                                          <a class="fs-5 nav-link px-0  d-sm-inline text-center"  style="color:green;" href="<c:url value="/admin/Fix" />">Repair Services</a>
                                         </li>
                    <li  class="nav-item">
                      <a class="fs-5 nav-link px-0  d-sm-inline text-center"  style="color:green;" href="<c:url value="/admin/CheckList" />">Pay Check</a>
                    </li>
                      </ul>
                 </sec:authorize>
                   <p  class="d-flex align-items-center justify-content-center mt-3 pb-3 mb-md-0 me-md-auto text-white text-center text-decoration-none">
                                     <span class="fs-5 d-none d-sm-inline text-center"> statistics</span>
                                 </p>
                                   <sec:authorize access="hasRole('ROLE_ADMIN')">
                                                  <ul class="nav nav-pills nav-flush flex-sm-column flex-row flex-nowrap mb-auto mx-auto text-center align-items-center">
                                                      <li class="nav-item">
                                                       <a class="fs-5 nav-link px-0 d-sm-inline text-center " style="color:fuchsia;" href="<c:url value="/admin/ChartRevenue" />" >Daily Revenue statistics</a>
                                                      </li>
                                                        <li class="nav-item">
                                                            <a class="fs-5 nav-link px-0 d-sm-inline text-center " style="color:fuchsia;" href="<c:url value="/admin/ChartCategory" />" >statistics in category</a>
                                                        </li>
                                                       </ul>
                                                  </sec:authorize>

                <hr>
                <div class="dropdown pb-4">
                     <sec:authorize access="isAuthenticated()">
                           <div class="d-grid ">
                            <button  class="btn btn-warning  d-sm-inline text-center" style="color:orangered;" onclick="window.location.href='<c:url value="/logout" />'">Logout</button>
                          </div>
                     </sec:authorize>
                    <sec:authorize access="!isAuthenticated()">
                          <a href="<c:url value="/login" />">Login</a>
                     </sec:authorize>
                </div>
            </div>
        </div>
        <div class="col py-3">
           <p class="fs-3 font-bold text-info text-center">List of economic on revenue in development count a Order </p>
           <br>

            <div class="container">
                       <canvas id="priceChart" width="400" height="150"></canvas>
             </div>
             <div class="container d-flex justify-content-around">
             <div class="container ">
             <p class="text-center font-bolder">Chart in list on category to number</p>
             <br>
             <div class="container" style="width:300px; height:300px;">
                <canvas id="myChart" width="400" height="150"></canvas>
             </div>
             </div>
             <div class="container">
             <p class="text-center font-bolder">Chart in list on orderDetail in buy to quantity in product</p>
             <br>
             <div class="container" style="width:300px; height:300px;">
                <canvas id="quantityChart" width="400" height="200"></canvas>
             </div>
             </div>
             </div>
        </div>
    </div>
</div>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script>
        fetch('<c:url value="/admin/chartData" />')
                   .then(response => response.json())
                   .then(data => {
                       const labels = data.map(item => item.orderDate);
                       const quantities = data.map(item =>item.totalQuantity);
                       const totalPrices = data.map(item => item.totalPrice);


                       const ctx1 = document.getElementById('quantityChart');
                       new Chart(ctx1, {
                           type: 'polarArea',
                           data: {
                               labels: labels,
                               datasets: [{
                                   label: 'Total Quantity',
                                   data: quantities,
                                   backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                   borderColor: 'rgba(75, 192, 192, 1)',
                                   borderWidth: 1
                               }]
                           },
                           options: {
                               scales: {
                                   y: {
                                       beginAtZero: true
                                   }
                               }
                           }
                       });

                       const ctx2 = document.getElementById('priceChart');
                       new Chart(ctx2, {
                           type: 'line',
                           data: {
                               labels: labels,
                               datasets: [{
                                   label: 'Total Price',
                                   data: totalPrices,
                                   backgroundColor: 'rgba(153, 102, 255, 0.2)',
                                   borderColor: 'rgba(153, 102, 255, 1)',
                                   borderWidth: 1
                               }]
                           },
                           options: {
                               scales: {
                                   y: {
                                       beginAtZero: true
                                   }
                               }
                           }
                       });
                   });

                    const ctx = document.getElementById('myChart');
                var categoryData = {
                           labels: [<c:forEach var="category" items="${categoryDataValue.keySet()}">
                                       '<c:out value="${category}"/>',
                                    </c:forEach>],
                           datasets: [{
                               label: 'Total in category',
                               data: [<c:forEach var="count" items="${categoryDataValue.values()}">
                                       <c:out value="${count}"/>,
                                      </c:forEach>],
                               backgroundColor: [
                                   'rgba(255, 99, 132, 0.2)',
                                   'rgba(54, 162, 235, 0.2)',
                                   'rgba(255, 206, 86, 0.2)',
                                   'rgba(75, 192, 192, 0.2)'
                               ],
                               borderColor: [
                                   'rgba(255, 99, 132, 1)',
                                   'rgba(54, 162, 235, 1)',
                                   'rgba(255, 206, 86, 1)',
                                   'rgba(75, 192, 192, 1)'
                               ],
                               borderWidth: 1
                           }]
                       };
                    new Chart(ctx, {
                              type: 'pie',
                              data: categoryData,
                              options: {
                                  scales: {
                                      yAxes: [{
                                          ticks: {
                                              beginAtZero: true
                                          }
                                      }]
                                  }
                              }
                          });
     </script>

    </body>
</html>