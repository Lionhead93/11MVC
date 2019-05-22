<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container">        
	     
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
	      <!-- Indicators -->
	      <ol class="carousel-indicators">
	        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
	        <li data-target="#myCarousel" data-slide-to="1"></li>
	        <li data-target="#myCarousel" data-slide-to="2"></li>
	      </ol>
	      <div class="carousel-inner" role="listbox">
	        <div class="item active">
	          <img class="first-slide" src="/images/adduserevent.png" alt="First slide">
	          <div class="container">
	            <div class="carousel-caption">
	              <h1>
				        <span class="label label-primary">       
				              Sign up Event
				        </span>      
	              </h1>
	              <h3>회원가입 시 마일리지 5000점 적립</h3>
	              <br/>
	              <p>
	              <a id="add" class="btn btn-lg btn-primary" href="#" role="button">
	              <span class="glyphicon glyphicon-hand-up" aria-hidden="true"></span> Sign Up
	              </a>
	              </p>
	            </div>
	          </div>
	        </div>
	        <div class="item">
	          <img class="second-slide" src="/images/purchase.jpg" alt="Second slide" >
	          <div class="container">
	            <div class="carousel-caption">	            	            
	              <h1>
	              <span class="label label-primary">Purchase Event</span>
	              </h1>
	              <h3>
	              		구매시 마일리지 3% 적립
	              </h3>
	              <br/>	
	              <p>
	              <a id="purchase" class="btn btn-lg btn-primary" href="#" role="button">
	              <span class="glyphicon glyphicon-hand-up" aria-hidden="true"></span> Get Product
	              </a>
	              </p>
	            </div>
	          </div>
	        </div>
	        <div class="item">
	          <img class="third-slide" src="/images/review.jpg" alt="Third slide">
	          <div class="container">
	            <div class="carousel-caption">
	              <h1>
	        <span class="label label-primary">       
	             Review Event
	              </span>
	              </h1>
	              <h3>리뷰 작성시 추첨을 통해 상품증정</h3>
	               <br/>
	              <p>
	              <a id="review" class="btn btn-lg btn-primary" href="#" role="button">
	              <span class="glyphicon glyphicon-hand-up" aria-hidden="true"></span> Go Review
	              </a>	
	              </p>
	            </div>
	          </div>
	        </div>
	      </div>
	      <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
	        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
	        <span class="sr-only">Previous</span>
	      </a>
	      <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
	        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
	        <span class="sr-only">Next</span>
	      </a>
	    </div>
 </div>
 
 <script type="text/javascript">
	
	$(function(){	
		
		$( "#add" ).on("click" , function() {
			if(${empty user}){
				$(this).attr("href","/user/addUser");
			}else{
				alert("로그인 상태입니다.")
			}
		 });
		$("#purchase").on("click" , function() {
			
				$(this).attr("href","/product/listProduct?menu=search");
				
		 });
		$("#review").on("click" , function() {
			if(${empty user}){
				alert("로그인을 해주세요.")
			}else{
				$(this).attr("href","/purchase/listPurchase?menu=user");
			}
		 });
		
		$("h3").css("color","black");
		$("h2").css("color","blue");
	});
	</script>