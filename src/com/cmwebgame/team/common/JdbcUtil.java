package com.cmwebgame.team.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JdbcUtil {

	// 连接属性(测试机)
	private static final String DRIVERCLASS = "com.mysql.jdbc.Driver";
	private static final String URL = "jdbc:mysql://gamedb:3306/blog?useUnicode=true&characterEncoding=utf8&mysqlEncoding=utf8&zeroDateTimeBehavior=convertToNull";
	private static final String USERNAME = "wilson";
	private static final String PASSWORD = "=-098][poi";
//	private static final String DRIVERCLASS = "com.mysql.jdbc.Driver";
//	private static final String URL = "jdbc:mysql://localhost:3306/teamblog?useUnicode=true&characterEncoding=utf8&mysqlEncoding=utf8&zeroDateTimeBehavior=convertToNull";
//	private static final String USERNAME = "root";
//	private static final String PASSWORD = "root";

	public static Connection getConnection() {
		//
		Connection conn = null;
		try {
			Class.forName(DRIVERCLASS);
			conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public static void close(Connection conn,PreparedStatement pstmt,ResultSet rs){
		try {
			if (rs != null){
				rs.close();
			}
			if (pstmt != null){
				pstmt.close();
			}
			if (conn != null){
				conn.close();
			}
		} catch (Exception e){
			e.printStackTrace();
		}
	}
}
