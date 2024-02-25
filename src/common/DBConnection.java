package common;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	public static Connection getConnection() {
		String driver = "oracle.jdbc.driver.OracleDriver";
//	 	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	 	String url = "jdbc:oracle:thin:@203.245.41.49:1521:xe";
	 	String dbId = "vincenzo";
	 	String dbPw = "whddbs97chlrh";
		
		Connection conn = null;
		
		if(conn == null) {
			try {
				Class.forName(driver);
				conn = DriverManager.getConnection(url, dbId, dbPw);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return conn;
	}
}
