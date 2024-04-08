<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>/member/cooLogout.jsp</h1>
<%
	// 쿠키 삭제
	Cookie[] cookies = request.getCookies();
	for( Cookie c : cookies ){
		if( c.getName().equals("cid") 
			|| c.getName().equals("cpw") 
			|| c.getName().equals("cauto") )
		{
			c.setMaxAge(0);
			response.addCookie(c);
		}
	}
	
	// 세션 삭제
	session.invalidate();
	
	response.sendRedirect("cooMain.jsp");
%>