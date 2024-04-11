<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.io.File" %>
<%@ page import ="com.oreilly.servlet.MultipartRequest" %>
<%@ page import ="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import ="web.bean.board03.Board03DAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dto" class="web.bean.board03.Board03DTO"/>
<jsp:setProperty property="*" name="dto"/>
<h1>board03/writePro</h1>

<%
	String filePath = request.getRealPath("views/upload");// 업로드할 실제 폴더 경로
	int max = 1024*1024*5; // 파일크기 설정
	String enc = "UTF-8";	// 인코딩
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();// 같은파일이 있으면 이름 옆에 숫자를 붙임
	MultipartRequest mr = new MultipartRequest(request, filePath,max,enc,dp);
	
	String title = mr.getParameter("title");
	String img = mr.getFilesystemName("img");
	
	Board03DAO dao = Board03DAO.getInstance();
	dto.setTitle(title);
	dto.setImg(img);
	int result = dao.imgInsert(dto);
	
	if(result == 1){%>
		<script>
			alert("글이 등록되었습니다");
			window.location="list.jsp";
		</script>
<%	}%>
