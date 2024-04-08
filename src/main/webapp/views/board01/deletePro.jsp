<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>/board/deletePro.jsp</h1>

<%	request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dao" class="web.bean.board01.Board01DAO" />
<jsp:useBean id="dto" class="web.bean.board01.Board01DTO" />
<jsp:setProperty property="*" name="dto"/>

<%
	int num = Integer.parseInt( request.getParameter("num") );
	int result = dao.delete(num);
%>
<h2><%=result %> 개의 글이 삭제되었습니다.</h2>