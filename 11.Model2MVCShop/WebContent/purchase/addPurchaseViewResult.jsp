<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
    <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
  <script type="text/javascript">
  
  $(function() {
	  
	  $(".previous").on("click", function(){
		 
		  history.go(-1);
		  
	  });
	  
	  $("li:contains('����')").on("click", function(){
		  
		  self.location = "/product/getProduct?prodNo=${product.prodNo}&menu=manage";
		  
	  });
	  
	  $("#addPur").on("click", function(){
		  
		  self.location = "/purchase/addPurchaseView?prodNo=${product.prodNo}";
		  
	  });
	  
	  $("li:contains('��ǰ �ı� ����')").on("click", function(){
		  
		  self.location = "/product/listReview?prodNo=${product.prodNo}";
		  
	  });
	  
  });
  
  </script>
  
</head>
<body>
	
<jsp:include page="/layout/toolbar.jsp" />

<div class="container" >

  <div class="page-header text-info">
					
	<h3><span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>���� �Ϸ�</h3>
					
  </div>

<div class="row">
  
  <div class="col-md-5">
      <img class="img-thumbnail" src="/images/uploadFiles/${purchase.purchaseProd.fileName}" alt="..." height="300" width="300">    
  </div>
  <div class="col-md-5">
  		
  		<div class="row">
	  		<div class="col-md-8"><strong>��ǰ��</strong></div>
			<div class="col-md-4">${purchase.purchaseProd.prodName}</div>
		</div>
					
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-8"><strong>���� ����</strong></div>
			<div class="col-md-4">${purchase.amountPur}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-8"><strong>��� ���ϸ���</strong></div>
			<div class="col-md-4">${purchase.useMileage}��</div>
		</div>
		
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-8 "><strong>��� ��</strong></div>
			<div class="col-md-4">${purchase.divyAddr}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-8 "><strong>��� �����</strong></div>
			<div class="col-md-4">${purchase.divyDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-8"><strong>��û ����</strong></div>
			<div class="col-md-4">${purchase.divyRequest}</div>
		</div>
		
		<hr/>
		
  </div>  
  
</div><!-- row end -->

<div><hr/></div>

		
</div><!-- container end -->




</body>
</html>