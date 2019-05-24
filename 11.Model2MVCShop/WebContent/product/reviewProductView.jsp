<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
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

	function fncAddReview(){
		//Form 유효성 검증
	 	var review = $("input[name='review']").val();
		
	
		if(review == null || review.length<1){
			alert("한줄평은 반드시 입력하여야 합니다.");
			return;
		}
		
		$("form").attr("method" , "POST").attr("action" , "/product/addReview").submit();
	
	}
	$(function() {
		
		$( "button" ).on("click" , function() {
			fncAddReview();
		});
		
		$( "a[href='#']" ).on("click" , function() {
			$("form")[0].reset();
		});
		
	});
	

</script>
</head>
<body>

	
	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
	<br/>
		<h1 class="bg-info text-center">${product.prodName} <small>후기 작성</small></h1>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
					<input type="hidden" name="reviewProdNo" value="${product.prodNo}">
					<input type="hidden" name="reviewTranNo" value="${product.proTranNo}">
					<input type="hidden" name="userId" value="${user.userId}">
		<br/>
		  <div class="form-group">
		    <label for="score" class="col-sm-offset-1 col-sm-3 control-label">
		    	별점
		    </label>
		    <div class="col-sm-4">
		      <select class="form-control" id="score" name="score" >
						<option value="0" >☆☆☆☆☆</option>
						<option value="1" >☆☆☆☆★</option>
						<option value="2" >☆☆☆★★ </option>
						<option value="3" >☆☆★★★ </option>
						<option value="4" >☆★★★★ </option>
						<option value="5" >★★★★★ </option>
			  </select>
		    </div>
		  </div>
		<br/>  
		  <div class="form-group">
		    <label for="review" class="col-sm-offset-1 col-sm-3 control-label">한줄 평</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="review" name="review" placeholder="간단한 리뷰">
		    </div>
		  </div>
		<br/>  
		  <div class="form-group">
		    <label for="reviewBox" class="col-sm-offset-1 col-sm-3 control-label">상세 리뷰</label>
		    <div class="col-sm-4">
		      <textarea class="form-control" id="reviewBox" name="reviewBox" rows="5" cols="40" placeholder="상세 리뷰"></textarea>	
		    </div>
		  </div>
		
		<br/>  
		  
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >등 &nbsp;록</button>
			  <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
		    </div>
		  </div>
		  
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
	
</body>

</html>