<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="web.bean.board03.Board03DAO" %>
<%@ page import ="web.bean.board03.Board03DTO" %>
<style>
	table{
		border-collapse: collapse;
		text-align: center;
	}
	tr,td,th{
		border : 1px solid darkgray;
	}
</style>
<h1>board03/content</h1>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	Board03DAO dao = Board03DAO.getInstance();
	Board03DTO dto = dao.content(num);
%>
<center><b>글내용보기</b>
<br/>
<br/>
<table>
	<tr>
		<th colspan="2">글 번호</th>
		<td colspan="2"><%=dto.getNum() %></td>
	</tr>
	<tr>
		<th>글 제목</th>
		<td><%=dto.getTitle() %></td>
		<th>등록일시</th>
		<td><%=dto.getReg() %></td>
	</tr>
	<tr>
		<td colspan="4">
		<%if(dto.getImg() == null){ %>
			<img src="/web002/views/images/noimages.png" width="500" height="500"/>
		<%}else{ %>
			<img src="../upload/<%=dto.getImg() %>"width="500" height="500"/>
		<%} %>
		</td>
	</tr>
	<tr>
		<td colspan="4">
			<input type="button" value="글수정" onclick="window.location='updateForm.jsp?num=<%=dto.getNum() %>&pageNum=<%=pageNum %>'"/>
			&nbsp;&nbsp;
			<input type="button" value="글삭제" onclick="deleteBtn()"/>
			&nbsp;&nbsp;
			<input type="button" value="글목록" onclick="window.location='list.jsp?pageNum=<%=pageNum %>'"/>
		</td>
	</tr>
</table>
	<script>
		function deleteBtn(){
			if(confirm(<%=num%>+"번 게시글을 삭제하시겠습니까?")){
				location.href="deletePro.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum %>";
			}else{
				location.reload();
			}
		}
	</script>
</center>