<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.io.File" %>
<%@ page import ="com.oreilly.servlet.MultipartRequest" %>
<%@ page import ="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="web.bean.board03.Board03DAO"%>
<%@ page import="web.bean.board03.Board03DTO"%>
<% request.setCharacterEncoding("UTF-8"); %>
<h1>board03/updatePro</h1>
<%
	String pageNum = request.getParameter("pageNum");
	
	String filePath = request.getRealPath("views/upload");// 업로드할 실제 폴더 경로
	int max = 1024*1024*5; // 파일크기 설정
	String enc = "UTF-8";	// 인코딩
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();// 같은파일이 있으면 이름 옆에 숫자를 붙임
	MultipartRequest mr = new MultipartRequest(request, filePath,max,enc,dp);
	
	int num = Integer.parseInt(mr.getParameter("num"));
	String title = mr.getParameter("title");
	String img = mr.getFilesystemName("img");
	
	Board03DAO dao = Board03DAO.getInstance();
	
	
	
    Board03DTO originalDto = dao.content(num); 

    // 기존 이미지 삭제
    String originalImg = originalDto.getImg();
    if (originalImg != null) {
        File fileToDelete = new File(filePath, originalImg);
        if (fileToDelete.exists()) {
            fileToDelete.delete();
        }
    }
	
	
    originalDto.setTitle(title);
    originalDto.setImg(img);
    originalDto.setNum(num);
	int result = dao.imgUpdate(originalDto);
	if(result == 1){%>
		<script>
			alert("수정되었습니다");
			window.location="content.jsp?num=<%=originalDto.getNum()%>&pageNum=<%=pageNum%>";
		</script>	
<%	}
%>