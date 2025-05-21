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

            // Get section parameter to determine which tab to show
            String section = request.getParameter("section");

            // Get filter parameters
            String statusFilter = request.getParameter("statusFilter");
            String searchQuery = request.getParameter("searchQuery");
            String dateFilter = request.getParameter("dateFilter");

            // Get dashboard data for bookings
            int pendingCount = bookingDAO.getBookingCountByStatus("Pending");
            int confirmedCount = bookingDAO.getBookingCountByStatus("Confirmed");
            int cancelledCount = bookingDAO.getBookingCountByStatus("Cancelled");
            int completedCount = bookingDAO.getBookingCountByStatus("Completed");

            // Get all bookings with details
            List<Object[]> bookings = bookingDAO.getDetailedBookings();

            // Get dashboard data for appointments
            int pendingAppointments = appointmentDAO.getAppointmentCountByStatus("Pending");
            int confirmedAppointments = appointmentDAO.getAppointmentCountByStatus("Confirmed");
            int rejectedAppointments = appointmentDAO.getAppointmentCountByStatus("Rejected");
            int completedAppointments = appointmentDAO.getAppointmentCountByStatus("Completed");

            // Get appointments with details (filtered if parameters are provided)
            List<Object[]> appointments;
            if (statusFilter != null && !statusFilter.isEmpty() && dateFilter != null && !dateFilter.isEmpty()) {
                // Filter by both status and date
                appointments = appointmentDAO.getDetailedAppointmentsByStatusAndDate(statusFilter, dateFilter);
            } else if (statusFilter != null && !statusFilter.isEmpty()) {
                // Filter by status only
                appointments = appointmentDAO.getDetailedAppointmentsByStatus(statusFilter);
            } else if (dateFilter != null && !dateFilter.isEmpty()) {
                // Filter by date only
                appointments = appointmentDAO.getDetailedAppointmentsByDate(dateFilter);
            } else {
                // No filters
                appointments = appointmentDAO.getDetailedAppointments();
            }

            // Get all services
            List<service> services = serviceDAO.getAllServices();

            // Get all users (filtered if search query is provided)
            List<user> users;
            if (searchQuery != null && !searchQuery.isEmpty()) {
                users = userDAO.searchUsers(searchQuery);
            } else {
                users = userDAO.getAllUsers();
            }

            // Set attributes for the dashboard
            request.setAttribute("pendingCount", pendingCount);
            request.setAttribute("confirmedCount", confirmedCount);
            request.setAttribute("cancelledCount", cancelledCount);
            request.setAttribute("completedCount", completedCount);
            request.setAttribute("bookings", bookings);

            request.setAttribute("pendingAppointments", pendingAppointments);
            request.setAttribute("confirmedAppointments", confirmedAppointments);
            request.setAttribute("rejectedAppointments", rejectedAppointments);
            request.setAttribute("completedAppointments", completedAppointments);
            request.setAttribute("appointments", appointments);
            request.setAttribute("statusFilter", statusFilter);

            request.setAttribute("services", services);
            request.setAttribute("users", users);
            request.setAttribute("searchQuery", searchQuery);
            request.setAttribute("dateFilter", dateFilter);

            // Set the active section based on the section parameter
            if (section != null && !section.isEmpty()) {
                request.setAttribute("activeSection", section);
            } else {
                request.setAttribute("activeSection", "dashboard");
            }

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
            } else if ("updateAppointmentStatus".equals(action)) {
                updateAppointmentStatus(request, response);
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
            } else if ("searchUsers".equals(action)) {
                searchUsers(request, response);
            } else if ("filterAppointments".equals(action)) {
                filterAppointments(request, response);
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
        String section = request.getParameter("section");

        if (bookingIdStr != null && status != null) {
            int bookingId = Integer.parseInt(bookingIdStr);
            boolean success = bookingDAO.updateBookingStatus(bookingId, status);

            String redirectUrl = "admin-dashboard";
            if (section != null && !section.isEmpty()) {
                redirectUrl += "?section=" + section;
                redirectUrl += "&statusUpdated=" + (success ? "true" : "false");
            } else {
                redirectUrl += "?statusUpdated=" + (success ? "true" : "false");
            }

            response.sendRedirect(redirectUrl);
        } else {
            String redirectUrl = "admin-dashboard";
            if (section != null && !section.isEmpty()) {
                redirectUrl += "?section=" + section + "&statusUpdated=false";
            } else {
                redirectUrl += "?statusUpdated=false";
            }

            response.sendRedirect(redirectUrl);
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

    private void updateAppointmentStatus(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String appointmentIdStr = request.getParameter("appointmentId");
        String status = request.getParameter("status");
        String section = request.getParameter("section");

        if (appointmentIdStr != null && status != null) {
            int appointmentId = Integer.parseInt(appointmentIdStr);
            boolean success = appointmentDAO.updateAppointmentStatus(appointmentId, status);

            String redirectUrl = "admin-dashboard";
            if (section != null && !section.isEmpty()) {
                redirectUrl += "?section=" + section;
                redirectUrl += "&appointmentUpdated=" + (success ? "true" : "false");
            } else {
                redirectUrl += "?appointmentUpdated=" + (success ? "true" : "false");
            }

            response.sendRedirect(redirectUrl);
        } else {
            String redirectUrl = "admin-dashboard";
            if (section != null && !section.isEmpty()) {
                redirectUrl += "?section=" + section + "&appointmentUpdated=false";
            } else {
                redirectUrl += "?appointmentUpdated=false";
            }

            response.sendRedirect(redirectUrl);
        }
    }

    private void searchUsers(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String searchQuery = request.getParameter("searchQuery");
        String section = request.getParameter("section");

        String redirectUrl = "admin-dashboard";
        if (section != null && !section.isEmpty()) {
            redirectUrl += "?section=" + section;
            if (searchQuery != null && !searchQuery.isEmpty()) {
                redirectUrl += "&searchQuery=" + searchQuery;
            }
        } else if (searchQuery != null && !searchQuery.isEmpty()) {
            redirectUrl += "?searchQuery=" + searchQuery;
        }

        response.sendRedirect(redirectUrl);
    }

    private void filterAppointments(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String statusFilter = request.getParameter("statusFilter");
        String dateFilter = request.getParameter("dateFilter");
        String section = request.getParameter("section");

        StringBuilder redirectUrl = new StringBuilder("admin-dashboard?");

        if (section != null && !section.isEmpty()) {
            redirectUrl.append("section=").append(section);

            if (statusFilter != null && !statusFilter.isEmpty()) {
                redirectUrl.append("&statusFilter=").append(statusFilter);
            }

            if (dateFilter != null && !dateFilter.isEmpty()) {
                redirectUrl.append("&dateFilter=").append(dateFilter);
            }
        } else {
            boolean hasParam = false;

            if (statusFilter != null && !statusFilter.isEmpty()) {
                redirectUrl.append("statusFilter=").append(statusFilter);
                hasParam = true;
            }

            if (dateFilter != null && !dateFilter.isEmpty()) {
                if (hasParam) {
                    redirectUrl.append("&dateFilter=").append(dateFilter);
                } else {
                    redirectUrl.append("dateFilter=").append(dateFilter);
                }
            }
        }

        // Log the filter parameters for debugging
        System.out.println("Filtering appointments - Status: " + statusFilter + ", Date: " + dateFilter);

        response.sendRedirect(redirectUrl.toString());
    }
}
