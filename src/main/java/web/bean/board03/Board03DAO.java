package web.bean.board03;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Board03DAO {

	private static Board03DAO instance = new Board03DAO();

	public static Board03DAO getInstance() {
		return instance;
	}

	private Board03DAO() {
	};

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;

	private Connection getConn() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
		String user = "scott";
		String pw = "tiger";

		Connection conn = DriverManager.getConnection(dburl, user, pw);
		return conn;
	}

	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if (pstmt != null) {
				pstmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} // 각각 끊어주지 않으면 서로 영향을 끼칠 수있기에 예외를 각각처리함
			// 연결을 끊지 않으면 메모리 누수 발생
	}

	/* 전체 게시글 수 */
	public int imgCount() {
		int result = 0;
		try {
			conn = getConn();
			sql = "select count(*) from board03";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt("count(*)");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}

	/* 이미지 삽입 */
	public int imgInsert(Board03DTO dto) {
		int result = 0;
		try {
			conn = getConn();
			sql = "insert into board03 values(board03_seq.nextval, ?, ?, sysdate)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getImg());

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}

	/* 게시글 목록 */
	public ArrayList<Board03DTO> imgList(int start, int end) {
		ArrayList<Board03DTO> list = new ArrayList<Board03DTO>();
		try {
			conn = getConn();
			sql = "select * from(select b.*, rownum as r from(select * from board03 order by num desc)b) where r between ? and ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, start);
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				Board03DTO dto = new Board03DTO();
				dto.setNum(rs.getInt("num"));
				dto.setTitle(rs.getString("title"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setImg(rs.getString("img"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	/*게시글 상세보기*/
	public Board03DTO content(int num) {
		Board03DTO dto = new Board03DTO();
		try {
			conn = getConn();
			sql = "select * from board03 where num = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setTitle(rs.getString("title"));
				dto.setImg(rs.getString("img"));
				dto.setReg(rs.getTimestamp("reg"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return dto;
	}
	/*게시글 수정*/
	public int imgUpdate(Board03DTO dto) {
		int result = 0;
		try {
			conn = getConn();
			sql= "update board03 set title = ?, img = ? where num = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getImg());
			pstmt.setInt(3, dto.getNum());
			
			result =  pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	/*게시글 삭제*/
	public int imgDelete(int num) {
		int result = 0;
		try {
			conn = getConn();
			sql = "delete from board03 where num = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
}
