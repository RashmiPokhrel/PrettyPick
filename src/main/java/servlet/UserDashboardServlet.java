package servlet;

import dao.BookingDAO;
import dao.ServiceDAO;
import dao.UserDAO;
import model.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/user-dashboard")
public class UserDashboardServlet extends HttpServlet {

    private BookingDAO bookingDAO;
    private ServiceDAO serviceDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        try {
            bookingDAO = new BookingDAO();
            serviceDAO = new ServiceDAO();
            userDAO = new UserDAO();
            System.out.println("UserDashboardServlet initialized successfully");
        } catch (Exception e) {
            throw new ServletException("Failed to initialize UserDashboardServlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        loadDashboard(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("updateProfile".equals(action)) {
                updateProfile(request, response);
            } else if ("updatePassword".equals(action)) {
                updatePassword(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    private void loadDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get user information from cookies
            String userEmail = null;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("userEmail".equals(cookie.getName())) {
                        userEmail = cookie.getValue();
                        break;
                    }
                }
            }

            // Verify user is logged in
            if (userEmail == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Get user details
            user user = userDAO.getUserByEmail(userEmail);
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Get upcoming bookings for the user
            List<Object[]> upcomingBookings = bookingDAO.getDetailedBookingsByUserId(user.getUserId());
            request.setAttribute("upcomingBookings", upcomingBookings);

            // Set user object in request for profile display
            request.setAttribute("user", user);

            // Forward to the dashboard JSP
            request.getRequestDispatcher("UserDashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        // Get user information from cookies
        String userEmail = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("userEmail".equals(cookie.getName())) {
                    userEmail = cookie.getValue();
                    break;
                }
            }
        }

        // Verify user is logged in
        if (userEmail == null) {
            response.sendRedirect("login.jsp?error=Please log in to update your profile");
            return;
        }

        // Get current user details
        user currentUser = userDAO.getUserByEmail(userEmail);
        if (currentUser == null) {
            response.sendRedirect("login.jsp?error=User not found");
            return;
        }

        // Get form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        // Validate input
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            request.setAttribute("profileError", "Name and email are required.");
            loadDashboard(request, response);
            return;
        }

        // Check if email is being changed and if it's already in use
        if (!email.equals(userEmail)) {
            user existingUser = userDAO.getUserByEmail(email);
            if (existingUser != null && existingUser.getUserId() != currentUser.getUserId()) {
                request.setAttribute("profileError", "Email is already in use by another account.");
                loadDashboard(request, response);
                return;
            }
        }

        // Update user object
        currentUser.setName(name);
        currentUser.setEmail(email);
        currentUser.setPhone(phone != null ? phone : "");

        // Update in database
        boolean success = userDAO.updateUser(currentUser);

        if (success) {
            // If email was changed, update the cookie
            if (!email.equals(userEmail)) {
                Cookie emailCookie = new Cookie("userEmail", email);
                emailCookie.setMaxAge(30 * 24 * 60 * 60); // 30 days
                emailCookie.setPath("/");
                response.addCookie(emailCookie);
            }

            // Redirect with success message
            response.sendRedirect("user-dashboard?profileUpdated=true");
        } else {
            request.setAttribute("profileError", "Failed to update profile. Please try again.");
            loadDashboard(request, response);
        }
    }

    private void updatePassword(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        // Get user information from cookies
        String userEmail = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("userEmail".equals(cookie.getName())) {
                    userEmail = cookie.getValue();
                    break;
                }
            }
        }

        // Verify user is logged in
        if (userEmail == null) {
            response.sendRedirect("login.jsp?error=Please log in to update your password");
            return;
        }

        // Get current user details
        user currentUser = userDAO.getUserByEmail(userEmail);
        if (currentUser == null) {
            response.sendRedirect("login.jsp?error=User not found");
            return;
        }

        // Get form parameters
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate input
        if (currentPassword == null || currentPassword.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            request.setAttribute("passwordError", "All password fields are required.");
            loadDashboard(request, response);
            return;
        }

        // Verify current password
        if (!userDAO.verifyPassword(currentUser.getUserId(), currentPassword)) {
            request.setAttribute("passwordError", "Current password is incorrect.");
            loadDashboard(request, response);
            return;
        }

        // Verify new passwords match
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("passwordError", "New passwords do not match.");
            loadDashboard(request, response);
            return;
        }

        // Update password in database
        boolean success = userDAO.updateUserPassword(currentUser.getUserId(), newPassword);

        if (success) {
            // Redirect with success message
            response.sendRedirect("user-dashboard?passwordUpdated=true");
        } else {
            request.setAttribute("passwordError", "Failed to update password. Please try again.");
            loadDashboard(request, response);
        }
    }
}
