<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>/0402/InsertPro.jsp</h1>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dao" class="web.bean.member.MemberDAO" />
<jsp:useBean id="dto" class="web.bean.member.MemberDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%
	dao.insertMember(dto);	// 메서드 호출(매개변수=파라미터 dto)
%>
	<script>
		alert("가입되었습니다.");
		window.location="main.jsp";
	</script>