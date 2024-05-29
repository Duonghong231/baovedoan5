<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib  uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
 <head>
 <link rel="stylesheet" type="text/css" href='${pageContext.request.getContextPath()}/webjars/bootstrap/5.3.2/css/bootstrap.min.css' />
<script type="text/javascript" src="${pageContext.request.getContextPath()}/webjars/bootstrap/5.3.2/js/bootstrap.min.js"></script>
 </head>
<body >
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
<h2 style="text-align:center; margin-top:30px;" class="text-warning">Add products</h2>

<div class="container-1" style="display:inline-flex; width:100%; justify-content:center;">
<form action="/admin/insertImage" style="width:1000px; padding:10px;"  class="card" method="post" enctype="multipart/form-data">


<div class="form-floating mb-3">
  <input type="text" class="form-control" name="name" id="floatingInput"  placeholder="Name">
  <label for="floatingInput">name products</label>
</div>
<div class="form-floating mb-3">
  <input type="text" name="description" class="form-control" id="floatingPassword" placeholder="Password">
  <label for="floatingPassword">description products</label>
</div>

<div class="form-floating mb-3">
  <input type="text" name="price" class="form-control" id="floatingPassword" placeholder="Password">
  <label for="floatingPassword">Price products</label>
</div>
<div class="form-floating mb-3">
  <input type="number" name="quantity" class="form-control" id="floatingPassword" placeholder="Password">
  <label for="floatingPassword">quantity products</label>
</div>
<div class="form-floating mb-3">
  <input type="file" name="photo" class="form-control" id="floatingPassword" placeholder="Photo products">
  <label for="floatingPassword">Photo Products</label>
</div>
<select class="form-select" aria-label="Default select example" name="categoriesId">
        <option selected>Open this select menu</option>
        <c:forEach var="category1" items="${categories}">
               <option value="${category1.categoryId}">${category1.categoryName}</option>
        </c:forEach>
</select>
<br>
<input type="submit" class="btn btn-primary" value="submit">


</form>
</div>

       </div>
    </div>
</div>
    </main>


</body>
</html>