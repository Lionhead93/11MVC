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
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase" ).submit();  
	}
	function fncGetListTran(currentPage,tranWhere) {
		$("#currentPage").val(currentPage)
	   	$("#tranWhere").val(tranWhere)
		$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase" ).submit(); 
	}
	 
	$(function(){
	
		$( "a[href='#' ]:contains('���� �Ϸ�')" ).on("click" , function() {
			
			fncGetListTran('1','1');
			
		});
		$( "a[href='#' ]:contains('��� ��')" ).on("click" , function() {
			
			fncGetListTran('1','2');
			
		});
		$( "a[href='#' ]:contains('��� �Ϸ�')" ).on("click" , function() {
			
			fncGetListTran('1','3');
			
		});
		$( "a[href='#' ]:contains('�ı��ۼ� �Ϸ�')" ).on("click" , function() {
			
			fncGetListTran('1','4');
			
		});
		$( "a[href='#' ]:contains('�������')" ).on("click" , function() {
			
			fncGetListTran('1','5');
			
		});
		$( "a[href='#' ]:contains('�˻� �ʱ�ȭ')" ).on("click" , function() {
			
			self.location = "/purchase/listPurchase?menu=${param.menu}";
			
		});
		$( "span[class='glyphicon glyphicon-transfer']" ).on("click" , function() {
			
			var tranNo = $(this).closest("td").attr("id").trim();
			var tranCode = "2";
						
			$.ajax(
					{
						url : "/purchase/json/updateTranCode/"+tranNo+"/"+tranCode ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData) {
							
								
								var display = "<div class='progress'><div class='progress-bar progress-bar-success' role='progressbar' aria-valuenow='60' aria-valuemin='0' aria-valuemax='100' style='width: 60%;'>��� ��</div></div>";
					  			  
								$("#"+JSONData.tranNo+"two").html(display);
								$("#"+JSONData.tranNo+"").html("<div class='text-info'><span class='glyphicon glyphicon-ok' aria-hidden='true'></span></div>");
								
							
						}							 
			});
			
		});
		
		$( "span[class='glyphicon glyphicon-gift']" ).on("click" , function() {
			
			var tranNo = $(this).closest("td").attr("id").trim();
			var tranCode = "3";
						
			$.ajax(
					{
						url : "/purchase/json/updateTranCode/"+tranNo+"/"+tranCode ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData) {
								
								var display = "<div class='progress'><div class='progress-bar progress-bar-info' role='progressbar' aria-valuenow='80' aria-valuemin='0' aria-valuemax='100' style='width: 80%;'>��� �Ϸ�</div></div>";
					  			  
								$("#"+JSONData.tranNo+"two").html(display);
								$("#"+JSONData.tranNo+"").html("<div class='text-info'><span class='glyphicon glyphicon-ok' aria-hidden='true'></span></div>");
								
							
						}							 
			});
			
		});
		
		$( "span[class='glyphicon glyphicon-pencil']" ).on("click" , function() {
			
			var tranNo = $(this).closest("td").attr("id").trim();
			var prodNo = $(this).attr("id").trim();
			
			self.location = "/product/reviewProductView?tranNo="+tranNo+"&prodNo="+prodNo;
			
		});
		
		$('#dialog').dialog({
		    autoOpen: false,
		    resizable: false,
		});
		
		$( "span[class='glyphicon glyphicon-eye-open']" ).on("click" , function() {
			
			var tranNo = $(this).closest("td").attr("id").trim();
			
			$.ajax({
				url : "/product/json/getReview/"+tranNo ,
				method : "GET" ,
				dataType : "json" ,
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData , status) {
					//alert("JSONData : \n"+JSONData);
					//alert("JSONData : \n"+JSON.stringify(JSONData));
					var displayValue = "<p>������ : "+JSONData.review+
										"<br/>  ���� : "+JSONData.score+
										"<br/>  �ۼ� ��  : "+JSONData.regDate+"</p>";	
					
					$('#dialog').html(displayValue)
					$('#dialog').dialog('open');
				}
			});
			
			
		});
		
		$("td[class='text-danger']").on("click", function(){
			
			var tranNo = $(this).text().trim();
			
			self.location = "/purchase/getPurchase?tranNo="+tranNo;
			
		});
		
	});

	</script>
</head>

<body>
	
	<jsp:include page="/layout/toolbar.jsp" />

<div class="container">
	<form name="detailForm">
		<input type="hidden" id="tranWhere" name="tranWhere" value="${! empty search.tranWhere ? search.tranWhere : '' }" >
		<input type="hidden" id="currentPage" name="currentPage" value="1">
		<input type="hidden" id="menu" name="menu" value="${search.menu}"/>
	</form>
	<div class="page-header text-info">
					
							<h3>${param.menu.equals("manage")?"��� ����":"���� �̷� ��ȸ"}</h3>
					
	</div>
	<c:if test="${search.menu eq 'manage'}">
	<div class="row">
		    <div class="col-md-6 text-left">
		    	<span class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�
		    	</span>
		    	<span class="btn-group">
					  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					   Sort <span class="caret"></span>
					  </button>
					  <ul class="dropdown-menu">
					    <li><a href="#">���� �Ϸ�</a></li>
					    <li><a href="#">��� ��</a></li>
					    <li><a href="#">��� �Ϸ�</a></li>
					    <li><a href="#">�ı��ۼ� �Ϸ�</a></li>
					    <li><a href="#">�������</a></li>
					    <li role="separator" class="divider"></li>
					    <li><a href="#">�˻� �ʱ�ȭ</a></li>
					  </ul>
				</span>
			</div>
	</div>
	</c:if>
	<table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">��� ��ȣ</th>
            <th align="left" >��ǰ��</th>
            <th align="left">������</th>
            <th align="left">���ż���</th>
            <th align="left">������</th>            
            <th align="left">�����Ȳ</th>
            <th align="left"><span class="glyphicon glyphicon-hourglass" aria-hidden="true"></span></th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:forEach var="purchase" items="${list}">
			<c:if test="${purchase.tranCode != '0'}">
			<tr>
			  <td align="left" title="Click : ������ Ȯ��" class="text-danger">
			  ${purchase.tranNo}</td>
			  <td align="left">${purchase.purchaseProd.prodName}</td>
			  <td align="left">${purchase.receiverName}</td>
			  <td align="left">${purchase.amountPur}</td>
			  <td align="left">${purchase.orderDate}</td>
			  <td id="${purchase.tranNo}two" align="left">
			  <c:if test="${purchase.tranCode=='1'}">
				  <div class="progress">
				  <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%;">
	   				 ���ſϷ�
	  			  </div>
				  </div>
			  </c:if>
			  <c:if test="${purchase.tranCode=='2'}">
				  <div class="progress">
				  <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
	   				 ��� ��
	  			  </div>
				  </div>
			  </c:if>
			  <c:if test="${purchase.tranCode=='3'}">
				  <div class="progress">
				  <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%;">
	   				 ��� �Ϸ�
	  			  </div>
				  </div>
			  </c:if>
			  <c:if test="${purchase.tranCode=='4'}">
				  <div class="progress">
				  <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">
	   				 �ı� �ۼ� �Ϸ�
	  			  </div>
				  </div>
			  </c:if>
			  <c:if test="${purchase.tranCode=='5'}">
				  <div class="progress">
				  <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">
	   				 �������
	  			  </div>
				  </div>
			  </c:if>	  
			  </td>
			  
			  <td id="${purchase.tranNo}" align="left">
			   <c:if test="${search.menu eq 'manage'}">
				   <c:if test="${purchase.tranCode=='1'}">
				     <span class="text-success" title="Click : ��� �ϱ�">
				     <span class="glyphicon glyphicon-transfer" aria-hidden="true"></span>
				     </span>
				   </c:if>
				   <c:if test="${purchase.tranCode=='4'}">
				     <span class="text-warning" title="Click : �ı� ����">
				     <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>
				     </span>
				   </c:if>
			   </c:if>
			   <c:if test="${search.menu eq 'user'}">
			   	   <c:if test="${purchase.tranCode=='2'}">
				     <span class="text-info" title="Click : ���� ����">
				     <span class="glyphicon glyphicon-gift" aria-hidden="true"></span>
				     </span>
				   </c:if>
				   <c:if test="${purchase.tranCode=='3'}">
				     <span class="text-success" title="Click : �ı� �ۼ��ϱ�">
				     <span id="${purchase.purchaseProd.prodNo}" class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
				     </span>
				   </c:if>
				   <c:if test="${purchase.tranCode=='4'}">
				     <span class="text-warning" title="Click : �ı� ����">
				     <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>
				     </span>
				   </c:if>
			   </c:if>
			  </td>
			</tr>
			</c:if>
          </c:forEach>
        <div id="dialog" title="��ǰ �ı�" >
  			
		</div>
        </tbody>
      
      </table>
</div><!-- end container -->
<jsp:include page="../common/pageNavigator_new.jsp"/>
</body>
</html>