package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {
    static protected Connection connection;
    
    public DBContext() {
        // Các thông tin kết nối
        String user = "root";
        String pass = "1234";
        String url = "jdbc:mysql://localhost:3306/EcommerceDB1";  // Đảm bảo URL đúng

        try {
            // Tải driver MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Kết nối đến cơ sở dữ liệu
            connection = DriverManager.getConnection(url, user, pass);
            System.out.println("Ket noi thanh cong!");
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Kết nối thất bại!");
        }
    }

    public static void main(String[] args) {
        DBContext dbContext = new DBContext();  // Khởi tạo DBContext để thử kết nối

        // Kiểm tra kết nối có thành công không
        if (connection == null) {
            System.out.println("KHong thanh cong");
        } else {
            System.out.println("Thanh cong");
        }
    }
}
