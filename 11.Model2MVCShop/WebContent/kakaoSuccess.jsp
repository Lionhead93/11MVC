<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<style>
	
	   body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
	   body {
            padding-top : 50px;
        }
	
	</style>
   	
	<script type="text/javascript">
	
	$(function() {
		
		$("a[href='#']:contains('계속 진행')").on("click", function(){
			  
			  self.location = "/purchase/addPurchaseView?prodNo=${param.prodNo}";
			  
		  });	
		
	});
		
		
	</script>	
	
</head>

<body>
	
	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
	
	<br/>
		
		<h1 class="bg-success text-center">결 제 완 료</h1>
	    
	    <h1 class="bg-success text-center">결제번호 : ${param.pg_token}</h1>
	     
	    <div class="text-center"> 
	    <br/><br/>
	    <a class="btn btn-primary btn-lg" href="#" role="button">계속 진행</a>
		</div>
	</div>

</body>

</html>