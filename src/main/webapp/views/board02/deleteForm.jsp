<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>/board02/deleteForm</h1>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
%>

<center><b>글삭제</b></center>
<br />
<form action="deletePro.jsp?pageNum=<%=pageNum%>" method="post">> 
<table border="1" align="center" cellspacing="0" cellpadding="0" width="360">
	<tr height="30">
		<td align=center >
			<b>비밀번호를 입력해 주세요.</b>
		</td>
	</tr>
	<tr height="30">
		<td align=center >   
			pw: <input type="password" name="passwd" size="8" maxlength="12">
				<input type="hidden" name="num" value="<%=num%>">
		</td>
	</tr>
	<tr height="30">
		<td align = center >
			<input type="submit" value="글삭제" >
			<input type="button" value="글목록" 
			onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">     
		</td>
	</tr>  
</table> 
</form>