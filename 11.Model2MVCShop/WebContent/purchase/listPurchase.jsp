<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase" ).submit();  
	}
	function fncGetListTran(currentPage,tranWhere) {
		$("#currentPage").val(currentPage)
	   	$("#tranWhere").val(tranWhere)
		$("form").attr("method" , "POST").attr("action" , "/product/listPurchase" ).submit(); 
	}
	$(function() {
		 $( "td:contains('���ǵ���')" ).on("click" , function() {
								
				self.location ="/purchase/updateTranCode?tranNo="+$(this).children("#itranNo").text().trim()+"&tranCode=3";
		});
		 $( "td:contains('����ϱ�')" ).on("click" , function() {
				
				self.location ="/purchase/updateTranCodeByProdNo?tranNo="+$(this).children("#ktranNo").text().trim()+"&tranCode=2";
		});
		 $( "td:contains('�ı��ۼ�')" ).on("click" , function() {
				//Debug..
				//alert(  $( this ).text().trim() );
				if($( this ).children("#jtranNo").text().trim() != ''){
					self.location ="/product/reviewProductView?prodNo="+$(this).children("#iprodNo").text().trim()+
									"&tranNo="+$(this).children("#jtranNo").text().trim();
				}		
		});
		 
		 
		$("td:contains('�ı��ۼ��Ϸ�')").on("mouseenter" , function() {
			 
			var tranNo = $(this).children("#rtranNo").text().trim();
	
			 //alert(tranNo); 
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
					var displayValue = "������ : "+JSONData.review+
										"  ���� : "+JSONData.score+
										"  �ۼ� ��  : "+JSONData.regDate;						
					//alert(displayValue);
					//$("h3").remove();
					$( "#"+tranNo+"" ).attr("title",displayValue).tooltip();
					
				}
			});		 
	 }); 
		 
		 $( "td.ct_btn01:contains('�˻�')" ).on("click" , function() {
				
				fncGetList(1);
			 });
		 $( ".ct_list_pop td:nth-child(1)" ).on("click" , function() {
				//Debug..
				//alert(  $( this ).text().trim() );
				
				self.location ="/purchase/getPurchase?tranNo="+$(this).children("#tranNo").text().trim();
				
		 });
		 $( ".ct_list_pop td:nth-child(1)" ).css("color" , "red");
		 $( ".ct_list_pop td:nth-child(13)" ).css("color" , "blue");
		 $("h7").css("color" , "red");
		 
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
			<input type="hidden" id="menu" name="menu" value="${search.menu}"/>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
						${search.menu.equals("user")?"���� ��� ��ȸ":"��� ����"}
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<c:if test="${search.menu eq 'manage'}">
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
				
		<td width="1000" align="right">
			��� ��Ȳ >>>
			<select name="tranWhere" class="ct_input_g" style="width:200px" >
				<option value="0" ${! empty search.tranWhere&&search.tranWhere.equals('0') ? 'selected' : ''}>�����ϼ���.</option>
				<option value="1" ${! empty search.tranWhere&&search.tranWhere.equals('1') ? 'selected' : ''}>���� �Ϸ�</option>
				<option value="2" ${! empty search.tranWhere&&search.tranWhere.equals('2') ? 'selected' : ''}>��� ��</option>
				<option value="3" ${! empty search.tranWhere&&search.tranWhere.equals('3') ? 'selected' : ''}>��� �Ϸ�</option>
				<option value="4" ${! empty search.tranWhere&&search.tranWhere.equals('4') ? 'selected' : ''}>�ı��ۼ� �Ϸ�</option>
			</select>
			
			
		</td>
		<td align="left">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						�˻�
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</c:if>
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11" >��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No<br/> 
			(click)</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">�����ڸ�</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">���ż���</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">������</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��������<br/> 
			(click)</td>
		<td class="ct_line02"></td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:forEach var="p" items="${list}" varStatus="i">
	<tr class="ct_list_pop">
		<td align="center">
			<div id="tranNo" style="display:none">${p.tranNo}</div>
			${i.index+1}
		</td>
		<td></td>
		<td align="left">
			${p.purchaseProd.prodName}
		</td>
		<td></td>
		<td align="left">${p.receiverName}</td>
		<td></td>
		<td align="left">${p.amountPur}</td>
		<td></td>
		<td align="left">${p.orderDate}</td>
		<td></td>
		<td align="left">
		
		
		<c:if test="${! empty p.tranCode && (p.tranCode eq '2')}">
		����� �����Դϴ�.
		</c:if>
		<c:if test="${! empty p.tranCode && (p.tranCode eq '1')}">
		���� �Ϸ� �����Դϴ�.
		</c:if>
		<c:if test="${! empty p.tranCode && (p.tranCode eq '3')}">
		��� �Ϸ� �����Դϴ�.
		</c:if>	
		<c:if test="${! empty p.tranCode && (p.tranCode eq '4')}">
		�ı��ۼ��Ϸ�
		<div id="rtranNo" style="display:none">${p.tranNo}</div>
		<h7 id="${p.tranNo}">&nbsp;&nbsp;�ı� TOOLTIP</h7>
		</c:if>				
		</td>
		<td></td>
		
		<td align="left">
		
		<c:if test="${user.role eq 'user'}">
		
		<c:choose>		
		<c:when test="${! empty p.tranCode && p.tranCode eq '2'}">
			<div id="itranNo" style="display:none">${p.tranNo}</div>
			���ǵ���
		</c:when>
		<c:when test="${! empty p.tranCode && p.tranCode eq '3'}">
			<div id="jtranNo" style="display:none">${p.tranNo}</div>
			<div id="iprodNo" style="display:none">${p.purchaseProd.prodNo}</div>
			�ı��ۼ�
		</c:when>
		<c:otherwise>
			-------
		</c:otherwise>
		</c:choose>
		
		</c:if>
		
		<c:if test="${user.role eq 'admin'}">
		
			<c:choose>
			<c:when test="${! empty p.tranCode && p.tranCode eq '1'}">
				����ϱ�
				<div id="ktranNo" style="display:none">${p.tranNo}</div>
			</c:when>
			<c:otherwise>
			-------
			</c:otherwise>
			</c:choose>
			
		</c:if>
		</td>
		<td></td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>
	
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value="1"/>
					
			<jsp:include page="../common/pageNavigator.jsp"/>	
		
    	</td>
 	</tr>
</table>

<!--  ������ Navigator �� -->
</form>

</div>

</body>
</html>