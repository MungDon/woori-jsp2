<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>/member/updateForm</h1>
<jsp:useBean id="dao" class="web.bean.member.MemberDAO" />
<jsp:useBean id="dto" class="web.bean.member.MemberDTO" />
<%
	// 로그인 한 후에 개인정보를 보여줘야함.
	// 아이디 정보를 꺼내와야함 -> session은 tomcat 서버에 보관 중.
	String sid = (String)session.getAttribute("sid");
	dto = dao.idInfo(sid);
%>
<form action="updatePro.jsp" method="get">
	id :		<%=sid %>	<br />
				<input type="hidden" name="id" value="<%=sid %>" />
	pw 변경 :	<input type="password" name="pw" value="<%=dto.getPw() %>" />	<br />
	name 변경:	<input type="text" name="name" value="<%=dto.getName() %>" />	<br />
	birth:		<%=dto.getBirth() %>	<br />
	통신사 변경:	<select name="phone1">
					<option><%=dto.getPhone1() %></option>
					<option value="U+">U+</option>
					<option value="KT">KT</option>
					<option value="SKT">SKT</option>
					<option value="알뜰폰">알뜰폰</option>	
				</select>
	연락처 변경 : 	<input type="text" name="phone2" value="<%=dto.getPhone2() %>" /> <br />
	gender: 	<%=dto.getGender() %>	<br />
				<input type="submit" value="정보수정" />
</form>