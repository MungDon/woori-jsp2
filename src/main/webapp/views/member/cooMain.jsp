<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>/member/cooMain.jsp</h1>

<%
	// 먼저 session꺼내줌
	String sid = (String)session.getAttribute("sid");
	
	// 세션이 없다면
	if( sid == null ){
		// 쿠키 확인 전 변수 선언!
		String cid = null, cpw = null, cauto = null;
		
		// 쿠키 꺼냄 -> 쿠키 배열로 받아줌
		Cookie[] cookies = request.getCookies();
		
		// 쿠키가 null이 아니라면 (= 값이 있다는 것)
		if( cookies != null ){
			// 반복문으로 꺼낸다
			for( Cookie c : cookies ){
				// 선언한 변수에 값 대입
				if( c.getName().equals("cid") ){ cid = c.getValue(); }
				if( c.getName().equals("cpw") ){ cpw = c.getValue(); }
				if( c.getName().equals("cauto") ){ cauto = c.getValue(); }
			}
		}
		if( cid != null || cpw != null || cauto != null ){
			response.sendRedirect("cooLoginPro.jsp");
		}
		
%>
	<button onclick="window.location='insertForm.jsp'">회원가입</button>
	<button onclick="window.location='cooLoginForm.jsp'">로그인</button>		
<%	}else{%>
	<h2>[<%=sid %>] 님 환영합니다 ^^</h2>
	<button onclick="window.location='allMember.jsp'">전체회원</button>
	<button onclick="window.location='updateForm.jsp'">내 정보</button>
	<button onclick="window.location='cooLogout.jsp'">로그아웃</button>
<%	}%>

<%--
폴더가 다를때! 
localhost:8080 다음의 경로이기 때문에 생략하면 안된다!
불가넝:	<button onclick="window.location='/member/insertForm.jsp'">회원가입</button>

가넝
절대경로:	<button onclick="window.location='/web/views/member/insertForm.jsp'">회원가입</button>
상대경로:	<button onclick="window.location='../member/insertForm.jsp'">회원가입</button>
--%>