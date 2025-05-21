package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import util.AddAdminUser;

/**
 * Servlet to add a specific admin user with email admin@gmail.com and password admin@123.
 * This servlet can be accessed at /add-admin-user to create the admin user.
 */
@WebServlet("/add-admin-user")
public class AddAdminUserServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html");
        
        try {
            // Check if the user already exists
            if (AddAdminUser.userExists("admin@gmail.com")) {
                response.getWriter().println("<h2>Admin user with email admin@gmail.com already exists.</h2>");
                response.getWriter().println("<p>You can <a href='login'>login here</a> with:</p>");
                response.getWriter().println("<p>Email: admin@gmail.com</p>");
                response.getWriter().println("<p>Password: admin@123</p>");
                return;
            }
            
            // Add the admin user
            boolean success = AddAdminUser.addAdminUser();
            
            if (success) {
                response.getWriter().println("<h2>Admin user added successfully!</h2>");
                response.getWriter().println("<p>You can now <a href='login'>login</a> with:</p>");
                response.getWriter().println("<p>Email: admin@gmail.com</p>");
                response.getWriter().println("<p>Password: admin@123</p>");
            } else {
                response.getWriter().println("<h2>Failed to add admin user.</h2>");
                response.getWriter().println("<p>Please check the server logs for more information.</p>");
            }
        } catch (SQLException e) {
            response.getWriter().println("<h2>Database error: " + e.getMessage() + "</h2>");
            e.printStackTrace();
        }
    }
}
