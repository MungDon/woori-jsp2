<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>/board/updateForm.jsp</h1>

<%	request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dao" class="web.bean.board01.Board01DAO" />
<jsp:useBean id="dto" class="web.bean.board01.Board01DTO" />
<jsp:setProperty property="*" name="dto"/>

<%
	int num = Integer.parseInt( request.getParameter("num") );
	dto = dao.updateForm(num);
%>
<form action="updatePro.jsp" method="post">
	<input type="hidden" name="num" value="<%=num %>" />
	writer:	<input type="text" name="writer" value="<%= dto.getWriter()%>" />	<br />
	title:	<input type="text" name="title" value="<%= dto.getTitle()%>"/>	<br />
	content:<textarea name="content" rows="10" cols="40" ><%= dto.getContent()%></textarea>	<br />
			<button type="submit">글수정</button>
</form>