<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
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
    <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<style>
	  body {
            padding-top : 50px;
        }
      .jumbotron {
      		background-color : smokegrey;
      }
    </style>
  <script type="text/javascript">
  
   function fncGetList(currentPage) {
		
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/product/listReview?prodNo=${product.prodNo}").submit();
			
	}
	
	$(function() {
		
		$("a[href='#']:contains('내 구매이력 보기')").on("click", function(){
			
			self.location = "/purchase/listPurchase?menu=user"
			
		});
		$(".previous").on("click", function(){
			
			history.go(-1);
			
		});
		
		
	});
  
  </script>
  
</head>
<body>
	
<jsp:include page="/layout/toolbar.jsp" />

<div class="container" >

  <div class="page-header text-center">
		
	<img class="img-thumbnail" src="/images/uploadFiles/${product.fileName}" alt="..." height="200" width="200">
	<div>
	<h3><span class="text-info">
	${product.prodName} 의 상품리뷰
	<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
	</span></h3>
	</div>
  </div>
  <div class="col-md-6 text-left">
		    	<span class="text-primary">
		    		전체  ${resultPage.totalCount } 건수 <br/><br/>
		    	</span>
  </div>
  
  <table class="table table-hover table-striped" >
  
  		<thead>
          <tr>
            <th align="left">한줄 평</th>
            <th align="left" >별점</th>
            <th align="left">작성일</th>
            <th align="left">작성자</th>
          </tr>
        </thead>
  		<tbody>
  			<c:forEach var="review" items="${list}">
  				<td align="left">${review.review}</td>
			  	<td align="left" class="text-danger">
				  	<c:if test="${review.score==1}">★☆☆☆☆</c:if>
				  	<c:if test="${review.score==2}">★★☆☆☆</c:if>
				  	<c:if test="${review.score==3}">★★★☆☆</c:if>
				  	<c:if test="${review.score==4}">★★★★☆</c:if>
				  	<c:if test="${review.score==5}">★★★★★</c:if>
			  	</td>
			  	<td align="left">${review.regDate}</td>
			  	<td align="left">${review.userId}</td>
  			</c:forEach>  		
  		</tbody>
  </table>
<br/>
 <nav>
  <ul class="pager">
  
    <li class="previous"><a href="#"><span aria-hidden="true">&larr;</span>이전</a></li>
    <li class="next"><a href="#">내 구매이력 보기</a></li>
    
  </ul>
</nav>
<br/>
</div>

<form>
<input type="hidden" id="currentPage" name="currentPage" value=""/>
</form>

<jsp:include page="../common/pageNavigator_new.jsp"/>

</body>
</html>