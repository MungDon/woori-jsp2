package web.bean.member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class OracleConnection {
	
	public static Connection getConn() throws Exception{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String url ="jdbc:oracle:thin:@localhost:1521:orcl";
		String user = "scott", pass = "tiger";
		Connection conn = DriverManager.getConnection(url, user, pass);
		return conn; 
	}
	
	public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		if(conn != null) { try { conn.close(); }catch(SQLException s) {} }
		if(pstmt != null) {try { pstmt.close(); }catch(SQLException s) {} }
		if(rs != null) { try { rs.close(); }catch(SQLException s) {} }
	}
}





