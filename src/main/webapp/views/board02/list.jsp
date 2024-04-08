<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "web.bean.board02.Board02DAO" %>
<%@ page import = "web.bean.board02.Board02DTO" %>
<%@ page import = "java.util.ArrayList" %>
<h1>/board02/list.jsp</h1>
<%
	int pageSize = 10;
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);
    int startRow	= (currentPage - 1) * pageSize + 1;
    int endRow	= currentPage * pageSize;
    int count	= 0;

    ArrayList list = null;
    Board02DAO dao = Board02DAO.getInstance();
    count = dao.boardCount();
    if (count > 0) {
    	list = dao.boardList(startRow, endRow);
    }
%>

<center><b>글목록(전체 글:<%=count%>)</b>
<table width="700">
<tr>
    <td align="right" >
    <a href="writeForm.jsp">글쓰기</a>
    </td>
</table>

<%
    if (count == 0) {
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
    <td align="center">
    	<h1>게시판에 저장된 글이 없습니다.</h1>
    </td>
</table>

<%  } else {    %>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
	<tr height="30" > 
		<td align="center"  width="50"  >글번호</td> 
		<td align="center"  width="250" >글제목</td> 
		<td align="center"  width="100" >작성자</td>
		<td align="center"  width="150" >작성일</td> 
		<td align="center"  width="50" >조회수</td>  
	</tr>
<%  
	 	for (int i = 0 ; i < list.size() ; i++) {
			Board02DTO dto = (Board02DTO)list.get(i);
%>
	<tr height="30">
		<td align="center"  width="50" >
			<%=dto.getNum()%>
		</td>
		<td width="250" >
<%
			int wid = 0;
			if( dto.getRe_level() > 0){
				wid = 15*( dto.getRe_level() );
%>
		<img src="../images/level.gif" width="<%=wid%>" height="16">
		<img src="../images/re.gif">
<%			}else{%>
		<img src="../images/level.gif" width="<%=wid%>" height="16">
<% 			}%>
	    <a href="content.jsp?num=<%=dto.getNum()%>&pageNum=<%=currentPage%>">
		           <%=dto.getTitle()%>
		</a> 
<% 			if(dto.getReadCount()>= 20){%>
		<img src="../images/hot.gif" border="0"  height="16">
<%			}%> 
		</td>
		<td align="center"  width="100"> 
	       	<%=dto.getWriter()%>
		</td>
		<td align="center"  width="150">
			<%= dto.getReg()%>
		</td>
		<td align="center"  width="50">
			<%= dto.getReadCount()%>
		</td>
	</tr>
	<%	}%>
</table>
<%}%>

<%
    if (count > 0) {
        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
		 
        int startPage = (int)(currentPage/10)*10+1;
		int pageBlock=10;
        int endPage = startPage + pageBlock-1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) {    %>
        <a href="list.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %>
        <a href="list.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%
        }
        if (endPage < pageCount) {  %>
        <a href="list.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%
        }
    }
%>
</center>
