package dao;

import model.service;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ServiceDAO {

    // Create a new service
    public boolean addService(service service) throws SQLException {
        String query = "INSERT INTO service (service_Name, description, price, duration, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, service.getService_Name());
            pstmt.setString(2, service.getDescription());
            pstmt.setDouble(3, service.getPrice());
            pstmt.setString(4, service.getDuration());
            pstmt.setString(5, service.getStatus());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Read a service by ID
    public service getServiceById(int serviceId) throws SQLException {
        String query = "SELECT * FROM service WHERE service_Id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, serviceId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new service(
                        rs.getInt("service_Id"),
                        rs.getString("service_Name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("duration"),
                        rs.getString("status")
                    );
                }
                return null;
            }
        }
    }

    // Read all services
    public List<service> getAllServices() throws SQLException {
        List<service> services = new ArrayList<>();
        String query = "SELECT * FROM service";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                service service = new service(
                        rs.getInt("service_Id"),
                        rs.getString("service_Name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("duration"),
                        rs.getString("status")
                );
                services.add(service);
            }
        }
        return services;
    }

    // Update a service
    public boolean updateService(service service) throws SQLException {
        String query = "UPDATE service SET service_Name = ?, description = ?, price = ?, duration = ?, status = ? WHERE service_Id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, service.getService_Name());
            pstmt.setString(2, service.getDescription());
            pstmt.setDouble(3, service.getPrice());
            pstmt.setString(4, service.getDuration());
            pstmt.setString(5, service.getStatus());
            pstmt.setInt(6, service.getService_Id());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Delete a service
    public boolean deleteService(int serviceId) throws SQLException {
        String query = "DELETE FROM service WHERE service_Id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, serviceId);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
}