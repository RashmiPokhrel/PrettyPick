package servlet;

import dao.UserDAO;
import model.user;
import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Logger;

/**
 * Servlet for handling user login
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(LoginServlet.class.getName());

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    /**
     * Handles GET requests by forwarding to login.jsp
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.info("LoginServlet: Processing GET request");

        // Check if user is already logged in
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            String userEmail = null;
            String userRole = null;

            for (Cookie cookie : cookies) {
                if ("userEmail".equals(cookie.getName())) {
                    userEmail = cookie.getValue();
                } else if ("userRole".equals(cookie.getName())) {
                    userRole = cookie.getValue();
                }
            }

            if (userEmail != null) {
                // User is already logged in, redirect based on role
                if ("admin".equals(userRole)) {
                    response.sendRedirect("admin-dashboard");
                    return;
                } else {
                    response.sendRedirect("user-dashboard");
                    return;
                }
            }
        }

        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    /**
     * Handles POST requests for user login
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.info("LoginServlet: Processing POST request");

        // Retrieve form parameters from login.jsp
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Log the received parameters for debugging
        LOGGER.info("Received login attempt for email: " + email);

        // Basic server-side validation
        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            LOGGER.warning("Validation failed: Email or password is empty or null");
            request.setAttribute("errorMessage", "Email and password are required.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {
            // Get user by email
            user user = userDAO.getUserByEmail(email);

            if (user == null) {
                LOGGER.warning("Login failed: User not found for email: " + email);
                request.setAttribute("errorMessage", "Invalid email or password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            // Verify password
            if (BCrypt.checkpw(password, user.getPassword())) {
                LOGGER.info("User authenticated successfully: " + email);

                // Create session
                HttpSession session = request.getSession();
                session.setAttribute("userId", user.getUser_id());
                session.setAttribute("userName", user.getName());
                session.setAttribute("userEmail", user.getEmail());
                session.setAttribute("userRole", user.getRole());
                session.setMaxInactiveInterval(30 * 60); // 30 minutes timeout

                // Set cookies for convenience
                Cookie emailCookie = new Cookie("userEmail", user.getEmail());
                emailCookie.setMaxAge(30 * 60); // 30 minutes
                emailCookie.setPath("/");
                response.addCookie(emailCookie);

                Cookie roleCookie = new Cookie("userRole", user.getRole());
                roleCookie.setMaxAge(30 * 60); // 30 minutes
                roleCookie.setPath("/");
                response.addCookie(roleCookie);

                // Redirect based on role
                if ("admin".equals(user.getRole())) {
                    LOGGER.info("Redirecting admin user to admin dashboard");
                    response.sendRedirect("admin-dashboard");
                } else {
                    LOGGER.info("Redirecting regular user to user dashboard");
                    response.sendRedirect("user-dashboard");
                }
            } else {
                LOGGER.warning("Login failed: Invalid password for email: " + email);
                request.setAttribute("errorMessage", "Invalid email or password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            LOGGER.severe("SQLException during login: " + e.getMessage());
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.severe("Unexpected error in LoginServlet: " + e.getMessage());
            request.setAttribute("errorMessage", "Unexpected error: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}