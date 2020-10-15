<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
	table{
		border-collapse: collapse;
	}
</style>
<!-- 중복검사 Ajax start -->
<script type="text/javaScript" src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.js"></script>
<script>
	// 아이디 중복 확인
	function idOverlap(){
		
		// idCheck : 작성한 아이디(input text로 작성한 값)
		var userId = document.getElementById("userId").value;
		// confirmId : span 태그 준 부분
		var confirmId = document.getElementById("confirmId");

		$.ajax({
			type : "POST", // POST 방식으로
			url : "idoverlap", // Controller에 idoverlap이라는 value로 보낸다.
			data : {"userId" : userId}, // idCheck를 mid라는 변수명으로 담아서
			dataType : "text", // data의 type은 text이다.

			// 성공 시
			success : function(data){
				if(data=="OK"){
					confirmId.style.color = "#00ff00";
					confirmId.innerHTML = "사용 가능한 아이디 입니다.";
				} else{
					confirmId.style.color = "#ff0000";
					confirmId.innerHTML = "사용 중인 아이디 입니다.";
					document.getElementById('userId').value = '';
					document.getElementByid('userId').focus();
					}
				}, 

			// 실패 시
			error : function(){
				alert("idOverlap 함수 통신 실패");
				}
			}); // end Ajax
		} // end idOverlap

	// 전화번호 중복 확인
	function phoneOverlap(){
		
		var userPhone = document.getElementById("userPhone").value;
		var confirmPhone = document.getElementById("confirmPhone");

		$.ajax({
			type : "POST", // POST 방식으로
			url : "phoneoverlap", // Controller에 idoverlap이라는 value로 보낸다.
			data : {"userPhone" : userPhone}, // idCheck를 mid라는 변수명으로 담아서
			dataType : "text", // data의 type은 text이다.

			// 성공 시
			success : function(data){
				if(data=="OK"){
					confirmPhone.style.color = "#00ff00";
					confirmPhone.innerHTML = "사용 가능한 전화번호 입니다.";
				} else{
					confirmPhone.style.color = "#ff0000";
					confirmPhone.innerHTML = "사용 중인 전화번호 입니다.";
					document.getElementById('userPhone').value = '';
					document.getElementByid('userPhone').focus();
					}
				}, 

			// 실패 시
			error : function(){
				alert("phone 함수 통신 실패");
				}
			}); // end Ajax
		} // end phoneOverlap

		// 이메일 중복 확인
		function emailOverlap(){
			
			var userEmail = document.getElementById("userEmail").value;
			var confirmEmail = document.getElementById("confirmEmail");

			$.ajax({
				type : "POST", // POST 방식으로
				url : "emailoverlap", // Controller에 idoverlap이라는 value로 보낸다.
				data : {"userEmail" : userEmail}, // idCheck를 mid라는 변수명으로 담아서
				dataType : "text", // data의 type은 text이다.

				// 성공 시
				success : function(data){
					if(data=="OK"){
						confirmEmail.style.color = "#00ff00";
						confirmEmail.innerHTML = "사용 가능한 이메일 입니다.";
					} else{
						confirmEmail.style.color = "#ff0000";
						confirmEmail.innerHTML = "사용 중인 이메일 입니다.";
						document.getElementById('userEmail').value = '';
						document.getElementByid('userEmail').focus();
						}
					}, 

				// 실패 시
				error : function(){
					alert("email 함수 통신 실패");
					}
				}); // end Ajax
			} // end emailOverlap
</script>
<!-- 중복검사 Ajax end -->

<!-- 비밀번호 확인 start -->
<script>
	$(function(){
		$('#userPwConfirm').blur(function(){
		   if($('#userPw').val() != $('#userPwConfirm').val()){
		    	if($('#userPwConfirm').val()!=''){
			    alert("비밀번호가 일치하지 않습니다.");
		    	    $('#userPwConfirm').val(''); // 비밀번호가 일치하지 않으면 userPwConfirm의 값을 비운다.
		          $('#userPwConfirm').focus(); 
		       }
		    }
		})  	   
	});
</script>
<!-- 비밀번호 확인 end -->

<!-- 정규식 검사 start -->
<script>
	// 아이디 정규식 검사
	function idCheck(){
		var idReg = /^[A-za-z]/g;
			        	
		if( !idReg.test( $("input[name=userId]").val() ) ) {
			alert("아이디가 올바르지 않습니다.");
			$("input[name=userId]").val('');
			$("input[name=userId]").focus();
			return false;
		}
		return true;
	}

	// 전화번호 정규식 검사
	function phoneCheck(){

		var phone = $("input[name=userPhone]").val();
		var phoneReg = /^[0-9]*$/;

		if(phone.length == 11){
			if(!phoneReg.test( $("input[name=userPhone]").val() ) ){
				alert("전화번호가 올바르지 않습니다.");
				$("input[name=userPhone]").val('');
				$("input[name=userPhone]").focus();
				
				return false;
			}
		}else{
			alert("11자리로 입력해주세요");
			$("input[name=userPhone]").val();
			$("input[name=userPhone]").focus();

			return false;
		}
		return true;
	}

	// 비밀번호 정규식 검사
	function pwCheck(){
		var pw = $("input[name=userPw]").val();
		var num = pw.search(/[0-9]/g);
		var eng = pw.search(/[a-z]/ig);
		var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

		if(pw.length < 2 || pw.length > 16){
			alert("3자리 ~ 15자리 이내로 입력해주세요.");
			$("input[name=userPw]").val('');
			$("input[name=userPw]").focus();
			// 비밀번호가 정규식에 포함 되지 않았을 경우 focus와 val를 설정하여 다른 곳으로 갈 수 없도록 함.
			return false;
		}else if(pw.search(/\s/) != -1){
			alert("비밀번호는 공백 없이 입력해주세요.");
			$("input[name=userPw]").val('');
			$("input[name=userPw]").focus();
			return false;
		}else if(num < 0 || eng < 0 || spe < 0 ){
			alert("영문,숫자, 특수문자를 혼합하여 입력해주세요.");
			$("input[name=userPw]").val('');
			$("input[name=userPw]").focus();
			return false;
		}else {
			console.log("통과"); 
			return true;
		}
	}

</script>
<!-- 정규식 검사 end -->
<body>
	<p>*은 필수 조건입니다.</p>
	<!-- 회원가입 form start -->
	<form action="memberJoin" method="POST" enctype="Multipart/form-data">
		<table border=1>			
			<tr>
				<td>
					프로필 사진<br>
					<form id="form" runat="server">
   						<input type='file' id="userImageFile" name="userImageFile" maxlength="100"/><br>
   						<img id="image_section" style="height:250px"/>
					</form>
					
					<!-- 이미지 미리보기 start -->
					<script>
					function readURL(input) {
						 if (input.files && input.files[0]) {
						  var reader = new FileReader();
						  
						  reader.onload = function (e) {
						   $('#image_section').attr('src', e.target.result);  
						  }
						  
						  reader.readAsDataURL(input.files[0]);
						  }
						}
						 
						// 이벤트를 바인딩해서 input에 파일이 올라올때 위의 함수를 this context로 실행합니다.
						$("#userImageFile").change(function(){
						   readURL(this);
						});
					</script>
					<!-- 이미지 미리보기 end -->
				</td>
			</tr>
			
			<c:choose>
				<c:when test="${userNaver ne null}">
					<tr>
						<td>
							* <input type="text" name="userId" id="userId" onblur="idOverlap()" onchange="idCheck()" placeholder="네이버 아이디" required="required" maxlength="15"><br>
							<small>영문자, 숫자 혼합하여 15자리 이내(영문자로 시작)</small><br>
							<input type="hidden" name="userNaver" id="userNaver" value="${userNaver}">
							<span id="confirmId"></span><br>
							* <input type="password" name="userPw" id="userPw" placeholder="네이버 비밀번호" onchange="pwCheck()" maxlength="15" required="required"><br>
							<small>영문, 숫자, 특수문자를 혼합하여 15자리 이내</small><br>
							* <input type="password" name="userPwConfirm" id="userPwConfirm" placeholder="네이버 비밀번호 확인" required="required"><br>
						</td>
					</tr>
				</c:when>
				
				<c:when test="${userKakao ne null}">
					<tr>
						<td>
							* <input type="text" name="userId" id="userId" onblur="idOverlap()" onchange="idCheck()" placeholder="카카오 아이디" required="required" maxlength="15"><br>
							<small>영문자, 숫자 혼합하여 15자리 이내(영문자로 시작)</small><br>
							<input type="hidden" name="userKakao" id="userKakao" value="${userKakao}">
							<span id="confirmId"></span><br>
							* <input type="password" name="userPw" id="userPw" placeholder="카카오 비밀번호" onchange="pwCheck()" maxlength="15" required="required"><br>
							<small>영문, 숫자, 특수문자를 혼합하여 15자리 이내</small><br>
							* <input type="password" name="userPwConfirm" id="userPwConfirm" placeholder="카카오 비밀번호 확인" required="required"><br>
						</td>
					</tr>
				</c:when>
				
				<c:otherwise>
					<tr>
						<td>
							* <input type="text" name="userId" id="userId" placeholder="아이디 " onblur="idOverlap()" onchange="idCheck()" maxlength="15" required="required"><br>
																																		<!-- 최대 글자 수 지정 --><!-- 필수 조건으로 설정 -->
							<small>영문자, 숫자 혼합하여 15자리 이내(영문자로 시작)</small><br>
							<span id="confirmId"></span>
						</td>
					</tr>
					
					<tr>
						<td>
							* <input type="password" id="userPw" name="userPw" placeholder="비밀번호" onchange="pwCheck()" maxlength="15" required="required"><br>
																													 <!-- 최대 글자 수 지정 --><!-- 필수 조건으로 설정 -->
							<small>영문, 숫자, 특수문자를 혼합하여 15자리 이내</small><br>
							* <input type="password" id="userPwConfirm" name="userPwConfirm" placeholder="비밀번호 재확인 " required="required"><br>
																														<!-- 필수 조건으로 설정 -->
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
			
			<tr>
				<td>* <input type="text" id="userName" name="userName" placeholder="이름" required="required" maxlength="5"></td>
																						<!-- 필수 조건으로 설정 -->
			</tr>
			
			<tr>
				<td>
					* 성별 : 남자<input type="radio" id="userGender" name="userGender" value="남" required="required" maxlength="2">
						       여자<input type="radio" id="userGender" name="userGender" value="여" required="required" maxlength="2"></td>
						       																  <!-- 필수 조건으로 설정 -->
			</tr>
			
			<tr>
				<td>* <input type="date" id="userBirth" name="userBirth" placeholder="생년월일" required="required"></td>
																								<!-- 필수 조건으로 설정 -->
			</tr>
			
			<tr>
				<td>
					<input type="text" id="postcode" name="postcode" placeholder="우편번호">
					<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" id="address" name="address" placeholder="주소"><br>
					<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소">
					<input type="text" id="extraAddress" name="extraAddress" placeholder="참고항목">
				</td>
			</tr>
			
			<tr>
				<td>
					* <input type="text" id="userPhone" name="userPhone" placeholder="전화번호" onblur="phoneOverlap()" onchange="phoneCheck()" maxlength="11" required="required"><br>
																												<!-- 최대 글자 수 지정 --><!-- 필수 조건으로 설정 -->
					<small>(-)를 제외하고 작성 해주세요</small><br>
					<span id="confirmPhone"></span>
				</td>
			</tr>
			
			<tr>
				<td>
					* <input type="email" id="userEmail" name="userEmail" onblur="emailOverlap()" placeholder="이메일" required="required" maxlength="50"><br>
																							 <!-- 필수 조건으로 설정 -->
					<small>본인인증이 발송 될 이메일 입니다. 정확하게 작성 해주세요</small><br>
					<span id="confirmEmail"></span>
				</td>
			</tr>
			
			<tr>
				<td>
					<input type="submit" value="회원가입"><br>
					<input type="reset" value="다시 입력">
				</td>
			</tr>
		</table>
	</form>
	<button onclick="location.href='memberLoginForm'">로그인</button>
	<button onclick="location.href='indexForm'">메인</button>
	<!-- 회원가입 form end -->
</body>
<!-- 이미지 미리보기 Script start-->
<script type="text/javascript">
    	//이미지 미리보기
    	var sel_file;
 
    	$(document).ready(function() {
       	 	$("#userImage").on("change", handleImgFileSelect);
   	 	});
 
    	function handleImgFileSelect(e) {
        	var files = e.target.files;
        	var filesArr = Array.prototype.slice.call(files);
 
        	var reg = /(.*?)\/(jpg|jpeg|png|bmp)$/;
 
        	filesArr.forEach(function(f) {
           	 	if (!f.type.match(reg)) {
                	alert("확장자는 이미지 확장자만 가능합니다.");
                	return;
            	}
 
            	sel_file = f;
 
            	var reader = new FileReader();
            	reader.onload = function(e) {
                $("#img").attr("src", e.target.result);
            	}
            	reader.readAsDataURL(f);
        	});
    	}
	</script>
<!-- 이미지 미리보기 Script end -->

<!-- 우편주소 API script start -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>
<!-- 우편주소 API script end -->
</html>