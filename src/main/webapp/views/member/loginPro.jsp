<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>/member/loginPro.jsp</h1>
<jsp:useBean id="dao" class="web.bean.member.MemberDAO" />
<jsp:useBean id="dto" class="web.bean.member.MemberDTO" />
<jsp:setProperty property="*" name="dto" />

<%
	boolean result = dao.loginCheck(dto);
	if(result == true){
		session.setAttribute("sid", dto.getId());
		response.sendRedirect("main.jsp");
	}else{
%>
	<script>
		alert("아이디/비밀번호를 확인해주세요.");
		history.go(-1);
	</script>
<%	}%>