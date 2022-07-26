/**
 * 
 */
 
  var reservationService= (function(){
  
  
  
  	function add(reservation, callback, error){
 		console.log("add rely................");
 		
 		
 		
 		$.ajax({
 			type : 'post',
 			url : '/hotel/reservePayment',
 			data : JSON.stringify(reservation),
 			contentType : "application/json; charset=utf-8",
 			success : function(result, status,xhr){
 				if(callback){
 					callback(result);
 					
 				}
 			},
 			error : function(xhr,status,er){
 				if(error){
 					eorror(er);
 					
 				}
 			}
 			
 			
 		});
 		
 		
 		
 		
 	};
 	
 	
 	
  	return{
 		
 		add : add
 		
 	
 	};//함수를 객체로 만들어서 리턴해준다.
  	
  	
  
  
   })();