package dao;

import model.booking;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    // Create a new booking
    public boolean createBooking(booking booking) throws SQLException {
        String query = "INSERT INTO booking (booking_Date, booking_Time, status, notes, duration, user_id, service_Id) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, booking.getBooking_Date());
            pstmt.setString(2, booking.getBooking_Time());
            pstmt.setString(3, booking.getStatus());
            pstmt.setString(4, booking.getNotes());
            pstmt.setString(5, booking.getDuration());
            pstmt.setInt(6, booking.getUser_Id());
            pstmt.setInt(7, booking.getService_Id());

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        booking.setBooking_Id(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        }
    }

    // Get booking by ID
    public booking getBookingById(int bookingId) throws SQLException {
        String query = "SELECT * FROM booking WHERE booking_Id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, bookingId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new booking(
                        rs.getInt("booking_Id"),
                        rs.getString("booking_Date"),
                        rs.getString("booking_Time"),
                        rs.getString("status"),
                        rs.getString("notes"),
                        rs.getString("duration"),
                        rs.getInt("user_id"),
                        rs.getInt("service_Id")
                    );
                }
                return null;
            }
        }
    }

    // Get all bookings
    public List<booking> getAllBookings() throws SQLException {
        List<booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM booking ORDER BY booking_Date DESC, booking_Time DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                booking booking = new booking(
                    rs.getInt("booking_Id"),
                    rs.getString("booking_Date"),
                    rs.getString("booking_Time"),
                    rs.getString("status"),
                    rs.getString("notes"),
                    rs.getString("duration"),
                    rs.getInt("user_id"),
                    rs.getInt("service_Id")
                );
                bookings.add(booking);
            }
        }
        return bookings;
    }

    // Get bookings by user ID
    public List<booking> getBookingsByUserId(int userId) throws SQLException {
        List<booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM booking WHERE user_id = ? ORDER BY booking_Date DESC, booking_Time DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    booking booking = new booking(
                        rs.getInt("booking_Id"),
                        rs.getString("booking_Date"),
                        rs.getString("booking_Time"),
                        rs.getString("status"),
                        rs.getString("notes"),
                        rs.getString("duration"),
                        rs.getInt("user_id"),
                        rs.getInt("service_Id")
                    );
                    bookings.add(booking);
                }
            }
        }
        return bookings;
    }

    // Get bookings by status
    public List<booking> getBookingsByStatus(String status) throws SQLException {
        List<booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM booking WHERE status = ? ORDER BY booking_Date, booking_Time";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, status);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    booking booking = new booking(
                        rs.getInt("booking_Id"),
                        rs.getString("booking_Date"),
                        rs.getString("booking_Time"),
                        rs.getString("status"),
                        rs.getString("notes"),
                        rs.getString("duration"),
                        rs.getInt("user_id"),
                        rs.getInt("service_Id")
                    );
                    bookings.add(booking);
                }
            }
        }
        return bookings;
    }

    // Update booking status
    public boolean updateBookingStatus(int bookingId, String status) throws SQLException {
        String query = "UPDATE booking SET status = ? WHERE booking_Id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, status);
            pstmt.setInt(2, bookingId);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Update booking date and time
    public boolean updateBookingDateTime(int bookingId, String date, String time) throws SQLException {
        String query = "UPDATE booking SET booking_Date = ?, booking_Time = ? WHERE booking_Id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, date);
            pstmt.setString(2, time);
            pstmt.setInt(3, bookingId);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Update booking details
    public boolean updateBooking(booking booking) throws SQLException {
        String query = "UPDATE booking SET booking_Date = ?, booking_Time = ?, status = ?, notes = ?, duration = ?, user_id = ?, service_Id = ? WHERE booking_Id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, booking.getBooking_Date());
            pstmt.setString(2, booking.getBooking_Time());
            pstmt.setString(3, booking.getStatus());
            pstmt.setString(4, booking.getNotes());
            pstmt.setString(5, booking.getDuration());
            pstmt.setInt(6, booking.getUser_Id());
            pstmt.setInt(7, booking.getService_Id());
            pstmt.setInt(8, booking.getBooking_Id());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Delete booking
    public boolean deleteBooking(int bookingId) throws SQLException {
        String query = "DELETE FROM booking WHERE booking_Id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, bookingId);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Get count of bookings by status
    public int getBookingCountByStatus(String status) throws SQLException {
        String query = "SELECT COUNT(*) FROM booking WHERE status = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, status);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
                return 0;
            }
        }
    }

    // Get detailed bookings with user and service information
    public List<Object[]> getDetailedBookings() throws SQLException {
        List<Object[]> detailedBookings = new ArrayList<>();
        String query = "SELECT b.*, u.name as user_name, u.email as user_email, u.phone as user_phone, " +
                      "s.service_Name, s.price, s.duration " +
                      "FROM booking b " +
                      "JOIN user u ON b.user_id = u.userId " +
                      "JOIN service s ON b.service_Id = s.service_Id " +
                      "ORDER BY b.booking_Date DESC, b.booking_Time DESC";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Object[] bookingDetails = new Object[11];
                bookingDetails[0] = rs.getInt("booking_Id");
                bookingDetails[1] = rs.getString("booking_Date");
                bookingDetails[2] = rs.getString("booking_Time");
                bookingDetails[3] = rs.getString("status");
                bookingDetails[4] = rs.getString("notes");
                bookingDetails[5] = rs.getInt("user_id");
                bookingDetails[6] = rs.getString("user_name");
                bookingDetails[7] = rs.getString("user_email");
                bookingDetails[8] = rs.getString("user_phone");
                bookingDetails[9] = rs.getString("service_Name");
                bookingDetails[10] = rs.getString("duration");

                detailedBookings.add(bookingDetails);
            }
        }

        return detailedBookings;
    }

    // Get detailed bookings for a specific user
    public List<Object[]> getDetailedBookingsByUserId(int userId) throws SQLException {
        List<Object[]> detailedBookings = new ArrayList<>();
        String query = "SELECT b.*, s.service_Name, s.price, s.duration " +
                      "FROM booking b " +
                      "JOIN service s ON b.service_Id = s.service_Id " +
                      "WHERE b.user_id = ? " +
                      "ORDER BY b.booking_Date DESC, b.booking_Time DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Object[] bookingDetails = new Object[8];
                    bookingDetails[0] = rs.getInt("booking_Id");
                    bookingDetails[1] = rs.getString("booking_Date");
                    bookingDetails[2] = rs.getString("booking_Time");
                    bookingDetails[3] = rs.getString("status");
                    bookingDetails[4] = rs.getString("service_Name");
                    bookingDetails[5] = rs.getDouble("price");
                    bookingDetails[6] = rs.getString("duration");
                    bookingDetails[7] = rs.getString("notes");

                    detailedBookings.add(bookingDetails);
                }
            }
        }

        return detailedBookings;
    }

    // Get detailed booking information by ID
    public Object[] getDetailedBookingById(int bookingId) throws SQLException {
        String query = "SELECT b.*, s.service_Name, s.price, s.duration, u.name as user_name, u.email as user_email " +
                      "FROM booking b " +
                      "JOIN service s ON b.service_Id = s.service_Id " +
                      "JOIN user u ON b.user_id = u.userId " +
                      "WHERE b.booking_Id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, bookingId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Object[] bookingDetails = new Object[11];
                    bookingDetails[0] = rs.getInt("booking_Id");
                    bookingDetails[1] = rs.getString("booking_Date");
                    bookingDetails[2] = rs.getString("booking_Time");
                    bookingDetails[3] = rs.getString("status");
                    bookingDetails[4] = rs.getString("service_Name");
                    bookingDetails[5] = rs.getDouble("price");
                    bookingDetails[6] = rs.getString("duration");
                    bookingDetails[7] = rs.getString("notes");
                    bookingDetails[8] = rs.getInt("user_Id");
                    bookingDetails[9] = rs.getString("user_name");
                    bookingDetails[10] = rs.getString("user_email");

                    return bookingDetails;
                }
                return null;
            }
        }
    }
}
