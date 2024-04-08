<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>/member/deletePro.jsp</h1>
<jsp:useBean id="dao" class="web.bean.member.MemberDAO" />
<jsp:useBean id="dto" class="web.bean.member.MemberDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%
	String sid = (String)session.getAttribute("sid");
	dto.setId(sid);
	int result = dao.deleteMember(dto);
	if(result == 1){
		session.invalidate();
%>
	<script>
		alert("탈퇴되었습니다.");
		window.location="main.jsp";
	</script>
<% }else{%>
	<script>
		alert("비밀번호를 확인해주세요.");
		history.go(-1);
	</script>
<% }%>