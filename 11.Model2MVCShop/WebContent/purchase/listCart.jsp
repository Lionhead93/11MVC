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
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	
	
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
      .jumbotron {
      		background-color : smokegrey;
      }
    </style>
  <script type="text/javascript">
  
   function fncCartPurchase() {
		 
	   
		$("form").attr("method" , "POST").attr("action" , "/purchase/CartPurchase").submit();
			
	}
	
	$(function() {
		
		$("a[href='#']:contains('��ü����')").on("click", function(){
			
			if('${resultPage.totalCount }'=='0'){
				alert("��ٱ��ϰ� �����ϴ�.");
				return;
			}
			fncCartPurchase();
			
		});
		
		$(".previous").on("click", function(){
			
			history.go(-1);
			
		});
		
		$( "button:contains('�ּ�ã��')" ).on("click" , function() {
			
			
			new daum.Postcode({
	            
				oncomplete: function(data) {
	               
					var addr = ''; // �ּ� ����
	               
					//����ڰ� ������ �ּ� Ÿ�Կ� ���� �ش� �ּ� ���� �����´�.
	                if (data.userSelectedType === 'R') { // ����ڰ� ���θ� �ּҸ� �������� ���
	                    addr = data.roadAddress;
	                } else { // ����ڰ� ���� �ּҸ� �������� ���(J)
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
	�� ��ٱ���
	<span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>
	</span></h3>
	</div>
  </div>
  <div class="text-left">
		    	<span class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ� <br/><br/>
		    	</span>
  </div>
  <form>
  <div class="row">
  <div class="col-lg-6">
  <table class="table table-hover table-striped" >
  
  		<thead>
          <tr>
          	<th align="left">���Ź�ȣ</th>
            <th align="left">��ǰ��</th>
            <th align="left">�̹���</th>
            <th align="left" >��ǰ ������</th>
            <th align="left">���ż���</th>
            <th align="left">�����</th>
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
		    <label for="paymentOption">���Ź��</label>
		    <div>
		      <select class="form-control" id="paymentOption" name="paymentOption" >
		      	<option value="1" selected="selected">���ݱ���</option>
				<option value="2">�ſ뱸��</option>
		      </select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="receiverName">������ �̸�</label>
		    <div>
		      <input type="text" class="form-control" id="receiverName" name="receiverName" value="${user.userName}">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="receiverPhone">������ ����ó</label>
		    <div>
		       <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${user.phone}">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="divyAddr">�����</label>
		    <div>
		       <input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${user.addr}">
		       <button type="button" class="btn btn-default"  >�ּ�ã��</button>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="divyRequest">���ſ�û����</label>
		    <div>
		       <input type="text" class="form-control" id="divyRequest" name="divyRequest" >
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="divyDate">��� �������</label>
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
  
    <li class="previous"><a href="#"><span aria-hidden="true">&larr;</span>����</a></li>
    <li class="next"><a href="#">��ü����</a></li>
    
  </ul>
</nav>
<br/>
</div>



</body>
</html>