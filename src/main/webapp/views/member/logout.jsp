<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>/member/logout.jsp</h1>
<%
	// 세션 삭제
//	session.removeAttribute("sid");
	// 모든 세션 삭제
	session.invalidate();
	
	response.sendRedirect("main.jsp");
%>