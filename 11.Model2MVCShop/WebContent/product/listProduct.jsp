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
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${param.menu}").submit();  
	}
	function fncGetListSort(currentPage,sortPrice) {
		$("#currentPage").val(currentPage)
	   	$("#sortPrice").val(sortPrice)
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${param.menu}").submit();  	
	}

	$(function(){	
		
		$('#searchKeyword').on("keydown" , function(event){
			
			if(event.keyCode == '13'){
				fncGetList(1);
			}
			
		});
		
		var array = [];	
		
		$.ajax(
				{
					url : "/product/json/Autocomplete" ,
					method : "GET" ,
					dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success : function(JSONData) {
						
					/*	$.each(JSONData,function(index, value){
							
							array[index] = value ;
							
						}) */
						array = JSONData;
						
						$('#searchKeyword').autocomplete({
							source : array
						});
						
					}							 
		});
		
		var prodNo = "";
		
		var event = false;
		var page = 3;
		var dispalyValue = "";
		
		$(window).on("scroll" , function(){
						
						
			if($(window).scrollTop() == $(document).height() - $(window).height()){
				if(event == true){
					return;
				}else{
					event = true;
					console.log(++page);
					$.ajax(
							{
								url : "/product/json/listProduct" ,
								method : "POST" ,
								data : JSON.stringify({
									searchCondition : $("#searchCondition").val(),
									searchKeyword : $("#searchKeyword").val(),
									currentPage : page,
									menu : $("#menu").val(),
									sortPrice : $("#sortPrice").val(),
									tranWhere : $("#tranWhere").val()
								}) ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function(JSONData) {
									
									if(JSONData.message=="ok"){
										
										$.each(JSONData.list, function( index, product){
											displayValue = "<div class='col-lg-4'>"	
															+"<span class='glyphicon glyphicon-eye-open' aria-hidden='true'>"
															+"<div id='iprodNo' style='display:none'>"+product.prodNo+"</div>"
															+"</span>"
															+"<div id='"+product.prodNo+"' >"
															+"<img class='img-circle' src='/images/uploadFiles/"+product.fileName+"' onerror='this.src="+"'/images/noimagesup.png'"+"' width='140' height='140'>"
															+"<h2>"+product.prodName+"</h2>"
															+"<p>"+product.prodDetail+"</p>"
															+"<p>"+product.price+" 원</p>"
															+"<p><a class='btn btn-default' href='#' role='button'>Show Detail &raquo;</a></p></div></div>";
											
											$("#prodRow").append(displayValue);
											$("a[href='#' ]:contains('Show Detail')").off("click");
											$("a[href='#' ]:contains('Show Detail')").on("click" , function(){
												
												prodNo = $(this).closest("div").attr("id").trim();
												if(${!empty user}){
													self.location = "/product/getProduct?menu=search&prodNo="+prodNo;
												}else{
													alert("로그인을 해주세요");
												}
											});
											if(product.amount==0){
												$("#"+product.prodNo+"").append("<p class='text-danger'>"
										          +"<span class='glyphicon glyphicon-remove' aria-hidden='true'></span>품절"
										          +"<span class='glyphicon glyphicon-remove' aria-hidden='true'></span></p>")
										          
											}else{
												$("#"+product.prodNo+"").append("<p class='text-success'>"
												          +"<span class='glyphicon glyphicon-shopping-cart' aria-hidden='true'></span>구매가능</p>")
											}
										})
										$("span[class='glyphicon glyphicon-eye-open']").off("click");
										$("span[class='glyphicon glyphicon-eye-open']").on("click" , function(){
			
											prodNo = $(this).children("#iprodNo").text().trim();
											
											$.ajax(
													{
														url : "/product/json/getProduct/"+prodNo ,
														method : "GET" ,
														dataType : "json" ,
														headers : {
															"Accept" : "application/json",
															"Content-Type" : "application/json"
														},
														success : function(JSONData) {
															
															var displayValue = 
																
																"<h5><br/><br/><br/><br/>"
																+"상품 명 : "+JSONData.prodName+"<br/><br/>"
																+"상세 정보 : "+JSONData.prodDetail+"<br/><br/>"
																+"제조 일자 : "+JSONData.manuDate+"<br/><br/>"
																+"제고 : "+JSONData.amount+"개<br/><br/>"
																+"등록일 : "+JSONData.regDate
																+"</h5><br/><br/>"
																+"<p><a class='btn btn-default' href='#' role='button'>Show Detail &raquo;</a></p><br/><br/>";
															
															value = $("#"+prodNo+"").html();
																	
															$("#"+prodNo+"").html(displayValue);
															$("a[href='#' ]:contains('Show Detail')").off("click");
															$("a[href='#' ]:contains('Show Detail')").on("click" , function(){
																
																prodNo = $(this).closest("div").attr("id").trim();
																if(${!empty user}){
																	self.location = "/product/getProduct?menu=search&prodNo="+prodNo;
																}else{
																	alert("로그인을 해주세요");
																}
															});															
															
														}							 
												});
											
										});
										
										event = false;
									
									}else{
										
										$("div[class='container marketing']").append("<div class='text-center'><button type='button' class='btn btn-danger'>맨 위로&uArr;"
															+"</button></div>");
										$("button:contains('맨 위로')").on("click" , function(){
											$('html').scrollTop(0);
										});
										$("a[href='#' ]:contains('Show Detail')").off("click");
										$("a[href='#' ]:contains('Show Detail')").on("click" , function(){
											
											prodNo = $(this).closest("div").attr("id").trim();
											if(${!empty user}){
												self.location = "/product/getProduct?menu=search&prodNo="+prodNo;
											}else{
												alert("로그인을 해주세요");
											}
										});
										$(window).off("scroll");
										
										event = false;
									}
								}							 
					});	
				}
			}
			
		});	
		
		$('#searchCondition').on("change" , function(){
			
			if($('#searchCondition').val()=='1'){
				$('#searchKeyword').autocomplete({
					source : array
				});
			}else{
				$('#searchKeyword').autocomplete({
					source : []
				});
			}
			
		});
		
		$("a[href='#' ]:contains('Show Detail')").on("click" , function(){
			
			prodNo = $(this).closest("div").attr("id").trim();
			
			if(${!empty user}){
				self.location = "/product/getProduct?menu=search&prodNo="+prodNo;
			}else{
				alert("로그인을 해주세요");
			}
			
		});
		
		$("span[class='glyphicon glyphicon-eye-open']").on("click" , function(){
			
			prodNo = $(this).children("#iprodNo").text().trim();
			
			$.ajax(
					{
						url : "/product/json/getProduct/"+prodNo ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData) {
							
							var displayValue = 
								
								"<h5><br/><br/><br/><br/>"
								+"상품 명 : "+JSONData.prodName+"<br/><br/>"
								+"상세 정보 : "+JSONData.prodDetail+"<br/><br/>"
								+"제조 일자 : "+JSONData.manuDate+"<br/><br/>"
								+"제고 : "+JSONData.amount+"개<br/><br/>"
								+"등록일 : "+JSONData.regDate
								+"</h5><br/><br/>"
								+"<p><a class='btn btn-default' href='#' role='button'>Show Detail &raquo;</a></p><br/><br/>";
							
							
							$("#"+prodNo+"").html(displayValue);
							
							$("a[href='#' ]:contains('Show Detail')").off("click");
							$("a[href='#' ]:contains('Show Detail')").on("click" , function(){
								
								prodNo = $(this).closest("div").attr("id").trim();
								
								if(${!empty user}){
									self.location = "/product/getProduct?menu=search&prodNo="+prodNo;
								}else{
									alert("로그인을 해주세요");
								}
							});
							
						}							 
			});			
			
		});
		 $( "button:contains('검색')" ).on("click" , function() {
				
			fncGetList(1);
		 });
		 $( "a[href='#' ]:contains('검색초기화')" ).on("click" , function() {
				
			 self.location = "/product/listProduct?menu=${param.menu}";
		 });
		 $( "a[href='#' ]:contains('낮은가격순')" ).on("click" , function() {
			 fncGetListSort('1','asc');
		 });
		 $( "a[href='#' ]:contains('높은가격순')" ).on("click" , function() {
				
			 fncGetListSort('1','desc');
		 });
		 
		 $( "a[href='#' ]:contains('품절상품 제외')" ).on("click" , function() {
			 $("#tranWhere").val('0')	
			 fncGetList('1');
		 });
		
	
	});
</script>
</head>

<body>

<jsp:include page="/layout/toolbar.jsp" />

	<div class="container">

			
			<div class="page-header text-info">
					
							<h3>${param.menu.equals("manage")?"상품 관리":"상품 목록 조회"}</h3>
					
			</div>		
			          
			<div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<span class="text-primary">
		    		전체  ${resultPage.totalCount } 건수
		    	</span>
		    	<span class="btn-group">
					  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					   Sort <span class="caret"></span>
					  </button>
					  <ul class="dropdown-menu">
					    <li><a href="#">낮은가격순</a></li>
					    <li><a href="#">높은가격순</a></li>
					    <li><a href="#">품절상품 제외</a></li>
					     <li role="separator" class="divider"></li>
					    <li><a href="#">검색초기화</a></li>
					  </ul>
				</span>
		    </div>		    
		    		   
		    	
		    
		    <div class="col-md-6 text-right">
		    			    
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <c:if test="${param.menu eq 'manage'}">
				    <select class="form-control" id="searchCondition" name="searchCondition" >
						<option value="1" ${! empty search.searchCondition&&search.searchCondition.equals('1') ? 'selected' : ''}>상품명</option>
						<option value="0" ${! empty search.searchCondition&&search.searchCondition.equals('0') ? 'selected' : ''}>상품번호</option>
						<option value="2" ${! empty search.searchCondition&&search.searchCondition.equals('2') ? 'selected' : ''}>가격 </option>
					</select>
					</c:if>
					<c:if test="${!(param.menu eq 'manage')}">
					<select class="form-control" id="searchCondition" name="searchCondition">
						<option value="1" ${! empty search.searchCondition&&search.searchCondition.equals('1') ? 'selected' : ''}>상품명</option>
						<option value="2" ${! empty search.searchCondition&&search.searchCondition.equals('2') ? 'selected' : ''}>가격 </option>
					</select>					
					</c:if>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  <input type="hidden" id="menu" name="menu" value="${param.menu}"/>
				  <input type="hidden" id="sortPrice" name="sortPrice" value="${! empty search.sortPrice?search.sortPrice:''}"/>
				  <input type="hidden" id="tranWhere" name="tranWhere" value="${! empty search.tranWhere?search.tranWhere:'1'}"/>
				</form>
	    	</div>
	    	
		</div>
</div>
<br/><hr/>
 <div class="container marketing">

      <!-- Three columns of text below the carousel -->
      <div class="row" id="prodRow">
       <c:forEach var="product" items="${list}" varStatus="j" > 
        <div class="col-lg-4">
          <span class="glyphicon glyphicon-eye-open" aria-hidden="true">
          	<div id="iprodNo" style="display:none">${product.prodNo}</div>
          </span>
          <div id="${product.prodNo}">
	          <img class="img-circle" src="/images/uploadFiles/${product.fileName}" onerror="this.src='/images/noimagesup.png'" width="140" height="140">
	          <h2>${product.prodName}</h2>         
	          <p>${product.prodDetail}</p>
	          <p>${product.price} 원</p>	 
	          <p><a class="btn btn-default" href="#" role="button">Show Detail &raquo;</a></p>
	          
		          <c:if test="${product.amount=='0'}">
		          <p class="text-danger">
		          <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
		          	품절
		          <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
		          </p>
		          </c:if>
		          <c:if test="${product.amount!='0'}">
		          <p class="text-success">
		          <span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>	
		          	구매가능	
		          </p>
		          </c:if>
	                   
	          
	          
			    	
	      </div>
        </div><!-- /.col-lg-4 -->
        </c:forEach>
      </div><!-- /.row -->
	
 </div><!-- /.container -->





</body>
</html>
	
