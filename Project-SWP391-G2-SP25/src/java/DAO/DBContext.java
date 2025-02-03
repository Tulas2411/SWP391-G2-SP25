package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {
    public static Connection makeConnection() {
		Connection conn = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/EcommerceDB", "root", "1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

    public static void main(String[] args) {
		System.out.println(makeConnection());
	}
}
