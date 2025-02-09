package DAO;

import Model.Users;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

public class UsersDAO extends DBContext {

    public Map<Integer, Users> getAllUsers() {
        Map<Integer, Users> userList = new HashMap<>();
        String sql = "SELECT * FROM Users";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Users user = extractUserFromResultSet(rs);
                userList.put(user.getUserID(), user);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching users: " + e.getMessage());
        }
        return userList;
    }

    public Vector<Users> getAllUsersAsVector() {
        Vector<Users> users = new Vector<>();
        String sql = "SELECT * FROM Users";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                users.add(extractUserFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching users as vector: " + e.getMessage());
        }
        return users;
    }

    public Users getUserByID(int id) {
        String sql = "SELECT * FROM Users WHERE UserID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractUserFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching user by ID: " + e.getMessage());
        }
        return null;
    }

    public boolean addUser(Users user) {
        String sql = "INSERT INTO Users (FirstName, LastName, Gender, DateOfBirth, UserName, Password, Role, Email, PhoneNumber, Address) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setUserPreparedStatement(ps, user);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error adding user: " + e.getMessage());
            return false;
        }
    }

    public boolean updateUser(Users user) {
        String sql = "UPDATE Users SET FirstName = ?, LastName = ?, Gender = ?, DateOfBirth = ?, UserName = ?, Password = ?, Role = ?, Email = ?, PhoneNumber = ?, Address = ? WHERE UserID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setUserPreparedStatement(ps, user);
            ps.setInt(11, user.getUserID());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error updating user: " + e.getMessage());
            return false;
        }
    }

    public boolean removeUser(int id) {
        String sql = "DELETE FROM Users WHERE UserID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error removing user: " + e.getMessage());
            return false;
        }
    }

    private Users extractUserFromResultSet(ResultSet rs) throws SQLException {
        Users user = new Users();
        user.setUserID(rs.getInt("UserID"));
        user.setFirstName(rs.getString("FirstName"));
        user.setLastName(rs.getString("LastName"));
        user.setGender(rs.getString("Gender"));
        user.setDateOfBirth(rs.getString("DateOfBirth"));
        user.setUserName(rs.getString("UserName"));
        user.setPassword(rs.getString("Password"));
        user.setRole(rs.getString("Role"));
        user.setEmail(rs.getString("Email"));
        user.setPhoneNumber(rs.getString("PhoneNumber"));
        user.setAddress(rs.getString("Address"));
        return user;
    }

    private void setUserPreparedStatement(PreparedStatement ps, Users user) throws SQLException {
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
    }
}
