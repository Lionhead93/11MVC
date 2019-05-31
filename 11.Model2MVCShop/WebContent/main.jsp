<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--   jQuery , Bootstrap CDN  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
	<style>
        body {
            padding-top : 70px;
        }
   	</style>
   	 	
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">	 	
	
	$(function(){
		
				
		 
		$("button").on("click",function(){
		    	
			var search = $("#search").val().trim();
			
			$.ajax({
	                url: "https://dapi.kakao.com/v2/search/image?query="+search ,
	                type: "GET",
	                dataType : "json" ,
					headers : {
						"Authorization" : "KakaoAK 786f6826580a4d7936f476cd6356278a"
					},
	                success: function(data){
	                	
	                    window.open(data.documents[0].image_url,'window�˾�','width=300, height=300, menubar=no, status=no, toolbar=no');
	                    
	                },
	                error: function(){
	                    alert('error'); 
	                }
	            });
		    	
		});
		
	});
	
	</script>
	
</head>
	
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  �Ʒ��� ������ http://getbootstrap.com/getting-started/  ���� -->	
   	
   	<div class="container ">     
    <div>
   	<input type="text" id="search" name="search" placeholder="�����̵��� �˻�">
   	<button type="button" class="btn btn-primary"  >�˻�</button>
   	</div>
      	<div class="page-header">
  			<h1>Model2 MVC Shop <small>developed by Nam</small></h1>
		</div>
    </div> 

	<!-- ���� : http://getbootstrap.com/css/   : container part..... -->
	<jsp:include page="/layout/event.jsp" />

</body>

</html>