<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/> 

<%@include file="../includes/header.jsp"%>

<div class="container mt-5">
	<div class="row">
		<h1>예약자정보</h1>
	<div class="col-sm-6">
		<div class="mt-3"><strong class="user_profile">예약자 이름 : </strong>
			<br>
			 <input type="text" class=" form-control-lg mt-3" style="padding:10px; background-color:#dddddd" value="user1" readonly>
		
		</div>
		
		  <div class="mt-5">
	        <strong class="user_profile">휴대폰 번호</strong> <br>
	        <input type="text" class=" form-control-lg mt-3" style="padding:10px; background-color:#dddddd" value="number" readonly>
	      </div>
	      
	      
	      
	        <div class="mt-5" onclick="chkReserve()">
	        <div class="form-check">
	          <input type="checkbox" class="form-check-input" id="check1" name="option1" value="something" required>
	          <label class="form-check-label" for="check1">숙소이용규칙 및 취소/환불규정 동의</label>
	        </div>
	        <div class="form-check">
	          <input type="checkbox" class="form-check-input" id="check2" name="option2" value="something" required>
	          <label class="form-check-label" for="check2">개인정보 수집 및 이용 동의</label>
	        </div>
	        <div class="form-check">
	          <input type="checkbox" class="form-check-input" id="check3" name="option2" value="something" required>
	          <label class="form-check-label" for="check2">개인정보 제 3자 제공 동의</label>
	        </div>
	        
	      </div>
	
	
	
	</div>		
	
	
	
	
	<div class="col-sm-6" style="background-color:#dddddd; height:700px; width:500px; padding:20px">
		<div class="row">
			<div class="col-12 mt-3">
				<h4 class="reserve_info">
	       			 <strong class="reserve_name">숙소이름:</strong> <br>
	     		  		호텔이름
	     	    </h4>
			</div>
			
			<div class="col-12 mt-3">
				 <h4 class="reserve_info">
	       			 <strong class="reserve_name">객실타입</strong> <br>
	       			Single Room
	     		 </h4>
			
			</div>
		
			
			<div class="col-12 mt-3">
				  <h4 class="reserve_info">
	       			 <strong class="reserve_name">체크인</strong> <br>
	      			  2022-32323
	      	    	</h4>
			
			</div>
			
			
			<div class="col-12 mt-3">
				  <h4 class="reserve_info">
	     			   <strong class="reserve_name">체크아웃</strong> <br>
	       				 2022-07-16
	     		  </h4>
			
			</div>
			
			
		
	   			 
	   			
			
			
		
		</div>
		
		
		
		
			    <div class="row" style="margin-top:170px;">
			    			<hr>
			    		<div class="col-12">
			    		
			    			<strong class="reserve_name" style="color: black;">총 결제 금액:</strong> 
			    		</div>
			    		
			    		<div class="col-12">
			    		
			    		<strong class="reserve_name" style="color: #ffc107; font-size: 30px;"><fmt:formatNumber value="500000" pattern="#,###" /></strong><strong class="reserve_name" style="color: black; font-size: 30px;"> 원</strong>
			    		
			    		</div>
			    	
			    		
			    	
			    		<div class="col-12">
			    			 <button class="btn" type="button" onclick="requestPay()" id="btn" disabled
	    				style="width: 100%; height: 56px; background: #ffc107; color: white; border: none;">결제하기</button>
			    		</div>
			    	
		
			    		
			    	
			    
			    
			    
	      				
	     				
	     				
	   			 </div>
	
	
	
	</div>
	
	
	</div>
</div>
<%@include file="../includes/footer.jsp"%>