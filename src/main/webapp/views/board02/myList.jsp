<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "web.bean.board02.Board02DAO" %>
<%@ page import = "web.bean.board02.Board02DTO" %>
<%@ page import = "java.util.ArrayList" %>
<h1>myList.jsp</h1>

<%
	String sid = (String)session.getAttribute("sid");
	int pageSize = 10;	// 한페이지에 보여줄 게시글 수
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {// 받아오는 페이지번호가 없다면 해당페이지가 1번이다
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);// 현재페이지
    int startRow	= (currentPage - 1) * pageSize + 1; // 해당페이지의 게시글 시작번호
    int endRow	= currentPage * pageSize;// 해당페이지의 게시글 끝번호
    int count	= 0;// 총 게시글 수

    ArrayList<Board02DTO> list = null; // 리스트객체 초기화
    Board02DAO dao = Board02DAO.getInstance();// dao 객체 호출
    count = dao.MyBoardCount(sid);// count 변수에 db 에서 가져온 모든 게시글 수 저장 
    if (count > 0) {// 게시글이있다면
    	list = dao.MyBoardList(startRow, endRow, sid);//리스트 db에서 뽑아온걸 list에 저장
    }
%>
<center><b>글목록(전체 글:<%=count%>)</b>
<table style="width : 700">

<% if(sid==null){ //세션없음 = 로그인상태가아님 %>
	<tr>
		<td>
			<a href="../member/main.jsp">로그인</a>
			
		<td>
	</tr>
<% }else{ %>
<tr>
    <td align="right" >
    	<a href="writeForm.jsp">글쓰기</a>
    	<a href="list.jsp">전체 글목록</a>
    </td>
</tr>
 <%} %>
</table>

<%
    if (count == 0) { // 게시글이 없다면 아래 문구 보여줌
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
    <td align="center">
    	<h1>게시판에 저장된 글이 없습니다.</h1>
    </td>
</table>

<%  } else {  //있다면 리스트 보여줌  %>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
	<tr height="30" > 
		<td align="center"  width="50"  >글번호</td> 
		<td align="center"  width="250" >글제목</td> 
		<td align="center"  width="100" >작성자</td>
		<td align="center"  width="150" >작성일</td> 
		<td align="center"  width="50" >조회수</td>  
	</tr>
<%  
//	 	for (int i = 0 ; i < list.size() ; i++) {
//			Board02DTO dto = (Board02DTO)list.get(i);
		for(Board02DTO dto : list){ // 가독성 향상을위해 향상된 for문으로 변경
%>
	<tr height="30">
		<td align="center"  width="50" >
			<%=dto.getNum()%>
		</td>
		
		<td width="250" >
<%
			int wid = 0; // 너비
			if( dto.getRe_level() > 0){
				wid = 15*( dto.getRe_level() );//레벨이올라갈때마다 즉 답글의답글일때마다 사진의 너비 증가 ㅋㅋ
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
        <a href="myList.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %>
        <a href="myList.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%
        }
        if (endPage < pageCount) {  %>
        <a href="myList.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%
        }
    }
%>
</center>
