$(document).ready(function(){
		//한글입력 안되게 처리
		$("input[name=userID]").keyup(function(event){ 
			if (!(event.keyCode >=37 && event.keyCode<=40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
			}
		});
	});