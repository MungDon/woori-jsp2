package web.bean.board01;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

// DBConnection 상속 사용!
public class Board01DAO extends DBConnection {
	// 사용 객체 변수 미리 선언
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;
	
	// 글 작성
	public int insert(Board01DTO dto) {
		int result = 0;
		try {
			conn = getConn();
			sql = " insert into board01 values(board01_seq.NEXTVAL, ?, ?, ?, sysdate) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	// 글 개수
	public int count() {
		int result = 0;
		
		try {
			conn = getConn();
			sql = " select count(*) from board01 ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if( rs.next() ) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	// 글 목록
	public ArrayList<Board01DTO> list(int start, int end){
		ArrayList<Board01DTO> list = new ArrayList<Board01DTO>();
		try {
			conn = getConn();
			sql = "select * from (select b.*, rownum r from (select * from board01 order by num desc) b) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				Board01DTO dto = new Board01DTO();
				dto.setNum(rs.getInt("num"));
				dto.setTitle(rs.getString("title"));
				dto.setWriter(rs.getString("writer"));
				dto.setReg(rs.getTimestamp("reg"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn,pstmt,rs);
		}
		return list;
	}
	
	// 글 내용
	public Board01DTO content(int num) {
		Board01DTO dto = new Board01DTO();
		try {
			conn = getConn();
			sql = " select * from board01 where num=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setReg(rs.getTimestamp("reg"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return dto;
	}
	
	// 글 수정 Form
	public Board01DTO updateForm(int num) {
		Board01DTO dto = new Board01DTO();
		try {
			conn = getConn();
			sql = " select * from board01 where num=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return dto;
	}
	// 글 수정 Pro
	public int updatePro(Board01DTO dto) {
		int result = 0;
		try {
			conn = getConn();
			sql = " update board01 set writer=?, title=?, content=? where num=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setInt(4, dto.getNum());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	// 글 삭제
	public int delete(int num) {
		int result = 0;
		try {
			conn = getConn();
			sql = " delete from board01 where num=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
}
















