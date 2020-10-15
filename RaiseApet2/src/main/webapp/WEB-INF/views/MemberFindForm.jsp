<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기</title>
</head>
<style>
	table{
		border-collapse: collapse;
	}
</style>
<script type="text/javaScript" src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.js"></script>
<!-- 아이디/비밀번호 찾기 - 아이디 or 비밀번호 선택 start -->
<script>
	// 비밀번호 찾기
	function pwFind(){
		var output = "<div>";
		output += "<form action='userPwFind' method='POST'>";
		output += "<input type='text' id='userId' name='userId' placeholder='아이디' required='required' maxlength='15'><br>";
		output += "<input type='text' id='userName' name='userName' placeholder='이름' required='required' maxlength='5'><br>";
		output += "<div id='confirmDiv'>"
		output += "<input type='email' id='userEmail' name='userEmail' placeholder='이메일' required='required' maxlength='50'>";
		output += "<button onclick='pwFindOverlap()'>인증번호 발송</button><br>";
		output += "</div>";
		output += "<input type='text' id='keyConfirm' name='keyConfirm' onchange='keyConfirm()' placeholder='인증번호' required='required' maxlength='50'>";
		output += "<span id='keyConfirmSpan'></span><br>";
		output += "<button onclick='pwProcess()'>비밀번호 찾기</button>";
		output += "</form>";
		output += "</div>";
		$("#idOrPwFindDiv").html(output);
	}

	// 아이디 찾기
	function idFind(){
		var output = "<div>";
		output += "<input type='text' id='userName' name='userName' placeholder='이름' required='required' maxlength='3'><br>";
		output += "<input type='email' id='userEmail' name='userEmail' placeholder='이메일' required='required' maxlength='50'><br>";
		output += "<button onclick='idFindOverlap()'>아이디 찾기</button><br>";
		output += "<span id='idFindResult'></span>";
		output += "</div>";
		$("#idOrPwFindDiv").html(output);
	}
</script>
<!-- 아이디/비밀번호 찾기 - 아이디 or 비밀번호 선택 end -->

<!-- 아이디/비밀번호 찾기  ajax start -->
<script>
	function idFindOverlap(){

		var userName = document.getElementById("userName").value;
		console.log("userName : " + userName);
		var userEmail = document.getElementById("userEmail").value;
		console.log("userEmail : " + userEmail);
		var idFindResult = document.getElementById("idFindResult");

		$.ajax({
			type : "POST", // POST 방식으로
			url : "idfindoverlap",
			data : {"userName" : userName, "userEmail" : userEmail},

			// 성공 시
			success : function(data){
				if(data=="OK"){
					idFindResult.innerHTML = "회원님의 아이디는 " + "${userIdFindResult}" + "입니다.";
				} else{
					idFindResult.innerHTML = "등록 되어 있지 않은 회원입니다.";
					document.getElementById('userName').value = '';
					document.getElementById('userEmail').value = '';
					}
				}, 

			// 실패 시
			error : function(){
				alert("idFindOverlap 함수 통신 실패");
				}
			}); // end Ajax
		} // end idFindOverlap

	function pwFindOverlap(){

		var userEmail = document.getElementById("userEmail").value;
		console.log("userEmail : " + userEmail);
		var userName = document.getElementById("userName").value;
		console.log("userName : " + userName);
		var userId = document.getElementById("userId").value;
		console.log("userId : " + userId);

		$.ajax({
			type : "POST", // POST 방식으로
			url : "pwfindoverlap",
			data : {"userName" : userName, "userEmail" : userEmail, "userId" : userId},

			// 성공 시
			success : function(data){
				if(data=="OK"){
					// OK가 왔다는 건 회원이 있다는 거니까 메일을 발송 해야 함.
					alert("인증번호가 발송 되었습니다. 메일 확인 후 인증번호를 작성 해주세요");                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
					location.href="pwFindEmail()";
					// redirect:/ 쓰는 거 아님
					// 비밀번호 찾기 이메일 발송 controller로 이동
				} else{
					alert("회원이 아니거나 정보를 잘못 입력 하셨습니다. 다시 입력 해주세요");
					document.getElementById('userId').value = '';
					document.getElementById('userName').value = '';
					document.getElementById('userEmail').value = '';
					}
				}, 

			// 실패 시
			error : function(){
				alert("pwFindOverlap 함수 통신 실패");
				}
			}); // end Ajax
		} // end pwFindOverlap
</script>
<!-- 아이디/비밀번호 찾기 ajax end -->

<!-- 비밀번호 찾기 인증번호 발송 start -->

<!--  -->

<!-- 비밀번호 찾기 - 인증번호 같은 지 확인 start -->
<script>
	function keyConfirm(){
		var key = "${sessionScope.key}";
		console.log("key : " + key);
		// 인증번호 발송 했을 때 생성된 난수

		var keyConfirm = document.getElementById("keyConfirm").value;
		consoel.log("keyConfirm : " + keyConfirm);
		// 회원이 인증번호를 받고 작성한 거
		
		var keyConfirmSpan = document.getElementById("keyConfirmSpan");
		// 인증번호가 일치 하는 지 불일치 하는 지 출력 할 span 부분

		$.ajax({
			type : "POST", // POST 방식으로
			url : "keyConfirm",
			data : {"key" : key, "keyConfirm" : keyConfirm},

			// 성공 시
			success : function(data){
				if(data=="OK"){
					keyConfirmSpan.innerHTML = "인증번호가 일치합니다";
				} else{
					document.getElementById('keyConfirm').value = '';
					document.getElementById('keyConfirm').focus();
					keyConfirmSpan.innerHTML = "인증번호가 일치하지 않습니다.";
					}
				}, 

			// 실패 시
			error : function(){
				alert("keyConfirm 함수 통신 실패");
				}
			}); // end Ajax
		} // end keyConfirm
</script>
<!-- 비밀번호 찾기 - 인증번호 같은 지 확인 end -->

<!-- 비밀번호 찾기 인증번호 확인 후 비밀번호 변경 jsp 팝업창으로 띄우기 start -->
<script>
	function pwProcess(){
		  location.href="PwProcess";
		  // 비밀번호 수정 jsp로 이동
	}
</script>
<!-- 비밀번호 찾기 인증번호 확인 후 비밀번호 변경 jsp 팝업창으로 띄우기 end -->
<body>
	<!-- 아이디/비밀번호 찾기 div start -->
	<div id="findDiv">
		아이디 찾기 <input type="radio" name="userFind" checked="checked" onclick="idFind()"> 
		비밀번호 찾기 <input type="radio" name="userFind" onclick="pwFind()"><br><br>
		
		<!-- 아이디 찾기 div start -->
		<div id="idOrPwFindDiv">
			<input type="text" id="userName" name="userName" placeholder="이름" required="required" maxlength="5"><br>
			<input type="email" id="userEmail" name="userEmail" placeholder="이메일" required="required" maxlength="50"><br>
			<button onclick="idFindOverlap()">아이디 찾기</button><br>
			<span id="idFindResult"></span>
			<!-- ajax로 조회 해온 회원의 아이디 출력 -->
		</div>
		<!-- 아이디 찾기 div end -->
	</div>
	<!-- 아이디/비밀번호 찾기 div end -->
	
	<button onclick="location.href='indexForm'">메인</button>
	<button onclick="location.href='memberLoginForm'">로그인</button>
	<button onclick="location.href='memberJoinForm'">회원가입</button>
</body>
</html>