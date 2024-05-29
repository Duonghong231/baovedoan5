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
                      <a class="fs-5 nav-link px-0  d-sm-inline text-center"  style="color:green;" href="<c:url value="/admin/paycheck" />">Pay Check</a>
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
           <p class="fs-3 font-bold text-info">List of products</p>
           <br>
           <div class="d-flex justify-content-around">
               <form action="/admin/search" method="get" class="input-group flex-nowrap" role="search">
                     <input  name="keyword"  class="form-control me-2"  type="search" placeholder="Search for product of list " aria-label="Search">
                     <button type="submit" class="btn btn-light">
                          <svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                                                  </svg>
                     </button>
                   </form>
                   <button class="btn btn-info text-white " style="margin-left:10px;" type="submit"  onclick="window.location.href='/admin/addProduct'">Add Product</button>
           </div>
           <br>
            <table class="table">
              <thead class="table table-success table-bordered border-primary">
                <tr>
                  <th scope="col">Product Id</th>
                  <th scope="col">Product Name</th>
                  <th scope="col">Product Description</th>
                   <th scope="col">Product quantity</th>
                    <th scope="col">Product price</th>
                     <th scope="col">category name</th>
                  <th scope="col">product photo</th>
                  <th scope="col">actionProduct</th>

                </tr>
              </thead>
              <tbody class="table-light">
              <c:forEach var="product" items="${listStu}">
                <tr>
                  <th scope="row">${product.productId}</th>
                  <td>${product.productName}</td>
                   <td>${product.productDescription}</td>
                     <td>${product.quantity}</td>
                     <td>${product.productPrice}</td>
                  <td>${product.categories.categoryName}</td>
                  <td><img width="100" height="100" src="getProductPhoto/<c:out value='${product.productId}'/>"></td>
                   <td>
                                        <button class="btn btn-primary" type="button" onclick="window.location.href='/admin/EditProduct/${product.productId}'">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" fill="currentColor" class="bi bi-pen-fill" viewBox="0 0 16 16">
                                                      <path d="m13.498.795.149-.149a1.207 1.207 0 1 1 1.707 1.708l-.149.148a1.5 1.5 0 0 1-.059 2.059L4.854 14.854a.5.5 0 0 1-.233.131l-4 1a.5.5 0 0 1-.606-.606l1-4a.5.5 0 0 1 .131-.232l9.642-9.642a.5.5 0 0 0-.642.056L6.854 4.854a.5.5 0 1 1-.708-.708L9.44.854A1.5 1.5 0 0 1 11.5.796a1.5 1.5 0 0 1 1.998-.001"/>
                                                    </svg>
                                                          </button>
                                        <button class="btn btn-danger" onclick="window.location.href='/admin/DeleteProduct/${product.productId}'" type="button">X</button>
                                    </td>
                </tr>
                </c:forEach>

              </tbody>
            </table>
        </div>
    </div>
</div>
    </main>
    </body>

</html>