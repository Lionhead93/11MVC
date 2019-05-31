<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	
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
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
     
<script type="text/javascript">

function fncAddPurchase() {
	var amountPur = $("input[name='amountPur']").val();
	var mileage = $("input[name='useMileage']").val();
	
	if(amountPur == null || amountPur.length<1 || amountPur>${product.amount} || amountPur < 1){
		alert("���ż����� �ٽ� Ȯ�����ּ���.");
		return;
	}
	if(mileage == null || mileage.length<1 || mileage>${user.mileage} || mileage<0){
		alert("���ϸ��� Ȯ�� �ٶ�");
		return;
	}
	
	
	$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchase").submit();
}

	


$(function() {
	
	$( "#divyDate" ).datepicker({
    	changeMonth: true,
        changeYear: true,
        dateFormat: 'yy-mm-dd'			        
    });
	
	$( "button:contains('����')" ).on("click" , function() {
		fncAddPurchase();
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
	
	$( "a[href='#']:contains('���')" ).on("click" , function() {
		$("form")[0].reset();
	});
	
});

</script>
</head>

<body>

	
	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
	<br/>
		<h1 class="bg-info text-center">${product.prodName} 
		<span class="glyphicon glyphicon-gift" aria-hidden="true"></span>
		<small>��ǰ ����</small></h1>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
							<input type="hidden" name="buyerId" value="${user.userId}" />
							<input type="hidden" name="prodNo" value="${product.prodNo}" />
							<input type="hidden" name="price" value="${product.price}" />
		<br/>
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ ��</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" value="${product.prodName}" placeholder="��ǰ ��" readonly>
		    </div>
		  </div>
		<br/>  
		  <div class="form-group">
		    <label for="amountPur" class="col-sm-offset-1 col-sm-3 control-label">���� ����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="amountPur" name="amountPur" placeholder="${product.amount}�� ���Ű���..">
		    </div>
		  </div>
		<br/> 
		<c:if test="${!empty kakaoProd&&kakaoProd==product.prodNo}"> 
		<div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">���Ź��</label>
		    <div class="col-sm-4">
		        <input type="hidden" name="paymentOption" value="0">
		        <input type="hidden" name="useMileage" value="0">
		        <span class="text-danger">īī�����̷� �����Ϸ�</span>
		    </div>
		  </div>
		</c:if>
		<c:if test="${empty kakaoProd || kakaoProd != product.prodNo}"> 
		  <div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">���Ź��</label>
		    <div class="col-sm-4">
		      <select class="form-control" id="paymentOption" name="paymentOption" >
		      	<option value="1" selected="selected">���ݱ���</option>
				<option value="2">�ſ뱸��</option>
		      </select>
		    </div>
		  </div>
		<br/>  
		  <div class="form-group">
		    <label for="useMileage" class="col-sm-offset-1 col-sm-3 control-label">���ϸ��� ���</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="useMileage" name="useMileage" value="0" placeholder="�Է����ּ���.">
		      <span class="text-danger">${user.mileage}��&nbsp;��� ����</span>
		    </div>
		  </div>
		<br/>
		  </c:if>  
		  <div class="form-group">
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">������ �̸�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverName" name="receiverName" value="${user.userName}">
		    </div>
		  </div>
		<br/> 
		  <div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">������ ����ó</label>
		    <div class="col-sm-4">
		       <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${user.phone}">
		    </div>
		  </div>
		<br/> 
		  <div class="form-group">
		    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">�����</label>
		    <div class="col-sm-4">
		       <input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${user.addr}">
		       <button type="button" class="btn btn-default"  >�ּ�ã��</button>
		    </div>
		  </div>
		<br/>
			<div class="form-group">
		    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
		    <div class="col-sm-4">
		       <input type="text" class="form-control" id="divyRequest" name="divyRequest" >
		    </div>
		  </div>
		<br/>  
		<div class="form-group">
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">��� �������</label>
		    <div class="col-sm-4">
		       <input type="text" class="form-control" id="divyDate" name="divyDate" >
		    </div>
		  </div>
		<br/>    
		  
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >����</button>
			  <a class="btn btn-primary btn" href="#" role="button">���</a>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  ȭ�鱸�� div end /////////////////////////////////////-->
	
</body>

</html>