//**********************************************************************************************************************************************************
// JOIN LAYER POPUP
//*********************************************************************************************************************************************************** 
// VIEW POPUP 

	function layer_open(el){
		var temp = $('#' + el);
		var bg = temp.prev().hasClass('bg');	//dimmed 레이어를 감지하기 위한 boolean 변수
		if(bg){
			$('.layer').fadeIn();	//'bg' 클래스가 존재하면 레이어가 나타나고 배경은 dimmed 된다. 
		}else{
			temp.fadeIn();
		}

		// 화면의 중앙에 레이어를 띄운다.
		if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
		else temp.css('top', '0px');
		if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
		else temp.css('left', '0px');

		temp.find('button.btn-default').click(function(e){
			if(bg){
				$('.layer').fadeOut(); //'bg' 클래스가 존재하면 레이어를 사라지게 한다. 
			}else{
				temp.fadeOut();
			}
			e.preventDefault();
		});

		$('.layer .bg').click(function(e){	//배경을 클릭하면 레이어를 사라지게 하는 이벤트 핸들러
			$('.layer').fadeOut();
			e.preventDefault();
		});

	}			

// CHECK ID (ONLY ENGLISH AND NUMBER WHEN INPUT)

	$(document).ready(function(){
		//한글입력 안되게 처리
		$("input[name=userID]").keyup(function(event){ 
			if (!(event.keyCode >=37 && event.keyCode<=40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
			}
		});
	});

// CHECK ID (ID OVERLAP WHEN FOCUS OUT)
     
    var xhr = null;
    //url경로, 전달할 파라메터, 완료시콜백함수, get/post, 동기화여부
    function sendRequest(url, param, callback, method, asyncBool)
    {
        if(window.ActiveXObject)
            xhr = new ActiveXObject("Microsoft.XMLHTTP");
        else
            xhr = new XMLHttpRequest();

        method = (method.toLowerCase() == "get") ? "GET" : "POST";
         
        param = ( param == null || param == '' ) ? null : param;

        if(method == "GET" && param != null) url = url + "?" + param;
         
        xhr.open(method, url, asyncBool);

        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
         
        xhr.onreadystatechange = callback;

        xhr.send(  (method == "POST")? param : null   );
    }

	function getXMLHttpRequest() {
	    if (window.ActiveXObject) {
	        try {
	            return new ActiveXObject("Msxml2.XMLHTTP");
	        } catch(e) {
	            try {
	                return new ActiveXObject("Microsoft.XMLHTTP");
	            } catch(e1) { return null; }
	        }
	    } else if (window.XMLHttpRequest) {
	        return new XMLHttpRequest();
	    } else {
	        return null;﻿
	    }
	}
	//생성된 XMLHttpRequest 객체를 저장할 전역변수
	var httpRequest = null;
	
	function sendRequest(url, params, callback, method) {
	    httpRequest = getXMLHttpRequest();
	    var httpMethod = method ? method : 'GET';
	    if (httpMethod != 'GET' && httpMethod != 'POST') {
	        httpMethod = 'GET';
	    }
	    var httpParams = (params == null || params == '') ? null : params;
	    var httpUrl = url;
	    if (httpMethod == 'GET' && httpParams != null) {
	        httpUrl = httpUrl + "?" + httpParams;
	    }
	    httpRequest.open(httpMethod, httpUrl, true);
	    httpRequest.setRequestHeader(
	        'Content-Type', 'application/x-www-form-urlencoded');
	    httpRequest.onreadystatechange = callback;
	    httpRequest.send(httpMethod == 'POST' ? httpParams : null);
	}

	var checkFirst = false;
	var lastKeyword = '';
	var loopSendKeyword = false;
	
	function checkID() {
		if (checkFirst == false) {
			setTimeout("sendID();", 500);
			loopSendKeyword = true;
		}
		checkFirst == true;
	}
	
	function sendID() {
		if (loopSendKeyword == false) {
			return;
		}
		
		var keyword = document.getElementById('userID').value;
		
		if (keyword == '') {
			lastKeyword = '';
			document.getElementById('checkId').style.color = "#be471d";
			document.getElementById('checkId').innerHTML = "ID를 영문 혹은 숫자로 입력하세요.";
		}
		else if (keyword != lastKeyword) {
			lastKeyword = keyword;
			
			if (keyword != '') {
				var params = "id="+encodeURIComponent(keyword);
				sendRequest("ActionIdCheck.jsp", params, displayResult, 'POST');
			}
			else {				
			}
		}
		setTimeout("sendID();", 500);
	}
	
	function displayResult() {
		if (httpRequest.readyState == 4) {
			if (httpRequest.status == 200) {
				var resultText = httpRequest.responseText;
				var listView = document.getElementById('checkId');
				
				if(resultText == 0) {
					listView.innerHTML = "사용 가능한 ID 입니다.";
					listView.style.color = "#2a567e";
				}
				else {
					listView.innerHTML = "이미 등록된 ID 입니다.";
					listView.style.color = "#be471d";
				}
 			}
			else {
				alert("ERROR : " + httpRequest.status);
			}
		}
	}  
// CHECK PASSWORD
	function checkPwd() {		
		var f1 = document.forms[0];
		var pw1 = f1.memberPassword.value;
		var pw2 = f1.memberPasswordConfirm.value;
		
		if(pw1 != pw2) {
			document.getElementById('checkPwd').style.color = "#be471d";
			document.getElementById('checkPwd').innerHTML = "동일한 암호를 입력하세요.";
		}
		else {
			document.getElementById('checkPwd').style.color = "#2a567e";
			document.getElementById('checkPwd').innerHTML = "암호가 확인 되었습니다.";
		}
	}
//SUBMIT
	function joinSubmit() {		
		var joinSubmit = document.ActionJoin;

		if(document.getElementById('checkPwd').innerHTML == "암호가 확인 되었습니다."
				&& document.getElementById('checkId').innerHTML == "사용 가능한 ID 입니다.") {
			joinSubmit.submit();
		}
		else if(document.getElementById('checkPwd').innerHTML == "암호가 확인 되었습니다."
				&& document.getElementById('checkId').innerHTML != "사용 가능한 ID 입니다.") {
			alert("입력하신 ID는 이미 사용중입니다.\n다른 ID를 입력하세요.");
		}
		else if(document.getElementById('checkPwd').innerHTML != "암호가 확인 되었습니다."
				&& document.getElementById('checkId').innerHTML == "사용 가능한 ID 입니다.") {
			alert("입력하신 암호와 확인 암호가 일치하지 않습니다.\n암호를 확인해주세요.");
		}
		else {
			alert("입력하신 ID와 암호 정보가 올바르지 않습니다.");
		}
	}