/**
 * 
 */
 //detail 객체가 적용이 됐는지 확인하기 
 console.log("detail model...................");
 
 
 
 // detailService 객체 변수 선언함 - 처리해야할 함수를 가지고 있는 함수 작성 : 처리 해야할 함수를 리턴해 주는 함수
 var detailService= (function(){
 	
 	//--------------------실행할 함수 정의 ----------------------------------//
 	//댓글 리스트 가져오기 -list(서버에 넘겨주는 데이터 겍체,데이터를 가져오면 실행되는 함수, 오류가 나면 실행되는 함수)
 	function list(param,callback,error){
 	
 		
 		var hotelno = param.hotelno;
 		//jquery
 		$.getJSON("/hotel/list.do?hotelno="+hotelno, function(data){
 			if(callback){
 				callback(data); 
 			}
 		}).fail(function(xhr, status, err){
 			if(error) error();
 			else alert("테이터 가져오기를 실패 하셨습니다.");
 		
 		});
 	
 	};
 	
 	
 	function roomList(param,callback,error){
 		
 		
 		var hotelno = param.hotelno;
 		
 		$.getJSON("/hotel/imageList.do?hotelno="+hotelno, function(data){
 			if(callback){
 				callback(data);
 				
 			}
 			}).fail(function(xhr, status,err){
 				if(error) error();
 				else alert("테이터 가져오기 실패 하였습니다.")
 				
 			});
 		
 		
 		
 	};
 	
 	
 		function relyList(param,callback,error){
 		
 		
 		var hotelno = param.hotelno;
 		
 		$.getJSON("/hotel/rely.do?hotelno="+hotelno, function(data){
 			if(callback){
 				callback(data);
 				
 			}
 			}).fail(function(xhr, status,err){
 				if(error) error();
 				else alert("테이터 가져오기 실패 하였습니다.")
 				
 			});
 		
 		
 		
 	};
 	
 	

 	
 
 	
 	
 	
 	
 	
 	
 	
 	
 	return{
 	
 		list : list,
 		roomList : roomList,
 		
 		relyList : relyList
 	
 	
 	};//함수를 객체로 만들어서 리턴해준다.
 })();