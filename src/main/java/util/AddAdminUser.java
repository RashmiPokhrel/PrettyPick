package util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility class to add a specific admin user to the database.
 * This class can be run as a standalone program to add an admin user with
 * email admin@gmail.com and password admin@123.
 */
public class AddAdminUser {
    
    public static void main(String[] args) {
        try {
            // Check if the user already exists
            if (userExists("admin@gmail.com")) {
                System.out.println("Admin user with email admin@gmail.com already exists.");
                return;
            }
            
            // Add the admin user
            boolean success = addAdminUser();
            
            if (success) {
                System.out.println("Admin user added successfully!");
                System.out.println("Email: admin@gmail.com");
                System.out.println("Password: admin@123");
            } else {
                System.out.println("Failed to add admin user.");
            }
        } catch (SQLException e) {
            System.err.println("Database error: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Adds an admin user with email admin@gmail.com and password admin@123.
     * 
     * @return true if the user was added successfully, false otherwise
     * @throws SQLException if a database error occurs
     */
    public static boolean addAdminUser() throws SQLException {
        String query = "INSERT INTO user (name, email, phone, password, role) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            
            // Hash the password using BCrypt
            String hashedPassword = BCrypt.hashpw("admin@123", BCrypt.gensalt());
            
            statement.setString(1, "Admin User");
            statement.setString(2, "admin@gmail.com");
            statement.setString(3, "1234567890");
            statement.setString(4, hashedPassword);
            statement.setString(5, "admin");
            
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }
    
    /**
     * Checks if a user with the given email already exists in the database.
     * 
     * @param email the email to check
     * @return true if a user with the given email exists, false otherwise
     * @throws SQLException if a database error occurs
     */
    public static boolean userExists(String email) throws SQLException {
        String query = "SELECT COUNT(*) FROM user WHERE email = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            
            statement.setString(1, email);
            
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1) > 0;
                }
                return false;
            }
        }
    }
}
