package dao;

import model.appointment;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

    // Create a new appointment
    public boolean createAppointment(appointment appointment) throws SQLException {
        String query = "INSERT INTO appointment (appointment_Date, appointment_Time, appointment_Status, user_Id, service_Id) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, appointment.getAppointment_Date());
            pstmt.setString(2, appointment.getAppointment_Time());
            pstmt.setString(3, appointment.getAppointment_Status());
            pstmt.setInt(4, appointment.getUser_Id());
            pstmt.setInt(5, appointment.getService_Id());

            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        appointment.setAppointment_Id(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        }
    }

    // Get appointment by ID
    public appointment getAppointmentById(int appointmentId) throws SQLException {
        String query = "SELECT * FROM appointment WHERE appointment_Id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, appointmentId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new appointment(
                        rs.getInt("appointment_Id"),
                        rs.getString("appointment_Date"),
                        rs.getString("appointment_Time"),
                        rs.getString("appointment_Status"),
                        rs.getInt("user_Id"),
                        rs.getInt("service_Id")
                    );
                }
                return null;
            }
        }
    }

    // Get all appointments
    public List<appointment> getAllAppointments() throws SQLException {
        List<appointment> appointments = new ArrayList<>();
        String query = "SELECT * FROM appointment ORDER BY appointment_Date DESC, appointment_Time DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                appointment appointment = new appointment(
                    rs.getInt("appointment_Id"),
                    rs.getString("appointment_Date"),
                    rs.getString("appointment_Time"),
                    rs.getString("appointment_Status"),
                    rs.getInt("user_Id"),
                    rs.getInt("service_Id")
                );
                appointments.add(appointment);
            }
        }
        return appointments;
    }

    // Get appointments by user ID
    public List<appointment> getAppointmentsByUserId(int userId) throws SQLException {
        List<appointment> appointments = new ArrayList<>();
        String query = "SELECT * FROM appointment WHERE user_Id = ? ORDER BY appointment_Date DESC, appointment_Time DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    appointment appointment = new appointment(
                        rs.getInt("appointment_Id"),
                        rs.getString("appointment_Date"),
                        rs.getString("appointment_Time"),
                        rs.getString("appointment_Status"),
                        rs.getInt("user_Id"),
                        rs.getInt("service_Id")
                    );
                    appointments.add(appointment);
                }
            }
        }
        return appointments;
    }

    // Get appointments by status
    public List<appointment> getAppointmentsByStatus(String status) throws SQLException {
        List<appointment> appointments = new ArrayList<>();
        String query = "SELECT * FROM appointment WHERE appointment_Status = ? ORDER BY appointment_Date, appointment_Time";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, status);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    appointment appointment = new appointment(
                        rs.getInt("appointment_Id"),
                        rs.getString("appointment_Date"),
                        rs.getString("appointment_Time"),
                        rs.getString("appointment_Status"),
                        rs.getInt("user_Id"),
                        rs.getInt("service_Id")
                    );
                    appointments.add(appointment);
                }
            }
        }
        return appointments;
    }

    // Update appointment status
    public boolean updateAppointmentStatus(int appointmentId, String status) throws SQLException {
        String query = "UPDATE appointment SET appointment_Status = ? WHERE appointment_Id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, status);
            pstmt.setInt(2, appointmentId);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Update appointment details
    public boolean updateAppointment(appointment appointment) throws SQLException {
        String query = "UPDATE appointment SET appointment_Date = ?, appointment_Time = ?, appointment_Status = ?, user_Id = ?, service_Id = ? WHERE appointment_Id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, appointment.getAppointment_Date());
            pstmt.setString(2, appointment.getAppointment_Time());
            pstmt.setString(3, appointment.getAppointment_Status());
            pstmt.setInt(4, appointment.getUser_Id());
            pstmt.setInt(5, appointment.getService_Id());
            pstmt.setInt(6, appointment.getAppointment_Id());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Delete appointment
    public boolean deleteAppointment(int appointmentId) throws SQLException {
        String query = "DELETE FROM appointment WHERE appointment_Id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, appointmentId);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
    
    // Get count of appointments by status
    public int getAppointmentCountByStatus(String status) throws SQLException {
        String query = "SELECT COUNT(*) FROM appointment WHERE appointment_Status = ?";
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
    
    // Get detailed appointments with user and service information
    public List<Object[]> getDetailedAppointments() throws SQLException {
        List<Object[]> detailedAppointments = new ArrayList<>();
        String query = "SELECT a.*, u.name as user_name, u.email as user_email, u.phone as user_phone, " +
                      "s.service_Name, s.price, s.duration " +
                      "FROM appointment a " +
                      "JOIN user u ON a.user_Id = u.user_id " +
                      "JOIN service s ON a.service_Id = s.service_Id " +
                      "ORDER BY a.appointment_Date DESC, a.appointment_Time DESC";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Object[] appointmentDetails = new Object[10];
                appointmentDetails[0] = rs.getInt("appointment_Id");
                appointmentDetails[1] = rs.getString("appointment_Date");
                appointmentDetails[2] = rs.getString("appointment_Time");
                appointmentDetails[3] = rs.getString("appointment_Status");
                appointmentDetails[4] = rs.getInt("user_Id");
                appointmentDetails[5] = rs.getString("user_name");
                appointmentDetails[6] = rs.getString("user_email");
                appointmentDetails[7] = rs.getString("user_phone");
                appointmentDetails[8] = rs.getString("service_Name");
                appointmentDetails[9] = rs.getString("duration");
                
                detailedAppointments.add(appointmentDetails);
            }
        }
        
        return detailedAppointments;
    }
    
    // Get detailed appointments for a specific user
    public List<Object[]> getDetailedAppointmentsByUserId(int userId) throws SQLException {
        List<Object[]> detailedAppointments = new ArrayList<>();
        String query = "SELECT a.*, s.service_Name, s.price, s.duration " +
                      "FROM appointment a " +
                      "JOIN service s ON a.service_Id = s.service_Id " +
                      "WHERE a.user_Id = ? " +
                      "ORDER BY a.appointment_Date DESC, a.appointment_Time DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, userId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Object[] appointmentDetails = new Object[7];
                    appointmentDetails[0] = rs.getInt("appointment_Id");
                    appointmentDetails[1] = rs.getString("appointment_Date");
                    appointmentDetails[2] = rs.getString("appointment_Time");
                    appointmentDetails[3] = rs.getString("appointment_Status");
                    appointmentDetails[4] = rs.getString("service_Name");
                    appointmentDetails[5] = rs.getDouble("price");
                    appointmentDetails[6] = rs.getString("duration");
                    
                    detailedAppointments.add(appointmentDetails);
                }
            }
        }
        
        return detailedAppointments;
    }
}
