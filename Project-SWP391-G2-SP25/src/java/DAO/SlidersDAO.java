package DAO;

import Model.Sliders;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.lang.model.util.Types;

/**
 * DAO class for managing Sliders
 */
public class SlidersDAO extends DBContext {

    // Lấy tất cả sliders
    public List<Sliders> getAllSliders() {
        List<Sliders> list = new ArrayList<>();
        String sql = "SELECT * FROM Sliders";
        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Sliders slider = new Sliders();
                slider.setSliderID(rs.getInt("SliderID"));
                slider.setTitle(rs.getString("Title"));
                slider.setImage(rs.getString("Image"));
                slider.setBacklink(rs.getString("Backlink"));
                slider.setStatus(rs.getString("Status"));
                slider.setBlogID(rs.getInt("BlogID"));
                slider.setProductID(rs.getInt("ProductID"));

                list.add(slider);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Sliders> searchSliders(String search, String status) {
        List<Sliders> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Sliders WHERE 1=1");

        // Nếu có tiêu chí tìm kiếm theo title hoặc backlink
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (Title LIKE ? OR Backlink LIKE ?)");
        }

        // Nếu có tiêu chí tìm kiếm theo status
        if (status != null && !status.isEmpty()) {
            sql.append(" AND Status = ?");
        }

        try (// Lấy kết nối từ DBContext
                PreparedStatement ps = connection.prepareStatement(sql.toString())) {

            int paramIndex = 1;

            // Thêm tham số tìm kiếm theo title hoặc backlink
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + search + "%");
                ps.setString(paramIndex++, "%" + search + "%");
            }

            // Thêm tham số tìm kiếm theo status
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }

            try (ResultSet rs = ps.executeQuery()) {
                // Duyệt qua các kết quả và thêm vào danh sách
                while (rs.next()) {
                    Sliders slider = new Sliders();
                    slider.setSliderID(rs.getInt("SliderID"));
                    slider.setTitle(rs.getString("Title"));
                    slider.setImage(rs.getString("Image"));
                    slider.setBacklink(rs.getString("Backlink"));
                    slider.setStatus(rs.getString("Status"));
                    slider.setBlogID(rs.getInt("BlogID"));
                    slider.setProductID(rs.getInt("ProductID"));

                    list.add(slider);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int countSliders(String search, String status) {
        int count = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Sliders WHERE 1=1");

        // Thêm điều kiện tìm kiếm
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (Title LIKE ? OR Backlink LIKE ?)");
        }

        if (status != null && !status.isEmpty()) {
            sql.append(" AND Status = ?");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;

            // Thêm tham số tìm kiếm
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + search + "%");
                ps.setString(paramIndex++, "%" + search + "%");
            }

            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public List<Sliders> getSlidersByPage(String search, String status, int page, int pageSize) {
        List<Sliders> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Sliders WHERE 1=1");

        // Thêm điều kiện tìm kiếm
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (Title LIKE ? OR Backlink LIKE ?)");
        }

        if (status != null && !status.isEmpty()) {
            sql.append(" AND Status = ?");
        }

        // Phân trang: dùng LIMIT và OFFSET
        sql.append(" LIMIT ? OFFSET ?");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;

            // Thêm tham số tìm kiếm
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + search + "%");
                ps.setString(paramIndex++, "%" + search + "%");
            }

            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }

            // Thêm tham số phân trang
            ps.setInt(paramIndex++, pageSize);
            ps.setInt(paramIndex++, (page - 1) * pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Sliders slider = new Sliders();
                    slider.setSliderID(rs.getInt("SliderID"));
                    slider.setTitle(rs.getString("Title"));
                    slider.setImage(rs.getString("Image"));
                    slider.setBacklink(rs.getString("Backlink"));
                    slider.setStatus(rs.getString("Status"));
                    slider.setBlogID(rs.getInt("BlogID"));
                    slider.setProductID(rs.getInt("ProductID"));
                    list.add(slider);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Lấy slider theo ID
    public Sliders getSliderById(int id) {
        String sql = "SELECT * FROM Sliders WHERE SliderID = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
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
            }
        } catch (Exception e) {
            System.out.println("getSliderById: " + e.getMessage());
        }
        return null;
    }
    public void addSlider(Sliders slider) {
    String sql = "INSERT INTO Sliders (Title, Image, Backlink, Status, BlogID, ProductID) VALUES (?, ?, ?, ?, ?, ?)";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, slider.getTitle());
        ps.setString(2, slider.getImage());
        ps.setString(3, slider.getBacklink());
        ps.setString(4, slider.getStatus());

        // Nếu BlogID hoặc ProductID <= 0 thì đặt NULL
        ps.setObject(5, (slider.getBlogID() > 0) ? slider.getBlogID() : null);
        ps.setObject(6, (slider.getProductID() > 0) ? slider.getProductID() : null);

        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

    // Thêm slider mới
//    public boolean insertSlider(Sliders slider) {
//        String sql = "INSERT INTO Sliders (Title, Image, Backlink, Status, BlogID, ProductID) VALUES (?, ?, ?, ?, ?, ?)";
//        try (PreparedStatement stm = connection.prepareStatement(sql)) {
//            stm.setString(1, slider.getTitle());
//            stm.setString(2, slider.getImage());
//            stm.setString(3, slider.getBacklink());
//            stm.setString(4, slider.getStatus());
//            if (slider.getBlogID() != null) {
//                stm.setInt(5, slider.getBlogID());
//            } else {
//                stm.setNull(5, java.sql.Types.INTEGER);
//            }
//            if (slider.getProductID() != null) {
//                stm.setInt(6, slider.getProductID());
//            } else {
//                stm.setNull(6, java.sql.Types.INTEGER);
//            }
//
//            return stm.executeUpdate() > 0;
//        } catch (Exception e) {
//            System.out.println("insertSlider: " + e.getMessage());
//        }
//        return false;
//    }
    public int updateSlider(Sliders slider) {
        String sql = "UPDATE Sliders SET Title = ?, Image = ?, Backlink = ?, Status = ? WHERE SliderID = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, slider.getTitle());      // Cập nhật title
            stm.setString(2, slider.getImage());      // Cập nhật image (URL mới)
            stm.setString(3, slider.getBacklink());  // Cập nhật backlink
            stm.setString(4, slider.getStatus());    // Cập nhật status
            stm.setInt(5, slider.getSliderID());     // Điều kiện WHERE SliderID = ?

            return stm.executeUpdate();  // Trả về số dòng bị ảnh hưởng
        } catch (Exception e) {
            System.out.println("updateSlider: " + e.getMessage());  // In ra lỗi nếu có
        }
        return 0;  // Nếu không có dòng nào được cập nhật, trả về 0
    }

    // Xóa slider theo ID
    public boolean deleteSlider(int id) {
        String sql = "DELETE FROM Sliders WHERE SliderID = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);
            return stm.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("deleteSlider: " + e.getMessage());
        }
        return false;
    }
}
