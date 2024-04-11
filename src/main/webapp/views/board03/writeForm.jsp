<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>board03/writeForm</h1>
<form action="writePro.jsp" method="post" enctype="multipart/form-data">
	제목<input type="text" name="title"/><br/>
	이미지<input type="file" name="img"/><br/>
	<input type="submit" value="등록"/>
</form>