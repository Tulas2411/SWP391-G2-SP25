package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {
    public static Connection makeConnection() {
		Connection cons = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			cons = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/EcommerceDB1", "root", "1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cons;
	}

    public static void main(String[] args) {
		System.out.println(makeConnection());
	}
}
