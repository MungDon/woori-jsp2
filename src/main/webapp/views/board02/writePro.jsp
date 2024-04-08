<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "web.bean.board02.Board02DAO" %>

<% request.setCharacterEncoding("UTF-8");%>

<h1>/board02/writePro.jsp</h1>

<jsp:useBean id="dto" class="web.bean.board02.Board02DTO">
   <jsp:setProperty name="dto" property="*"/>
</jsp:useBean>
 
<%
	Board02DAO dao = Board02DAO.getInstance();
	int result = dao.boardInsert(dto);

	if(result == 1){
%>
	<script>
		alert("글이 등록 되었습니다.");
		window.location="list.jsp";
	</script>
<%	}%> 