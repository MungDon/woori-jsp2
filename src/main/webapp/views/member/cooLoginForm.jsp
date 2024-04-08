<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>/member/cooLoginForm</h1>

<form action="cooLoginPro.jsp" method="post">
	id:			<input type="text"		name="id" />	<br />
	pw:			<input type="password"	name="pw" />	<br />
	자동로그인:	<input type="checkbox"	name="auto" value="1" /> <br />
				<input type="submit"	value="로그인" />
</form>