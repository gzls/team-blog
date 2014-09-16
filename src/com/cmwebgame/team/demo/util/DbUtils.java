package com.cmwebgame.team.demo.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.cmwebgame.team.demo.User;

import com.cmwebgame.team.demo.tx.TxHolder;

public class DbUtils {
	
	static{
		try {
			initDb();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
    public static Connection getConnection() throws SQLException {
    	return DriverManager.getConnection("jdbc:mysql://localhost:3306/cg", "root", "root");
    }

    private static long nextId;

    public static long nextId() {
        nextId++;
        return nextId;
    }

    public static void initDb() throws SQLException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        }
        catch(ClassNotFoundException e) {
            throw new NoClassDefFoundError("com.mysql.jdbc.Driver");
        }
        Connection conn = getConnection();
        execute(conn, "drop table if exists user");
        execute(conn, "create table user (id bigint primary key, name varchar(50) not null, createtime datetime)");
        execute(conn, "insert into user (id, name, createtime) values(?, ?, ?)", 1, "test", new Timestamp(System.currentTimeMillis()));
        conn.close();
    }

    static void execute(Connection conn, String sql, Object... args) throws SQLException {
        PreparedStatement ps = conn.prepareStatement(sql);
        for (int i=0; i<args.length; i++) {
            Object o = args[i];
            ps.setObject(i+1, o);
        }
        ps.executeUpdate();
        ps.close();
    }

    public static List<User> queryForList(String sql, Object... args) throws Exception {
        Connection conn = TxHolder.getCurrentConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<User> list = new ArrayList<User>();
        try {
            ps = conn.prepareStatement(sql);
            bindParameters(ps, args);
            rs = ps.executeQuery();
            while (rs.next()) {
            	User user = new User(rs.getLong("id"), rs.getString("name"),rs.getTimestamp("createtime"));
                list.add(user);
            }
            return list;
        }
        finally {
            close(rs);
            close(ps);
        }
    }

    public static int executeUpdate(String sql, Object... args) throws Exception {
        Connection conn = TxHolder.getCurrentConnection();
        PreparedStatement ps = null;
        try {
            ps = conn.prepareStatement(sql);
            bindParameters(ps, args);
            return ps.executeUpdate();
        }
        finally {
            close(ps);
        }
    }

    static void bindParameters(PreparedStatement ps, Object... args) throws Exception {
        for (int i=0; i<args.length; i++) {
            ps.setObject(i+1, args[i]);
        }
    }

    static void close(PreparedStatement ps) {
        if (ps!=null) {
            try {
                ps.close();
            }
            catch (SQLException e) {}
        }
    }

    static void close(ResultSet rs) {
        if (rs!=null) {
            try {
                rs.close();
            }
            catch (SQLException e) {}
        }
    }
}
