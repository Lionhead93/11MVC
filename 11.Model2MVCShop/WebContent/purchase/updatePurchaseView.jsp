<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


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
		
					
	$(function() {
				 
		$( "button:contains('����')" ).on("click" , function() {
					$("form").attr("method" , "POST").attr("action" , "/purchase/updatePurchase?tranNo=${purchase.tranNo}").submit();
		});				 
				 
		$( "a[href='#']:contains('���')" ).on("click" , function() {
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
	
	<div class="container">
	<br/>
		<h1 class="bg-info text-center"> 
		<span class="glyphicon glyphicon-scissors" aria-hidden="true"></span>������������</h1>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
					<input type="hidden" name="buyerId" value="${purchase.buyer.userId}">
		<br/>
		  <div class="form-group">
		    <label for="buyer" class="col-sm-offset-1 col-sm-3 control-label">�����ھ��̵�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="buyer" value="${purchase.buyer.userId}" readonly>
		    </div>
		  </div>
		<br/>  
		  <div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">������ ����ó</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${purchase.receiverPhone}">
		    </div>
		  </div>
		<br/>
		<div class="form-group">
		    <label for="amountPur" class="col-sm-offset-1 col-sm-3 control-label">���� ����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="amountPur" name="amountPur" value="${purchase.amountPur}">
		    </div>
		  </div>
		<br/>  
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
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">������ �̸�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverName" name="receiverName" value="${purchase.receiverName}">
		    </div>
		  </div>
		
		<br/> 
		  <div class="form-group">
		    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">�����</label>
		    <div class="col-sm-4">
		       <input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${purchase.divyAddr}">
		       <button type="button" class="btn btn-default"  >�ּ�ã��</button>
		    </div>
		  </div>
		<br/>
			<div class="form-group">
		    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
		    <div class="col-sm-4">
		       <input type="text" class="form-control" id="divyRequest" name="divyRequest" value="${purchase.divyRequest}" >
		    </div>
		  </div>
		<br/>  
		<div class="form-group">
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">��� �������</label>
		    <div class="col-sm-4">
		       <input type="text" class="form-control" id="divyDate" name="divyDate" value="${purchase.divyDate}">
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