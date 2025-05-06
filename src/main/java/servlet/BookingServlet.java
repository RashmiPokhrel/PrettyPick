package servlet;

import dao.BookingDAO;
import dao.ServiceDAO;
import dao.UserDAO;
import model.booking;
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

@WebServlet(urlPatterns = {"/book", "/bookings", "/booking/*"})
public class BookingServlet extends HttpServlet {

    private BookingDAO bookingDAO;
    private ServiceDAO serviceDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        try {
            bookingDAO = new BookingDAO();
            serviceDAO = new ServiceDAO();
            userDAO = new UserDAO();
            System.out.println("BookingServlet initialized successfully");
        } catch (Exception e) {
            throw new ServletException("Failed to initialize BookingServlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        String servletPath = request.getServletPath();

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

            // If path is /booking/{id}, show specific booking
            if (pathInfo != null && pathInfo.length() > 1 && servletPath.equals("/booking")) {
                int bookingId = Integer.parseInt(pathInfo.substring(1));
                booking booking = bookingDAO.getBookingById(bookingId);

                if (booking != null) {
                    // Get service details
                    service service = serviceDAO.getServiceById(booking.getService_Id());
                    request.setAttribute("booking", booking);
                    request.setAttribute("service", service);
                    request.getRequestDispatcher("/booking-detail.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Booking not found");
                }
            }
            // If path is /bookings, show all bookings for the user
            else if (servletPath.equals("/bookings")) {
                if (userEmail != null) {
                    try {
                        user user = userDAO.getUserByEmail(userEmail);
                        if (user != null) {
                            List<Object[]> userBookings = bookingDAO.getDetailedBookingsByUserId(user.getUserId());
                            request.setAttribute("bookings", userBookings);
                            request.getRequestDispatcher("/bookings.jsp").forward(request, response);
                        } else {
                            response.sendRedirect("login.jsp");
                        }
                    } catch (SQLException e) {
                        throw new ServletException("Database error", e);
                    }
                } else {
                    response.sendRedirect("login.jsp");
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid booking ID");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        // Default action is to create a new booking
        if (action == null || action.equals("create")) {
            createBooking(request, response);
        } else if (action.equals("update")) {
            updateBooking(request, response);
        } else if (action.equals("cancel")) {
            cancelBooking(request, response);
        }
    }

    private void createBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

            if (userEmail == null) {
                response.sendRedirect("login.jsp?redirect=service.jsp");
                return;
            }

            // Get user ID from email
            user user = userDAO.getUserByEmail(userEmail);
            if (user == null) {
                response.sendRedirect("login.jsp?redirect=service.jsp");
                return;
            }

            // Get form parameters
            String date = request.getParameter("date");
            String time = request.getParameter("time");
            String notes = request.getParameter("notes");
            String serviceIdStr = request.getParameter("service");

            if (date == null || date.trim().isEmpty() ||
                time == null || time.trim().isEmpty() ||
                serviceIdStr == null || serviceIdStr.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Date, time, and service are required.");
                request.getRequestDispatcher("service.jsp").forward(request, response);
                return;
            }

            int serviceId = Integer.parseInt(serviceIdStr);

            // Get service details
            service service = serviceDAO.getServiceById(serviceId);
            if (service == null) {
                request.setAttribute("errorMessage", "Service not found.");
                request.getRequestDispatcher("service.jsp").forward(request, response);
                return;
            }

            // Create booking object
            booking newBooking = new booking();
            newBooking.setBooking_Date(date);
            newBooking.setBooking_Time(time);
            newBooking.setStatus("Pending");
            newBooking.setNotes(notes);
            newBooking.setDuration(service.getDuration());
            newBooking.setUser_Id(user.getUserId());
            newBooking.setService_Id(serviceId);

            // Save to database
            boolean success = bookingDAO.createBooking(newBooking);

            if (success) {
                // Redirect with success message
                response.sendRedirect("services?booking=success");
            } else {
                request.setAttribute("errorMessage", "Failed to create booking. Please try again.");
                request.getRequestDispatcher("service.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid service selected.");
            request.getRequestDispatcher("service.jsp").forward(request, response);
        }
    }

    private void updateBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String bookingIdStr = request.getParameter("bookingId");
            String date = request.getParameter("date");
            String time = request.getParameter("time");
            String notes = request.getParameter("notes");

            if (bookingIdStr == null || bookingIdStr.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Booking ID is required");
                return;
            }

            int bookingId = Integer.parseInt(bookingIdStr);
            booking existingBooking = bookingDAO.getBookingById(bookingId);

            if (existingBooking == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Booking not found");
                return;
            }

            // Update booking details
            if (date != null && !date.trim().isEmpty()) {
                existingBooking.setBooking_Date(date);
            }

            if (time != null && !time.trim().isEmpty()) {
                existingBooking.setBooking_Time(time);
            }

            if (notes != null) {
                existingBooking.setNotes(notes);
            }

            boolean success = bookingDAO.updateBooking(existingBooking);

            if (success) {
                response.sendRedirect("user-bookings?updated=true");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update booking");
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid booking ID");
        }
    }

    private void cancelBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String bookingIdStr = request.getParameter("bookingId");

            if (bookingIdStr == null || bookingIdStr.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Booking ID is required");
                return;
            }

            int bookingId = Integer.parseInt(bookingIdStr);
            boolean success = bookingDAO.updateBookingStatus(bookingId, "Cancelled");

            if (success) {
                response.sendRedirect("user-bookings?cancelled=true");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to cancel booking");
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid booking ID");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String pathInfo = request.getPathInfo();

            if (pathInfo != null && pathInfo.length() > 1) {
                int bookingId = Integer.parseInt(pathInfo.substring(1));

                boolean success = bookingDAO.deleteBooking(bookingId);

                if (success) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("Booking deleted successfully");
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("Booking not found or could not be deleted");
                }
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Booking ID is required");
            }
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Database error: " + e.getMessage());
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid booking ID");
        }
    }
}