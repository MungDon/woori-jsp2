package web.bean.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.ArrayList;

// OracleConnection의 static 메서드 사용!
public class MemberDAO {	// Data Access Object
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = null;
	
	// 회원 가입
	public void insertMember(MemberDTO dto) {
		try {
			conn = OracleConnection.getConn();
			sql = " insert into member values(?,?,?,?,?,?,?,sysdate) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getBirth());
			pstmt.setString(5, dto.getPhone1());
			pstmt.setString(6, dto.getPhone2());
			pstmt.setString(7, dto.getGender());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			OracleConnection.close(conn, pstmt, rs);
		}
	}
	
	// id 중복 확인
	public boolean confirmId(String id) {
		boolean result = false;
		try {
			conn = OracleConnection.getConn();
			sql = "select * from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(conn, pstmt, rs);
		}
		return result;
	}
	
	// 전체 회원 정보
	public List<MemberDTO> allMember() {
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		
		try {
			conn = OracleConnection.getConn();
			sql = "select * from member";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setName(rs.getString("name"));
				dto.setBirth(rs.getString("birth"));
				dto.setPhone1(rs.getString("phone1"));
				dto.setPhone2(rs.getString("phone2"));
				dto.setGender(rs.getString("gender"));
				dto.setReg(rs.getTimestamp("reg"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(conn, pstmt, rs);
		}
		return list;
	}
	
	// 회원 탈퇴
	public int deleteMember(MemberDTO dto) {
		int result = 0;
		try {
			conn = OracleConnection.getConn();
			sql = "delete from member where id=? and pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(conn, pstmt, rs);
		}
		return result;
	}
	
	// 로그인 id, pw 확인
	public boolean loginCheck(MemberDTO dto) {
		boolean result = false;
		try {
			conn = OracleConnection.getConn();
			sql = " select id from member where id=? and pw=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(conn, pstmt, rs);
		}
		return result;
	}
	
	// 내 정보 확인
	public MemberDTO idInfo(String id) {
		MemberDTO dto = new MemberDTO();
		try {
			conn = OracleConnection.getConn();
			sql = " select * from member where id=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setPw(rs.getString("pw"));
				dto.setName(rs.getString("name"));
				dto.setBirth(rs.getString("birth"));
				dto.setPhone1(rs.getString("phone1"));
				dto.setPhone2(rs.getString("phone2"));
				dto.setGender(rs.getString("gender"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(conn, pstmt, rs);
		}
		return dto;
	}
	
	// 회원 정보 수정
	public void updateMember(MemberDTO dto) {
		try {
			conn = OracleConnection.getConn();
			sql = "update member set pw=?, name=?, phone1=?, phone2=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPw());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getPhone1());
			pstmt.setString(4, dto.getPhone2());
			pstmt.setString(5, dto.getId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(conn, pstmt, rs);
		}
	}	
}