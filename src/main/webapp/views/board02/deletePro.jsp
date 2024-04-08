<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "web.bean.board02.Board02DAO" %>
<h1>/board02/deletePro</h1>
<% request.setCharacterEncoding("UTF-8");%>

<%
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");
  String passwd = request.getParameter("passwd");

  Board02DAO dao = Board02DAO.getInstance();
  int result = dao.boardDelete(num, passwd);

  if(result == 1){
%>
	<script>
		alert("글이 삭제 되었습니다.");
		window.location="list.jsp?pageNum=<%=pageNum%>";
	</script>
<% }else{%>
	<script>           
		alert("비밀번호가 맞지 않습니다");
		history.go(-1);
	</script>
<%}%>