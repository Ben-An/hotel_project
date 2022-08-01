/**
 * 
 */

//main 객체가 적응이 됐는지 확인하기
console.log("main modle...................")



var mainService = (function(){

	function replyList(callback,error) {
		
		$.getJSON("/hotel/replyList", function(data){
			if(callback){
				callback(data);
				
			}
		}).fail(function(xhr, status, err){
			if(error) error();
			else alert("데이터 가져오기 실패");
		});
		
		
		
		
		
	};
	
	
	return{
		replyList : replyList,
		displayDate : displayDate
	};
	
	
})();





