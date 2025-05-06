package servlet;

import dao.AppointmentDAO;
import dao.BookingDAO;
import dao.ServiceDAO;
import dao.UserDAO;
import model.service;
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

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private BookingDAO bookingDAO;
    private ServiceDAO serviceDAO;
    private UserDAO userDAO;
    private AppointmentDAO appointmentDAO;

    @Override
    public void init() throws ServletException {
        try {
            bookingDAO = new BookingDAO();
            serviceDAO = new ServiceDAO();
            userDAO = new UserDAO();
            appointmentDAO = new AppointmentDAO();
            System.out.println("AdminDashboardServlet initialized successfully");
        } catch (Exception e) {
            throw new ServletException("Failed to initialize AdminDashboardServlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get user information from cookies
            String userEmail = null;
            String userRole = null;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("userEmail".equals(cookie.getName())) {
                        userEmail = cookie.getValue();
                    } else if ("userRole".equals(cookie.getName())) {
                        userRole = cookie.getValue();
                    }
                }
            }

            // Verify admin role
            if (userEmail == null || !"admin".equals(userRole)) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Get dashboard data
            int pendingCount = bookingDAO.getBookingCountByStatus("Pending");
            int confirmedCount = bookingDAO.getBookingCountByStatus("Confirmed");
            int cancelledCount = bookingDAO.getBookingCountByStatus("Cancelled");
            int completedCount = bookingDAO.getBookingCountByStatus("Completed");

            // Get all bookings with details
            List<Object[]> bookings = bookingDAO.getDetailedBookings();

            // Get all services
            List<service> services = serviceDAO.getAllServices();

            // Get all users
            List<user> users = userDAO.getAllUsers();

            // Set attributes for the dashboard
            request.setAttribute("pendingCount", pendingCount);
            request.setAttribute("confirmedCount", confirmedCount);
            request.setAttribute("cancelledCount", cancelledCount);
            request.setAttribute("completedCount", completedCount);
            request.setAttribute("bookings", bookings);
            request.setAttribute("services", services);
            request.setAttribute("users", users);

            // Forward to the dashboard JSP
            request.getRequestDispatcher("AdminDashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("updateBookingStatus".equals(action)) {
                updateBookingStatus(request, response);
            } else if ("addService".equals(action)) {
                addService(request, response);
            } else if ("updateService".equals(action)) {
                updateService(request, response);
            } else if ("deleteService".equals(action)) {
                deleteService(request, response);
            } else if ("addUser".equals(action)) {
                addUser(request, response);
            } else if ("updateUser".equals(action)) {
                updateUser(request, response);
            } else if ("deleteUser".equals(action)) {
                deleteUser(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    private void updateBookingStatus(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String bookingIdStr = request.getParameter("bookingId");
        String status = request.getParameter("status");

        if (bookingIdStr != null && status != null) {
            int bookingId = Integer.parseInt(bookingIdStr);
            boolean success = bookingDAO.updateBookingStatus(bookingId, status);

            if (success) {
                response.sendRedirect("admin-dashboard?statusUpdated=true");
            } else {
                response.sendRedirect("admin-dashboard?statusUpdated=false");
            }
        } else {
            response.sendRedirect("admin-dashboard?statusUpdated=false");
        }
    }

    private void addService(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String serviceName = request.getParameter("serviceName");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String duration = request.getParameter("duration");
        String status = request.getParameter("status");

        if (serviceName != null && description != null && priceStr != null && duration != null && status != null) {
            double price = Double.parseDouble(priceStr);

            service newService = new service(0, serviceName, description, price, duration, status);
            boolean success = serviceDAO.addService(newService);

            if (success) {
                response.sendRedirect("admin-dashboard?serviceAdded=true");
            } else {
                response.sendRedirect("admin-dashboard?serviceAdded=false");
            }
        } else {
            response.sendRedirect("admin-dashboard?serviceAdded=false");
        }
    }

    private void updateService(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String serviceIdStr = request.getParameter("serviceId");
        String serviceName = request.getParameter("serviceName");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String duration = request.getParameter("duration");
        String status = request.getParameter("status");

        if (serviceIdStr != null && serviceName != null && description != null && priceStr != null && duration != null && status != null) {
            int serviceId = Integer.parseInt(serviceIdStr);
            double price = Double.parseDouble(priceStr);

            service updatedService = new service(serviceId, serviceName, description, price, duration, status);
            boolean success = serviceDAO.updateService(updatedService);

            if (success) {
                response.sendRedirect("admin-dashboard?serviceUpdated=true");
            } else {
                response.sendRedirect("admin-dashboard?serviceUpdated=false");
            }
        } else {
            response.sendRedirect("admin-dashboard?serviceUpdated=false");
        }
    }

    private void deleteService(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String serviceIdStr = request.getParameter("serviceId");

        if (serviceIdStr != null) {
            int serviceId = Integer.parseInt(serviceIdStr);
            boolean success = serviceDAO.deleteService(serviceId);

            if (success) {
                response.sendRedirect("admin-dashboard?serviceDeleted=true");
            } else {
                response.sendRedirect("admin-dashboard?serviceDeleted=false");
            }
        } else {
            response.sendRedirect("admin-dashboard?serviceDeleted=false");
        }
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (name != null && email != null && password != null && role != null) {
            // Create a new user object
            user newUser = new user();
            newUser.setName(name);
            newUser.setEmail(email);
            newUser.setPhone(phone != null ? phone : "");
            newUser.setPassword(password); // Set the password in the user object
            newUser.setRole(role);

            // Register the user (this method handles password hashing)
            boolean success = userDAO.registerUser(newUser);

            if (success) {
                response.sendRedirect("admin-dashboard?userAdded=true");
            } else {
                response.sendRedirect("admin-dashboard?userAdded=false");
            }
        } else {
            response.sendRedirect("admin-dashboard?userAdded=false");
        }
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String userIdStr = request.getParameter("userId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");
        String password = request.getParameter("password");

        if (userIdStr != null && name != null && email != null && role != null) {
            int userId = Integer.parseInt(userIdStr);

            // Get the existing user
            user existingUser = userDAO.getUserById(userId);
            if (existingUser == null) {
                response.sendRedirect("admin-dashboard?userUpdated=false");
                return;
            }

            // Update user details
            existingUser.setName(name);
            existingUser.setEmail(email);
            existingUser.setPhone(phone != null ? phone : "");
            existingUser.setRole(role);

            // Update user in database
            boolean success = userDAO.updateUser(existingUser);

            // If password is provided, update it separately
            if (password != null && !password.trim().isEmpty()) {
                success = success && userDAO.updateUserPassword(userId, password);
            }

            if (success) {
                response.sendRedirect("admin-dashboard?userUpdated=true");
            } else {
                response.sendRedirect("admin-dashboard?userUpdated=false");
            }
        } else {
            response.sendRedirect("admin-dashboard?userUpdated=false");
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String userIdStr = request.getParameter("userId");

        if (userIdStr != null) {
            int userId = Integer.parseInt(userIdStr);
            boolean success = userDAO.deleteUser(userId);

            if (success) {
                response.sendRedirect("admin-dashboard?userDeleted=true");
            } else {
                response.sendRedirect("admin-dashboard?userDeleted=false");
            }
        } else {
            response.sendRedirect("admin-dashboard?userDeleted=false");
        }
    }
}
