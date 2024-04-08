<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>/member/cooLoginPro.jsp</h1>

<jsp:useBean id="dao" class="web.bean.member.MemberDAO" />
<jsp:useBean id="dto" class="web.bean.member.MemberDTO" />
<jsp:setProperty name="dto" property="*" />

<%
	// DB확인 전에 쿠키 꺼내줘야한다.
	Cookie[] cookies = request.getCookies();
	for( Cookie c : cookies ){
		if(c.getName().equals("cid")){ dto.setId(c.getValue()); }
		if(c.getName().equals("cpw")){ dto.setPw(c.getValue()); }
		if(c.getName().equals("cauto")){ dto.setAuto(c.getValue()); }
	}
	
	// DB 에서 확인
	boolean result = dao.loginCheck(dto);
	if(result == true){	// id/pw 일치
		
		// 자동로그인 확인
		if( dto.getAuto() != null && dto.getAuto().equals("1") ){
			// 쿠키 생성
			// dto에서의 변수와 매칭
			Cookie coo1 = new Cookie("cid", dto.getId());
			Cookie coo2 = new Cookie("cpw", dto.getPw());
			Cookie coo3 = new Cookie("cauto", dto.getAuto());
			
			// 쿠키생명(유효시간) 생성 or 한번 더 생성이니 갱신
			coo1.setMaxAge(60*60*24*2);
			coo2.setMaxAge(60*60*24*2);
			coo3.setMaxAge(60*60*24*2);
			
			// 쿠키 추가
			response.addCookie(coo1);
			response.addCookie(coo2);
			response.addCookie(coo3);
		}
	
		// 자동 로그인 결과 == null : 쿠키생성 없이 세션 생성!
		session.setAttribute("sid", dto.getId());
		response.sendRedirect("cooMain.jsp");
		
	}else{	// id/pw 불일치
%>
	<script>
		alert("아이디/비밀번호를 확인하세요.");
		window.location="cooLoginForm.jsp";
	</script>
<%	}%>