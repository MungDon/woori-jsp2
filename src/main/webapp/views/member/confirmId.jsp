<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>/member/confirmId.jsp</h1>
<h2>아이디 중복확인</h2>
<jsp:useBean id="dao" class="web.bean.member.MemberDAO" />
<jsp:useBean id="dto" class="web.bean.member.MemberDTO" />
<jsp:setProperty name="dto" property="id" />

<%
	boolean result = dao.confirmId(dto.getId());
	if(result == true){
%>
	<script>
		opener.document.getElementById("idResult")
			.innerHTML="<font color='red'>사용 불가능한 아이디 입니다.</font>";
		self.close();
	</script>
<%}else{%>
	<script>
		opener.document.getElementById("idResult")
			.innerHTML="<font color='blue'>사용 가능한 아이디 입니다.</font>";
		self.close();
	</script>
<%}%>
