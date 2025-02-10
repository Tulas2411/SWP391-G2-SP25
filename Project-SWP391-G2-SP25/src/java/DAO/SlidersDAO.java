package DAO;

import Model.Sliders;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

public class SlidersDAO extends DBContext {

    public Map<Integer, Sliders> getAllSliders() {
        Map<Integer, Sliders> sliderList = new HashMap<>();
        String sql = "SELECT * FROM Sliders";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Sliders slider = extractSliderFromResultSet(rs);
                sliderList.put(slider.getSliderID(), slider);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching sliders: " + e.getMessage());
        }
        return sliderList;
    }

    public Vector<Sliders> getAllSlidersAsVector() {
        Vector<Sliders> sliders = new Vector<>();
        String sql = "SELECT * FROM Sliders";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                sliders.add(extractSliderFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching sliders as vector: " + e.getMessage());
        }
        return sliders;
    }

    public Sliders getSliderByID(int id) {
        String sql = "SELECT * FROM Sliders WHERE SliderID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractSliderFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching slider by ID: " + e.getMessage());
        }
        return null;
    }

    public boolean addSlider(Sliders slider) {
        String sql = "INSERT INTO Sliders (Title, Image, Backlink, Status, BlogID, ProductID) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setSliderPreparedStatement(ps, slider);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error adding slider: " + e.getMessage());
            return false;
        }
    }

    public boolean updateSlider(Sliders slider) {
        String sql = "UPDATE Sliders SET Title = ?, Image = ?, Backlink = ?, Status = ?, BlogID = ?, ProductID = ? WHERE SliderID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setSliderPreparedStatement(ps, slider);
            ps.setInt(7, slider.getSliderID());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error updating slider: " + e.getMessage());
            return false;
        }
    }

    public boolean removeSlider(int id) {
        String sql = "DELETE FROM Sliders WHERE SliderID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error removing slider: " + e.getMessage());
            return false;
        }
    }

    private Sliders extractSliderFromResultSet(ResultSet rs) throws SQLException {
        Sliders slider = new Sliders();
        slider.setSliderID(rs.getInt("SliderID"));
        slider.setTitle(rs.getString("Title"));
        slider.setImage(rs.getString("Image"));
        slider.setBacklink(rs.getString("Backlink"));
        slider.setStatus(rs.getString("Status"));
        slider.setBlogID(rs.getInt("BlogID"));
        slider.setProductID(rs.getInt("ProductID"));
        return slider;
    }

    private void setSliderPreparedStatement(PreparedStatement ps, Sliders slider) throws SQLException {
        ps.setString(1, slider.getTitle());
        ps.setString(2, slider.getImage());
        ps.setString(3, slider.getBacklink());
        ps.setString(4, slider.getStatus());
        ps.setInt(5, slider.getBlogID());
        ps.setInt(6, slider.getProductID());
    }
}
