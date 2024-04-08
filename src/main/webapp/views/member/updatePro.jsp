<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>/member/updatePro.jsp</h1>
<jsp:useBean id="dao" class="web.bean.member.MemberDAO" />
<jsp:useBean id="dto" class="web.bean.member.MemberDTO" />
<jsp:setProperty name="dto" property="*" />

<% 
	String sid = (String)session.getAttribute("sid");
	dao.updateMember(dto);
%>
	<script>
		alert("수정이 완료되었습니다.");
		window.location="main.jsp";
	</script>