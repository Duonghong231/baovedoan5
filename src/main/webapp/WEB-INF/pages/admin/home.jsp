
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
 <head>
  <link rel="stylesheet" type="text/css" href='${pageContext.request.getContextPath()}/webjars/bootstrap/5.3.2/css/bootstrap.min.css' />
 <script type="text/javascript" src="${pageContext.request.getContextPath()}/webjars/bootstrap/5.3.2/js/bootstrap.min.js"></script>
  </head>
 </head>
<body >
<h2 style="text-align:center;" class="text-warning">Add products</h2>

<div class="container-1" style="display:inline-flex; width:100%; justify-content:center;">
<form action="insertImage" style="width:1000px; padding:10px;"  class="card" method="post" enctype="multipart/form-data">


<div class="form-floating mb-3">
  <input type="text" class="form-control" name="name" id="floatingInput" value="${productText.name}" placeholder="${productText.name}">
  <label for="floatingInput">name products</label>
</div>
<div class="form-floating mb-3">
  <input type="text" name="text" class="form-control" id="floatingPassword" placeholder="Password">
  <label for="floatingPassword">text products</label>
</div>
<div class="form-floating mb-3">
  <input type="text" name="price" class="form-control" id="floatingPassword" placeholder="Password">
  <label for="floatingPassword">Price products</label>
</div>
<div class="form-floating mb-3">
  <input type="file" name="photo" class="form-control" id="floatingPassword" placeholder="Photo products">
  <label for="floatingPassword">Photo Products</label>
</div>
<br>
<input type="submit" class="btn btn-primary" value="submit">


</form>
</div>


</body>
</html>