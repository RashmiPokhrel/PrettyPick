package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/pretty-pick?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    static {
        try {
            System.out.println("Attempting to load MySQL JDBC Driver...");
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL JDBC Driver loaded successfully.");
        } catch (ClassNotFoundException e) {
            System.err.println("Failed to load MySQL JDBC Driver: " + e.getMessage());
            throw new RuntimeException("Failed to load MySQL JDBC Driver", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        System.out.println("Establishing database connection...");
        Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
        System.out.println("Database connection established.");
        return connection;
    }
}