package servlet;

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
import java.util.logging.Logger;
import java.util.regex.Pattern;

@WebServlet("/signup")
public class Sign_upServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(Sign_upServlet.class.getName());
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

        request.getRequestDispatcher("signup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role");
        String terms = request.getParameter("terms");

        LOGGER.info("Processing signup request for email: " + email);

        // Validate required fields
        if (name == null || name.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                confirmPassword == null || confirmPassword.trim().isEmpty()) {
            LOGGER.warning("Signup validation failed: Required fields missing");
            request.setAttribute("errorMessage", "Name, email, and password are required.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        // Validate terms agreement
        if (terms == null) {
            LOGGER.warning("Signup validation failed: Terms not accepted");
            request.setAttribute("errorMessage", "You must agree to the terms and conditions.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        // Validate email format
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        if (!Pattern.matches(emailRegex, email)) {
            LOGGER.warning("Signup validation failed: Invalid email format");
            request.setAttribute("errorMessage", "Please enter a valid email address.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        // Validate password length
        if (password.length() < 6) {
            LOGGER.warning("Signup validation failed: Password too short");
            request.setAttribute("errorMessage", "Password must be at least 6 characters long.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        // Validate password match
        if (!password.equals(confirmPassword)) {
            LOGGER.warning("Signup validation failed: Passwords don't match");
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        // Validate role (prevent role injection)
        if (role == null || (!role.equals("user") && !role.equals("admin"))) {
            LOGGER.warning("Signup validation failed: Invalid role");
            role = "user"; // Default to user role for security
        }

        // Create user object
        user user = new user();
        user.setName(name);
        user.setEmail(email);
        user.setPhone(phone != null && !phone.trim().isEmpty() ? phone : null);
        user.setPassword(password);
        user.setRole(role);

        try {
            // Check if email already exists
            user existingUser = userDAO.getUserByEmail(email);
            if (existingUser != null) {
                LOGGER.warning("Signup failed: Email already exists: " + email);
                request.setAttribute("errorMessage", "Email address is already registered. Please use a different email or login.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }

            // Register the user
            boolean isRegistered = userDAO.registerUser(user);
            if (isRegistered) {
                LOGGER.info("User registered successfully: " + email);
                // Set a success message as a request attribute
                request.setAttribute("successMessage", "Registration successful! Please login with your credentials.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                LOGGER.warning("Registration failed for email: " + email);
                request.setAttribute("errorMessage", "Registration failed. Please try again.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            LOGGER.severe("SQLException during registration: " + e.getMessage());
            if (e.getMessage().contains("Email already exists")) {
                request.setAttribute("errorMessage", "Email address is already registered. Please use a different email or login.");
            } else {
                request.setAttribute("errorMessage", "Registration error: " + e.getMessage());
            }
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.severe("Unexpected error during registration: " + e.getMessage());
            request.setAttribute("errorMessage", "An unexpected error occurred. Please try again later.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    }
}