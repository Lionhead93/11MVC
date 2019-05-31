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
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	
	
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
  
   function fncCartPurchase() {
		 
	   
		$("form").attr("method" , "POST").attr("action" , "/purchase/CartPurchase").submit();
			
	}
	
	$(function() {
		
		$("a[href='#']:contains('전체구매')").on("click", function(){
			
			if('${resultPage.totalCount }'=='0'){
				alert("장바구니가 없습니다.");
				return;
			}
			fncCartPurchase();
			
		});
		
		$(".previous").on("click", function(){
			
			history.go(-1);
			
		});
		
		$( "button:contains('주소찾기')" ).on("click" , function() {
			
			
			new daum.Postcode({
	            
				oncomplete: function(data) {
	               
					var addr = ''; // 주소 변수
	               
					//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
					
	                $("#divyAddr").val(addr);
	                      
	                
	            }
	        }).open();
			
		});
		
		$( "#divyDate" ).datepicker({
	    	changeMonth: true,
	        changeYear: true,
	        dateFormat: 'yy-mm-dd'			        
	    });
	});
  
  </script>
  
</head>
<body>
	
<jsp:include page="/layout/toolbar.jsp" />

<div class="container" >

  <div class="page-header text-center">
		
	<div>
	<h3><span class="text-info">
	내 장바구니
	<span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>
	</span></h3>
	</div>
  </div>
  <div class="text-left">
		    	<span class="text-primary">
		    		전체  ${resultPage.totalCount } 건수 <br/><br/>
		    	</span>
  </div>
  <form>
  <div class="row">
  <div class="col-lg-6">
  <table class="table table-hover table-striped" >
  
  		<thead>
          <tr>
          	<th align="left">구매번호</th>
            <th align="left">상품명</th>
            <th align="left">이미지</th>
            <th align="left" >상품 상세정보</th>
            <th align="left">구매수량</th>
            <th align="left">등록일</th>
          </tr>
        </thead>
  		<tbody>
  			<c:forEach var="purchase" items="${list}">
  				<input type="hidden" name=cartNo value="${purchase.tranNo}"/>
  				<tr>
  				<td align="left">${purchase.tranNo}</td>
  				<td align="left">${purchase.purchaseProd.prodName}</td>
			  	<td align="left">
				  	<img class="img-thumbnail" src="/images/uploadFiles/${purchase.purchaseProd.fileName}" alt="..." height="50" width="50"> 
			  	</td>
			  	<td align="left">${purchase.purchaseProd.prodDetail}</td>
			  	<td align="left">${purchase.amountPur}</td>
			  	<td align="left">${purchase.orderDate}</td>
			  	</tr>
  			</c:forEach>  		
  		</tbody>
  </table>
  </div>
  
  <div class="col-lg-6">
  		  <div class="form-group">
		    <label for="paymentOption">구매방법</label>
		    <div>
		      <select class="form-control" id="paymentOption" name="paymentOption" >
		      	<option value="1" selected="selected">현금구매</option>
				<option value="2">신용구매</option>
		      </select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="receiverName">구매자 이름</label>
		    <div>
		      <input type="text" class="form-control" id="receiverName" name="receiverName" value="${user.userName}">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="receiverPhone">구매자 연락처</label>
		    <div>
		       <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${user.phone}">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="divyAddr">배송지</label>
		    <div>
		       <input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${user.addr}">
		       <button type="button" class="btn btn-default"  >주소찾기</button>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="divyRequest">구매요청사항</label>
		    <div>
		       <input type="text" class="form-control" id="divyRequest" name="divyRequest" >
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="divyDate">배송 희망일자</label>
		    <div>
		       <input type="text" class="form-control" id="divyDate" name="divyDate" >
		    </div>
		  </div>
		  
  </div>
  
  </div>
  </form>
<br/>
 <nav>
  <ul class="pager">
  
    <li class="previous"><a href="#"><span aria-hidden="true">&larr;</span>이전</a></li>
    <li class="next"><a href="#">전체구매</a></li>
    
  </ul>
</nav>
<br/>
</div>



</body>
</html>