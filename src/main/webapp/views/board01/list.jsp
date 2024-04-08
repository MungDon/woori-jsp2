<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="web.bean.board01.Board01DTO" %>   
<h1>/board/list.jsp</h1>

<%	request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dao" class="web.bean.board01.Board01DAO" />

<%
	int pageSize = 10;
	
	String pageNum = request.getParameter("pageNum");
	if( pageNum == null ){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = ( currentPage - 1 ) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	int count = dao.count();
%>

<table border="1" width="800">
	<tr>
		<td>글번호</td><td>글제목</td><td>작성자</td><td>작성일자</td>
	</tr>
<%
	ArrayList<Board01DTO> list = dao.list(startRow, endRow);
	for( Board01DTO dto : list ){
%>	
	<tr>
		<td><%=dto.getNum() %></td>
		<td>
			<a href="content.jsp?num=<%=dto.getNum() %>"><%= dto.getTitle() %></a>
		</td>
		<td><%=dto.getWriter() %></td>
		<td><%=dto.getReg() %></td>
	</tr>
<%	} %>
</table>

<% 
	if( count > 0 ){
		int pageCount = count / pageSize +( count % pageSize == 0 ? 0 : 1 );
		int startPage = (int)((currentPage-1)/10) * 10 +1;
		
		int pageBlock = 10;
		
		int endPage = startPage + pageBlock -1;
		if( endPage > pageCount ){
			endPage = pageCount;
		}
		
		if( startPage > 10 ){ %>
			<a href="list.jsp?pageNum=<%=startPage-10 %>">[이전]</a>
<% 		}
		for( int i = startPage; i <= endPage; i++ ){ %>
			<a href="list.jsp?pageNum=<%=i%>">[<%=i %>]</a>
<%		}
		if( endPage < pageCount){ %>
			<a href="list.jsp?pageNum=<%=startPage+10 %>">[다음]</a>
<%		}
	}
%>