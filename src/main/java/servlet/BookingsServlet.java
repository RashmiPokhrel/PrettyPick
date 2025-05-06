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

@WebServlet("/user-bookings")
public class BookingsServlet extends HttpServlet {

    private BookingDAO bookingDAO;
    private ServiceDAO serviceDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        try {
            bookingDAO = new BookingDAO();
            serviceDAO = new ServiceDAO();
            userDAO = new UserDAO();
            System.out.println("BookingsServlet initialized successfully");
        } catch (Exception e) {
            throw new ServletException("Failed to initialize BookingsServlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
                response.sendRedirect("login.jsp?error=Please log in to view your bookings");
                return;
            }

            // Get user details
            user user = userDAO.getUserByEmail(userEmail);
            if (user == null) {
                response.sendRedirect("login.jsp?error=User not found");
                return;
            }

            // Get bookings for the user
            List<Object[]> bookings = bookingDAO.getDetailedBookingsByUserId(user.getUserId());
            request.setAttribute("bookings", bookings);

            // Forward to the my-bookings JSP
            request.getRequestDispatcher("my-bookings.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("cancel".equals(action)) {
                cancelBooking(request, response);
            } else if ("update".equals(action)) {
                updateBooking(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    private void cancelBooking(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String bookingIdStr = request.getParameter("bookingId");

        if (bookingIdStr != null) {
            int bookingId = Integer.parseInt(bookingIdStr);
            boolean success = bookingDAO.updateBookingStatus(bookingId, "Cancelled");

            if (success) {
                response.sendRedirect("user-bookings?cancelled=true");
            } else {
                response.sendRedirect("user-bookings?error=Failed to cancel booking");
            }
        } else {
            response.sendRedirect("user-bookings?error=Invalid booking ID");
        }
    }

    private void updateBooking(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String bookingIdStr = request.getParameter("bookingId");
        String date = request.getParameter("date");
        String time = request.getParameter("time");

        if (bookingIdStr != null && date != null && time != null) {
            int bookingId = Integer.parseInt(bookingIdStr);
            boolean success = bookingDAO.updateBookingDateTime(bookingId, date, time);

            if (success) {
                response.sendRedirect("user-bookings?updated=true");
            } else {
                response.sendRedirect("user-bookings?error=Failed to update booking");
            }
        } else {
            response.sendRedirect("user-bookings?error=Missing required parameters");
        }
    }
}
