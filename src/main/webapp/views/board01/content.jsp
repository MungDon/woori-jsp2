<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>/board/content.jsp</h1>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dao" class="web.bean.board01.Board01DAO" />
<jsp:useBean id="dto" class="web.bean.board01.Board01DTO" />
<jsp:setProperty name="dto" property="*" />

<%
	int num = Integer.parseInt( request.getParameter("num") );
	dto = dao.content(num);
%>

<table border="1">
	<tr>
		<td>글번호</td><td><%=dto.getNum() %></td>
	</tr>
	<tr>
		<td>작성자</td><td><%=dto.getWriter() %></td>
	</tr>
	<tr>
		<td>작성날짜</td><td><%=dto.getReg() %></td>
	</tr>
	<tr>
		<td>글제목</td><td><%=dto.getTitle() %></td>
	</tr>
	<tr>
		<td>글내용</td><td><%=dto.getContent() %></td>
	</tr>
</table>
<button onclick="window.location='updateForm.jsp?num=<%= dto.getNum() %>'">수정</button>
<button onclick="window.location='deletePro.jsp?num=<%= dto.getNum() %>'">삭제</button>