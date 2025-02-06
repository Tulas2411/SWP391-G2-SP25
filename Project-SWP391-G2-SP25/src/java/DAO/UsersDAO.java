package DAO;

/**
 *
 * @author Tùng Dương
 */
import Model.Users;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UsersDAO {

    private Connection conn;

    public UsersDAO() {
        conn = DBContext.makeConnection();
    }

    public List<Users> getAllUsers() {
        List<Users> users = new ArrayList<>();
        try {
            String query = "SELECT * FROM Users";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                users.add(new Users(
                        rs.getInt("UserID"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Gender"),
                        rs.getString("DateOfBirth"),
                        rs.getString("UserName"),
                        rs.getString("Password"),
                        rs.getString("Role"),
                        rs.getString("Email"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Address")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    public Users getUserById(int id) {
        try {
            String query = "SELECT * FROM Users WHERE UserID = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Users(
                        rs.getInt("UserID"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Gender"),
                        rs.getString("DateOfBirth"),
                        rs.getString("UserName"),
                        rs.getString("Password"),
                        rs.getString("Role"),
                        rs.getString("Email"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Address")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addUser(Users user) {
        try {
            String query = "INSERT INTO Users (FirstName, LastName, Gender, DateOfBirth, UserName, Password, Role, Email, PhoneNumber, Address) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getGender());
            ps.setString(4, user.getDateOfBirth());
            ps.setString(5, user.getUserName());
            ps.setString(6, user.getPassword());
            ps.setString(7, user.getRole());
            ps.setString(8, user.getEmail());
            ps.setString(9, user.getPhoneNumber());
            ps.setString(10, user.getAddress());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateUser(Users user) {
        try {
            String query = "UPDATE Users SET FirstName = ?, LastName = ?, Gender = ?, DateOfBirth = ?, UserName = ?, Password = ?, Role = ?, Email = ?, PhoneNumber = ?, Address = ? WHERE UserID = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getGender());
            ps.setString(4, user.getDateOfBirth());
            ps.setString(5, user.getUserName());
            ps.setString(6, user.getPassword());
            ps.setString(7, user.getRole());
            ps.setString(8, user.getEmail());
            ps.setString(9, user.getPhoneNumber());
            ps.setString(10, user.getAddress());
            ps.setInt(11, user.getUserID());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean removeUser(int id) {
        try {
            String query = "DELETE FROM Users WHERE UserID = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        UsersDAO dao = new UsersDAO();
        System.out.println(dao.getUserById(1));
    }
}
