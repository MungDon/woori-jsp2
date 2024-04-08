<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="web.bean.member.MemberDTO"%>
<h1>allMember</h1>
<jsp:useBean id="dao" class="web.bean.member.MemberDAO" />

<%
	List<MemberDTO> list = dao.allMember();
	
	for( MemberDTO dto : list ){
%>	
	<h2><%=dto.getId() %> : <%=dto.getName() %> : <%=dto.getReg() %></h2>
		
<%	}%>