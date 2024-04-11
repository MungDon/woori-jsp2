<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="web.bean.board03.Board03DAO"%>
<%@ page import="web.bean.board03.Board03DTO"%>
<h1>board03/updateForm</h1>


<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	Board03DAO dao = Board03DAO.getInstance();
	Board03DTO dto = dao.content(num);
%>

	<form action="updatePro.jsp?pageNum=<%=pageNum%>" method="post"
		enctype="multipart/form-data">
		<input type="hidden" name="num" value="<%=dto.getNum()%>">
		제목<input type="text" name="title" value="<%=dto.getTitle()%>"/><br/>
		이미지<input type="file" name="img"/>
		<input type="submit" value="수정완료" />
		<input type="button" value="취소" onclick="window.location='content.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum %>'"/>
	</form>
<%--<script>
	function imgInputTag(){
		 let html="";
		 html +=`
		 	
		 `;
		 inputImg.insertAdjacentHTML("beforeend", html)
	}
	function remove(){
		input = document.getElementById("inputImg");
		input.remove();
	}
</script> --%>