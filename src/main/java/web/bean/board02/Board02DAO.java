package web.bean.board02;

// 1단계 임포트
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

// getInstance() 사용!
public class Board02DAO {
	private static Board02DAO instance = new Board02DAO();	
	public static Board02DAO getInstance() { return instance; }// 싱글톤으로 객체 하나만 생성해서 쓰기위해 이렇게 작성
	private Board02DAO() {}// 기본생성자를 private -> 다른곳에서 new 로 생성불가능
	
	// 사용 객체 변수 미리 선언
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;

	// 2단계 드라이버 로딩
	private Connection getConn() throws Exception {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");		
			String dburl= "jdbc:oracle:thin:@localhost:1521:orcl";
			String user	= "scott";
			String pw	= "tiger";
			conn = DriverManager.getConnection(dburl,user,pw);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	// 6단계 연결 끊기
	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try{ if(conn != null) { conn.close(); } }catch(SQLException e) { e.printStackTrace(); }
		try{ if(pstmt != null) { pstmt.close(); } }catch(SQLException e) { e.printStackTrace(); }
		try{ if(rs != null) { rs.close(); } }catch(SQLException e) { e.printStackTrace(); }
	}
	
	
	// 글 작성
	public int boardInsert(Board02DTO dto) {
		int result = 0;

		int num = dto.getNum();				// 글번호
		int ref = dto.getRef();					//그룹번호
		int re_step = dto.getRe_step();	//답글 번호
		int re_level= dto.getRe_level();	//답글 레벨 (새글,답글,대답글)
		int number	= 0;							// 새로운 그룹번호
		try {
			conn = getConn();

			sql = "select max(num) from board02";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) { 							// max(num) 값이 있다면 = 이전에 쓴글이있다면
				number = rs.getInt(1)+1;	// max(num)으로 가장 큰 글번호 = 가장 마지막 글번호에 +1해서 number 에 저장(새로운 그룹번호 =(ref))
			}else {										// max(num) 값이 없다면 number 에 1 저장 / ref = 1;
				number = 1;
			}
			if (num != 0) { //글번호가 0 이아님 -> 글이있다 - > 답글일경우 (답글작성누르면 파라미터로 값을 넘겨받은것이 dto 에 set됨)
				sql="update board02 set re_step=re_step+1 where ref= ? and re_step > ?"; // 파라미터로 넘겨받은 글번호 그룹과 스텝으로 조건을 걸음 
				pstmt = conn.prepareStatement(sql);																// 만약 ref 가 1 re_step이 0일경우 답글 입력시 맨상위인 step 이 1이된다.
				pstmt.setInt(1, ref);																							//간단히 말하면 답글들어오는 위치에따라서 그위치에 맞는 번호를 자기자신이 가지고 
				pstmt.setInt(2, re_step);																					//그아래(더큰번호)의 step 번호를 증가시킨다
				pstmt.executeUpdate();
				re_step	= re_step+1;	// 업데이트 구문 실행후 step 과 level 에 1식 더하여 저장 
				re_level= re_level+1;	// 예) 첫답글일경우 step1 level 1 이되는것
			}else{	// 답글이아닌 새글일 경우
				ref		= number;// 위에 if 문에 따라 1이 저장될수도있고(number = 1;) 이미 글이있다면 새로운 그룹번호가 저장된다 (number = rs.getInt(1)+1;)
				re_step	= 0;	// 새글(게시글) 이기 때문에 스텝과 레벨은 당연히 0 이다.
				re_level= 0;
			}
 
			sql = "insert into board02(num, writer, title, content, passwd, ref, re_step, re_level, reg) values(board02_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getWriter());//~
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());// 폼에서 받은 입력값
			pstmt.setInt(5, ref);//~~
			pstmt.setInt(6, re_step);
			pstmt.setInt(7, re_level);// 파라미터로 넘겨받은것들이  위에 코드들실행후 나온 결과값들을 insert 함 

			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt,rs);
		}
		return result;
	}

	// 글 개수
	public int boardCount() {
		int result = 0;
		try {
			conn = getConn();
			pstmt = conn.prepareStatement("select count(*) from board02");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1); 
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result; 
	}
	
	// 글 목록
	public ArrayList<Board02DTO> boardList(int start, int end){// 페이지의 게시글 시작번호화 끝번호를 매개변수로 받음
		ArrayList<Board02DTO> list = new ArrayList<Board02DTO>(end);// end 의 값만큼 메모리용량 설정
		try {
			conn = getConn();

			sql = "select * from (select b.* , rownum r from (select * from board02 order by ref desc, re_step asc ) b) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start); 
			pstmt.setInt(2, end); 

			rs = pstmt.executeQuery();
			if (rs.next()) {
				do{ 
					Board02DTO dto = new Board02DTO();
					dto.setNum(rs.getInt("num"));
					dto.setWriter(rs.getString("writer"));
					dto.setTitle(rs.getString("title"));
					dto.setContent(rs.getString("content"));
					dto.setPasswd(rs.getString("passwd"));
					dto.setReadCount(rs.getInt("readCount"));
					dto.setRef(rs.getInt("ref"));
					dto.setRe_step(rs.getInt("re_step"));
					dto.setRe_level(rs.getInt("re_level"));
					dto.setReg(rs.getTimestamp("reg"));
					list.add(dto); 
				}while(rs.next());
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	/*유저가 쓴 게시글 카운트*/
	public int MyBoardCount(String sid) {
		int result = 0;
		try {
			conn = getConn();
			sql ="select count(*) from board02 where writer = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, sid);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt("count(*)");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	/*유저가 쓴 게시글 목록*/
	public ArrayList<Board02DTO> MyBoardList(int start, int end, String sid){
		ArrayList<Board02DTO> list = new ArrayList<Board02DTO>();
		try {
			conn = getConn();
			sql = "select * from(select a.*, rownum as r from(select * from board02 where writer = ? order by ref desc, re_step asc)a) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, sid);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Board02DTO dto = new Board02DTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setReadCount(rs.getInt("readCount"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
				dto.setReg(rs.getTimestamp("reg"));
				list.add(dto); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	// 글 내용(+조회수)
	public Board02DTO readContent(int num) {
		Board02DTO dto = new Board02DTO();
		try {
			conn = getConn();
			sql = "update board02 set readcount=readcount+1 where num=?";// 상세보기 들어올때마다 구문실행 되어서 조회수 올라감
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			sql = "select * from board02 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setReadCount(rs.getInt("readCount"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_step(rs.getInt("re_step"));	
				dto.setRe_level(rs.getInt("re_level"));
				dto.setReg(rs.getTimestamp("reg"));
			}		
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return dto;
	}
	
	// 글 수정Form
	public Board02DTO boardUpForm(int num) {
		Board02DTO dto = new Board02DTO();
		try {
			conn = getConn();
			sql = " select * from board02 where num=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setReadCount(rs.getInt("readCount"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
				dto.setReg(rs.getTimestamp("reg"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return dto;
	}
	
	// 글 수정Pro
	public int boardUpPro(Board02DTO dto) {
		int result = 0;
		String dbpw = "";
		try {
			conn = getConn();
			pstmt = conn.prepareStatement("select passwd from board02 where num = ?");// 글 수정시 패스워드 검사
			pstmt.setInt(1, dto.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()){
				dbpw = rs.getString("passwd");
				if(dbpw.equals(dto.getPasswd())) {
					sql = " update board02 set writer=?, title=?, content=?, passwd=?  where num=? ";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, dto.getWriter());
					pstmt.setString(2, dto.getTitle());
					pstmt.setString(3, dto.getContent());
					pstmt.setString(4, dto.getPasswd());
					pstmt.setInt(5, dto.getNum());
					result = pstmt.executeUpdate();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	// 글 삭제 
	public int boardDelete(int num, String passwd) {
		int result = 0;
		String dbpw = "";
		try {
			conn = getConn();
			pstmt = conn.prepareStatement("select passwd from board02 where num=?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				dbpw= rs.getString("passwd");
				if(dbpw.equals(passwd)){
					sql = "delete from board02 where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					result = pstmt.executeUpdate();
				}
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}

}