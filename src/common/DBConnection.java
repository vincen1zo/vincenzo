package common;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	public static Connection getConnection() {
		String driver = "oracle.jdbc.driver.OracleDriver";
//	 	String url = "AAAA";
	 	String url = "AAA";
	 	String dbId = "vAAAAAAA";
	 	String dbPw = "AAAAAAA";
		
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
