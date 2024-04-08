<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "web.bean.board02.Board02DAO" %>
<%@ page import = "web.bean.board02.Board02DTO" %>
<h1>/board02/content</h1>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");

	try{
		Board02DAO dao = Board02DAO.getInstance();
		Board02DTO dto =  dao.readContent(num);
		
		int ref		= dto.getRef();
		int re_step	= dto.getRe_step();
		int re_level= dto.getRe_level();
%>
 
<center><b>글내용 보기</b></center>
<br />

<table width="500" border="1" cellspacing="0" cellpadding="0" align="center">  
	<tr height="30">
		<td align="center" width="125" >글번호</td>
	    <td align="center" width="125" align="center">
			<%=dto.getNum()%>
		</td>
		<td align="center" width="125" >조회수</td>
		<td align="center" width="125" align="center">
			<%=dto.getReadCount()%></td>
 	</tr>
 	<tr height="30">
		<td align="center" width="125" >작성자</td>
		<td align="center" width="125" align="center">
			<%=dto.getWriter()%>
		</td>
		<td align="center" width="125" >작성일</td>
		<td align="center" width="125" align="center">
			<%= dto.getReg()%>
		</td>
	</tr>
	<tr height="30">
		<td align="center" width="125" >글제목</td>
		<td align="center" width="375" align="center" colspan="3">
			<%=dto.getTitle()%>
		</td>
	</tr>
	<tr>
		<td align="center" width="125" >글내용</td>
		<td align="left" width="375" colspan="3">
			<pre><%=dto.getContent()%></pre>
		</td>
	</tr>
	<tr height="30">      
		<td colspan="4" align="right" > 
			<input type="button" value="글수정" 
			onclick="window.location='updateForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" />
	   &nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="글삭제" 
			onclick="window.location='deleteForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" />
	   &nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="답글쓰기" 
			onclick="window.location='writeForm.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>' " />
	   &nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="글목록" 
			onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
		</td>
	</tr>
</table>    
<%
	}catch(Exception e){} 
%>    
