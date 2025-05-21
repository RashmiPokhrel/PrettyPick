package dao;

import model.user;
import util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // Register a new user
    public boolean registerUser(user user) throws SQLException {
        String query = "INSERT INTO user (name, email, phone, password, role) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            // Hash the password before saving
            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());

            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPhone() != null ? user.getPhone() : null);
            statement.setString(4, hashedPassword);
            statement.setString(5, user.getRole());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            if (e.getErrorCode() == 1062) {
                throw new SQLException("Email already exists", e);
            }
            throw e;
        }
    }

    // Verify user login credentials
    public user loginUser(String email, String password) throws SQLException {
        String query = "SELECT * FROM user WHERE email = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    String hashedPassword = resultSet.getString("password");

                    // Verify the password
                    if (BCrypt.checkpw(password, hashedPassword)) {
                        user user = new user();
                        user.setUser_id(resultSet.getInt("user_id"));
                        user.setName(resultSet.getString("name"));
                        user.setEmail(resultSet.getString("email"));
                        user.setPhone(resultSet.getString("phone"));
                        user.setPassword(hashedPassword);
                        user.setRole(resultSet.getString("role"));
                        return user;
                    }
                }
                return null;
            }
        }
    }

    // Get user by email
    public user getUserByEmail(String email) throws SQLException {
        String query = "SELECT * FROM user WHERE email = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    user user = new user();
                    user.setUser_id(resultSet.getInt("user_id"));
                    user.setName(resultSet.getString("name"));
                    user.setEmail(resultSet.getString("email"));
                    user.setPhone(resultSet.getString("phone"));
                    user.setPassword(resultSet.getString("password"));
                    user.setRole(resultSet.getString("role"));
                    return user;
                }
                return null;
            }
        }
    }

    // Get user by ID
    public user getUserById(int userId) throws SQLException {
        String query = "SELECT * FROM user WHERE user_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    user user = new user();
                    user.setUser_id(resultSet.getInt("user_id"));
                    user.setName(resultSet.getString("name"));
                    user.setEmail(resultSet.getString("email"));
                    user.setPhone(resultSet.getString("phone"));
                    user.setPassword(resultSet.getString("password"));
                    user.setRole(resultSet.getString("role"));
                    return user;
                }
                return null;
            }
        }
    }

    // Get all users
    public List<user> getAllUsers() throws SQLException {
        List<user> users = new ArrayList<>();
        String query = "SELECT * FROM user ORDER BY name";
        try (Connection connection = DBConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {

            while (resultSet.next()) {
                user user = new user();
                user.setUser_id(resultSet.getInt("user_id"));
                user.setName(resultSet.getString("name"));
                user.setEmail(resultSet.getString("email"));
                user.setPhone(resultSet.getString("phone"));
                user.setPassword(resultSet.getString("password"));
                user.setRole(resultSet.getString("role"));
                users.add(user);
            }
        }
        return users;
    }

    // Search users by name or email
    public List<user> searchUsers(String searchQuery) throws SQLException {
        List<user> users = new ArrayList<>();
        String query = "SELECT * FROM user WHERE name LIKE ? OR email LIKE ? ORDER BY name";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            String searchPattern = "%" + searchQuery + "%";
            statement.setString(1, searchPattern);
            statement.setString(2, searchPattern);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    user user = new user();
                    user.setUser_id(resultSet.getInt("user_id"));
                    user.setName(resultSet.getString("name"));
                    user.setEmail(resultSet.getString("email"));
                    user.setPhone(resultSet.getString("phone"));
                    user.setPassword(resultSet.getString("password"));
                    user.setRole(resultSet.getString("role"));
                    users.add(user);
                }
            }
        }
        return users;
    }

    // Update user
    public boolean updateUser(user user) throws SQLException {
        String query = "UPDATE user SET name = ?, email = ?, phone = ?, role = ? WHERE user_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPhone());
            statement.setString(4, user.getRole());
            statement.setInt(5, user.getUser_id());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Update user password
    public boolean updateUserPassword(int userId, String newPassword) throws SQLException {
        String query = "UPDATE user SET password = ? WHERE user_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            // Hash the new password
            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

            statement.setString(1, hashedPassword);
            statement.setInt(2, userId);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Delete user
    public boolean deleteUser(int userId) throws SQLException {
        String query = "DELETE FROM user WHERE user_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, userId);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Verify user password
    public boolean verifyPassword(int userId, String password) throws SQLException {
        String query = "SELECT password FROM user WHERE user_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    String storedHash = resultSet.getString("password");
                    return BCrypt.checkpw(password, storedHash);
                }
                return false;
            }
        }
    }
}
