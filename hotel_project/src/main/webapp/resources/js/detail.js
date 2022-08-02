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
 	
 	function placeList(param, callback, error){
 		var hotelno = param.hotelno;
 		
 		$.getJSON("/hotel/place.do?hotelno="+hotelno, function(data){
 			if(callback){
 				callback(data);
 				
 			}
 			}).fail(function(xhr, status,err){
 				if(error) error();
 				else alert("테이터 가져오기 실패 하였습니다.")
 				
 			});
 	}
 	
 	
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
 	
 	
 	function add(reply, callback, error){
 		console.log("add rely................");
 		
 		
 		
 		$.ajax({
 			type : 'post',
 			url : '/hotel/new.do',
 			data : JSON.stringify(reply),
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
 	
 	
 	
 	
	function displayTime(timeValue) {

		var today = new Date();

		var gap = today.getTime() - timeValue;

		var dateObj = new Date(timeValue);
		var str = "";

		if (gap < (1000 * 60 * 60 * 24)) {

			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();

			return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,
					':', (ss > 9 ? '' : '0') + ss ].join('');

		} else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
			var dd = dateObj.getDate();

			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
					(dd > 9 ? '' : '0') + dd ].join('');
		}
	}
 	

 	
	function deleteReply(reviewNo, callback, error) {
		$.ajax({
			type : 'delete',
			url : '/hotel/' + reviewNo,
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
				
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	};
	
	
	
	
	
	function update(reply, callback, error){
		
		
		console.log("update-----------------------------------------------");
		
		
		$.ajax({
			type : 'put',
			url : '/hotel/' + reply.reviewNo,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
					
				}
				
				
				
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
					
					
				}
			}
			
			
			
			
		});
		
		
		
		
		
	};
	
	
	function getList(param, callback, error) {

	    var hotelno = param.hotelno;
	    var page = param.page || 1;
	    
	    $.getJSON("/hotel/pages/" + hotelno + "/" + page + ".json",
	        function(data) {
	    	
	          if (callback) {
	            //callback(data); // 댓글 목록만 가져오는 경우 
	            callback(data.replyCnt, data.list); //댓글 숫자와 목록을 가져오는 경우 
	          }
	        }).fail(function(xhr, status, err) {
	      if (error) {
	        error();
	      }
	    });
	  };
	
 	
 	
 	
 	return{
 		list : list,
 		
 		roomList : roomList,
 		
 		placeList : placeList,
 		
 		relyList : relyList,
 		
 		displayTime : displayTime,
 		
 		add : add,
 		
 		deleteReply : deleteReply,
 		
 		update : update,
 		
 		displayDate : displayDate,
 		
 		getList : getList
 	
 	
 	};//함수를 객체로 만들어서 리턴해준다.
 })();