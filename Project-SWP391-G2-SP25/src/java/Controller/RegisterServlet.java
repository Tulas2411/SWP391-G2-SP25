package Controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Connection;

/**
 *
 * @author luuth
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String FirstName = request.getParameter("firstname");
        String LastName = request.getParameter("lastname");
        String UserName = request.getParameter("username");
        String Gender = request.getParameter("gender");
        String DateOfBirth = request.getParameter("DateOfBirth");
        String Email = request.getParameter("email");
        String Password = request.getParameter("password");
        String PhoneNumber = request.getParameter("contact");
        String Address = request.getParameter("address");
        RequestDispatcher dispatcher = null;
        Connection con = null;

        try {
            con = makeConnection(); // Use the makeConnection method for connection
            PreparedStatement pst = con.prepareStatement("insert into Users(FirstName, LastName, UserName, Gender, DateOfBirth, Email, Password, Role, PhoneNumber, Address) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ");
            pst.setString(1, FirstName);
            pst.setString(2, LastName);
            pst.setString(3, UserName);
            pst.setString(4, Gender);
            pst.setString(5, DateOfBirth);
            pst.setString(6, Email);
            pst.setString(7, Password);
            pst.setString(8, "Customer");
            pst.setString(9, PhoneNumber);
            pst.setString(10, Address);
            
            int rowCount = pst.executeUpdate();
            dispatcher = request.getRequestDispatcher("Register.jsp");
                    
            if(rowCount > 0){
                request.setAttribute("status", "success");
                
            } else {
                request.setAttribute("status", "failed");
            }
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.close();  // Properly close connection
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    // Moved connection logic into the reusable method makeConnection
    public static Connection makeConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/EcommerceDB", "root", "1234");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

}