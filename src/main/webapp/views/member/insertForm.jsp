<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>/member/InsertForm</h1>
<script>
	function memChk(){
		let userInput = "document.userInput";
		const pw = userInput.pw.value;
		const pw2 = userInput.pw2.value;
		
		if(!userInput.id.value){
			alert("아이디를 입력해주세요");
			userInput.id.focus();
			return false;
		}
		if(!pw){
			alert("비밀번호를 입력해주세요");
			userInput.pw.focus();
			return false;		
		}
		if(userInput.pw.value != userInput.pw2.value){
			alert("입력한 비밀번호와 비밀번호 확인이 일치하지않습니다");
			userInput.pw2.focus();
			return false;	
		}
		return true;
	}
	
	function idCheck(){
		var id = document.getElementById("id").value;
		open("confirmId.jsp?id="+id,'confirm', 'width=400,heigth=400');
	}
</script>


<form action="InsertPro.jsp" name="userInput" method="get" onsubmit="return memChk()">
	id:		<input type="text" name="id" id="id" />		<br />
			<input type="button" value="중복확인" 
				onclick="idCheck();"/>
				
			<div id="idResult"></div>	
				
	pw: 	<input type="password" name="pw" />	<br />
	pw 확인: 	<input type="password" name="pw2" />	<br />
	name:	<input type="text" name="name" />	<br />
	birth:	<input type="date" name="birth" />	<br />
	phone1:	<select name="phone1">
				<option value="U+">U+</option>
				<option value="KT">KT</option>
				<option value="SKT">SKT</option>
				<option value="알뜰폰">알뜰폰</option>
			</select>
	phone2:	<input type="text" name="phone2" />	<br />
	gender:	<input type="radio" name="gender" value="m" /> 남
			<input type="radio" name="gender" value="w" /> 여 <br />
			<input type="submit" value="회원가입" />
</form>