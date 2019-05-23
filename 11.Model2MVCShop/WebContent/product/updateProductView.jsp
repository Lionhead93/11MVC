<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>



<!--  ///////////////////////// JSTL  ////////////////////////// -->



<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
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
		body {
            padding-top : 50px;
        }
    </style>
    
	<script type="text/javascript">
	
		
		function fncUpdateProduct(){
		//Form ��ȿ�� ����
	 	var name = $("input[name='prodName']").val();
		var detail = $("input[name='prodDetail']").val();
		var manuDate = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();
		var amount = $("input[name='amount']").val();
		
		if(name == null || name.length<1){
			alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if(detail == null || detail.length<1){
			alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if(manuDate == null || manuDate.length<1){
			alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(price == null || price.length<1){
			alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(amount == null || amount.length<1){
			alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
			
		$("form").attr("method" , "POST").attr("action" , "/product/updateProduct").attr("enctype" , "multipart/form-data").submit();
		}
	
		$(function(){
			
			    $( "#manuDate" ).datepicker({
			    	changeMonth: true,
			        changeYear: true,
			        dateFormat: 'yy-mm-dd'			        
			    });
			    
			    $("button").on("click",function(){
			    	
			    	fncUpdateProduct();
			    	
			    });
				
			    $("a[href='#']").on("click",function(){
			    	
			    	history.go(-1);
			    	
			    });
			    
		});
		
	</script>
	
</head>

<body>

<jsp:include page="/layout/toolbar.jsp" />

	<div class="container">
	
		<div class="page-header text-center">
	       <h3 class=" text-info">��ǰ��������</h3>
	       <h5 class="text-muted">��ǰ ������ <strong class="text-danger">�ֽ������� ����</strong>�� �ּ���.</h5>
	    </div>
	    
	    <!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		<div class="col-md-3">
			<img class="img-thumbnail" src="/images/uploadFiles/${product.fileName}" alt="..." height="300" width="300">
			
			    <div>��ǰ �̹��� ����</div>
			<div class="form-group">
			    <div >
			      <input type="file" multiple="multiple" class="form-control" id="file" name="file" value="" placeholder="file input...">
			    </div>
			</div>
		</div>
		
		<div class="col-md-6">
			  <div class="form-group">
			    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ ��</label>
			    <div class="col-sm-6">
			      <input type="text" class="form-control" id="prodName" name="prodName" value="${product.prodName}"  readonly>
			      <input type="hidden" name="prodNo" value="${product.prodNo}" />
			       <span id="helpBlock" class="help-block">
			      	<strong class="text-danger">��ǰ���� �����Ұ�</strong>
			      </span>
			    </div>
			  </div>
			
			  <div class="form-group">
			    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">������</label>
			    <div class="col-sm-6">
			      <input type="text" class="form-control" id="prodDetail" name="prodDetail" value="${product.prodDetail}" placeholder="���� ������">
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
			    <div class="col-sm-6">
			      <input type="text" class="form-control" id="manuDate" name="manuDate" value="${product.manuDate}" placeholder="���� ��������">
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
			    <div class="col-sm-6">
			      <input type="text" class="form-control" id="price" name="price"  value="${product.price}" placeholder="���� ����">
			    </div>
			  </div>
			  		  
			   <div class="form-group">
			    <label for="amount" class="col-sm-offset-1 col-sm-3 control-label">����</label>
			    <div class="col-sm-6">
			      <input type="text" class="form-control" id="amount" name="amount" value="${product.amount}" placeholder="���� ����">
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <div class="col-sm-offset-4  col-sm-4 text-center">
			      <button type="button" class="btn btn-primary"  >�� ��&nbsp;Ȯ��</button>
				  <a class="btn btn-primary btn" href="#" role="button">�� &nbsp;��</a>
			    </div>
			  </div>
			
		<!-- form Start /////////////////////////////////////-->
	 	</div><!--  col md -->
	   </form> 
 	</div>
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
 	
</body>

</html>