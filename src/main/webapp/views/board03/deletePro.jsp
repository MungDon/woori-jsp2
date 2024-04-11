<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="web.bean.board03.Board03DAO" %>
<h1>deletePro</h1>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum= request.getParameter("pageNum");
	
	Board03DAO dao = Board03DAO.getInstance();
	int result = dao.imgDelete(num);
	if(result == 1){%>
			<script>
				alert(<%=num%>+"번 게시글이 영구 삭제 되었습니다");
				location.href="list.jsp?pageNum=<%=pageNum%>";
			</script>
<%	}
%>