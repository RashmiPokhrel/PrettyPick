package servlet;

import dao.BookingDAO;
import dao.FeedbackDAO;
import dao.ServiceDAO;
import dao.UserDAO;
import model.booking;
import model.feedback;
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

@WebServlet(urlPatterns = {"/feedback", "/feedbacks", "/feedback/*"})
public class FeedbackServlet extends HttpServlet {

    private FeedbackDAO feedbackDAO;
    private BookingDAO bookingDAO;
    private UserDAO userDAO;
    private ServiceDAO serviceDAO;

    @Override
    public void init() throws ServletException {
        try {
            feedbackDAO = new FeedbackDAO();
            bookingDAO = new BookingDAO();
            userDAO = new UserDAO();
            serviceDAO = new ServiceDAO();
            System.out.println("FeedbackServlet initialized successfully");
        } catch (Exception e) {
            throw new ServletException("Failed to initialize FeedbackServlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        String servletPath = request.getServletPath();

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

            // If path is /feedback/{id}, show specific feedback
            if (pathInfo != null && pathInfo.length() > 1 && servletPath.equals("/feedback")) {
                int feedbackId = Integer.parseInt(pathInfo.substring(1));
                feedback feedback = feedbackDAO.getFeedbackById(feedbackId);

                if (feedback != null) {
                    request.setAttribute("feedback", feedback);
                    request.getRequestDispatcher("/feedback-detail.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Feedback not found");
                }
            }
            // If path is /feedbacks, show all feedbacks (admin) or user's feedbacks (user)
            else if (servletPath.equals("/feedbacks")) {
                if (userEmail != null) {
                    try {
                        user user = userDAO.getUserByEmail(userEmail);
                        if (user != null) {
                            if ("admin".equals(userRole)) {
                                // Admin sees all feedback
                                List<Object[]> allFeedback = feedbackDAO.getDetailedFeedback();
                                request.setAttribute("feedbacks", allFeedback);
                                request.setAttribute("isAdmin", true);
                            } else {
                                // User sees only their feedback
                                List<feedback> userFeedback = feedbackDAO.getFeedbackByUserId(user.getUser_id());
                                request.setAttribute("feedbacks", userFeedback);
                                request.setAttribute("isAdmin", false);
                            }
                            request.getRequestDispatcher("/feedbacks.jsp").forward(request, response);
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
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid feedback ID");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
                response.sendRedirect("login.jsp");
                return;
            }
            
            // Get user ID from email
            user user = userDAO.getUserByEmail(userEmail);
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            // Get form parameters
            String bookingIdStr = request.getParameter("bookingId");
            String ratingStr = request.getParameter("rating");
            String comments = request.getParameter("comments");
            
            if (bookingIdStr == null || bookingIdStr.trim().isEmpty() || 
                ratingStr == null || ratingStr.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Booking ID and rating are required.");
                request.getRequestDispatcher("bookings.jsp").forward(request, response);
                return;
            }
            
            int bookingId = Integer.parseInt(bookingIdStr);
            int rating = Integer.parseInt(ratingStr);
            
            // Get booking details to get service ID
            booking booking = bookingDAO.getBookingById(bookingId);
            if (booking == null) {
                request.setAttribute("errorMessage", "Booking not found.");
                request.getRequestDispatcher("bookings.jsp").forward(request, response);
                return;
            }
            
            // Create feedback object
            feedback newFeedback = new feedback(0, rating, comments, null, user.getUser_id(), booking.getService_Id());
            
            // Save to database
            boolean success = feedbackDAO.createFeedback(newFeedback);
            
            if (success) {
                // Redirect with success message
                response.sendRedirect("bookings?feedback=success");
            } else {
                request.setAttribute("errorMessage", "Failed to submit feedback. Please try again.");
                request.getRequestDispatcher("bookings.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid rating or booking ID.");
            request.getRequestDispatcher("bookings.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String pathInfo = request.getPathInfo();
            
            if (pathInfo != null && pathInfo.length() > 1) {
                int feedbackId = Integer.parseInt(pathInfo.substring(1));
                
                boolean success = feedbackDAO.deleteFeedback(feedbackId);
                
                if (success) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("Feedback deleted successfully");
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("Feedback not found or could not be deleted");
                }
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Feedback ID is required");
            }
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Database error: " + e.getMessage());
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid feedback ID");
        }
    }
}
