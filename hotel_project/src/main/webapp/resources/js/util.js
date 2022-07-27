/**
 * 
 */
 
function displayDate(timeValue){
	
	
	var dateObj = new Date(timeValue);
	
	var str = "";
	var yy = dateObj.getFullYear();

	var mm = dateObj.getMonth() + 1; // month는 0~11

	var dd = dateObj.getDate();
	
	return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
		(dd > 9 ? '' : '0') + dd ].join('');
}// yyyy/MM/dd로 날짜 바꿔줌


