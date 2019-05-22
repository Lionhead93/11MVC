<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>구매 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	function fncGetList(currentPage) {
		
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/product/listReviewByUser").submit();
			
	}
	
	$(function() {
		
		$( "td.ct_btn01:contains('이전')" ).on("click" , function() {
			history.go(-1);
		});	
		$( ".ct_list_pop td:nth-child(1)" ).on("click" , function() {
			var prodNo = $(this).text().trim();
			self.location ="/product/getProduct?prodNo="+prodNo+"&menu=search";
		});
		$( ".ct_list_pop td:nth-child(1)" ).css("color" , "red");
		
	});

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">후기 작성 내역</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11" >전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="50">상품번호 <br/>(click)</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">한줄평</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">별점</td>
		<td class="ct_line02"></td>	
		<td class="ct_list_b" width="150">작성일</td>
		<td class="ct_line02"></td>		
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:forEach var="p" items="${list}" varStatus="i">
	<tr class="ct_list_pop">
		<td align="center">
			${p.reviewProdNo}
		</td>
		<td></td>
		<td align="center">
			${p.review}
		</td>
		<td></td>
		<td align="center">${p.score}</td>
		<td></td>
		<td align="center">${p.regDate}</td>
		<td></td>			
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>
	
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				
				<td width="30"></td>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01"	 style="padding-top: 3px;">
					이전
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
		   
			<jsp:include page="../common/pageNavigator.jsp"/>	
			
    	</td>
	</tr>
</table>

<!--  페이지 Navigator 끝 -->
</form>

</div>

</body>
</html>