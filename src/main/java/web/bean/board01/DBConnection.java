package web.bean.board01;

// 1단계 임포트
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

	public Connection getConn() throws Exception{
		// 2단계 드라이브 로딩(실행)
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
		String user = "scott";
		String pass = "tiger";
		Connection conn = DriverManager.getConnection(dburl,user,pass);
		return conn;
	}
	
	public void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try{ if(conn != null) { conn.close(); } }catch(SQLException e) { e.printStackTrace(); }
		try{ if(pstmt != null) { pstmt.close(); } }catch(SQLException e) {}
		try{ if(rs != null) { rs.close(); } }catch(SQLException e) {}
	}
}