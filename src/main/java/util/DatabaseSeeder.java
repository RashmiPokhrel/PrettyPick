package util;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.stream.Collectors;

@WebServlet("/admin/seed-database")
public class DatabaseSeeder extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is admin (in a real app, you'd have proper authentication)
        String userRole = null;
        if (request.getCookies() != null) {
            for (jakarta.servlet.http.Cookie cookie : request.getCookies()) {
                if ("userRole".equals(cookie.getName())) {
                    userRole = cookie.getValue();
                    break;
                }
            }
        }

        if (!"admin".equals(userRole)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin access required");
            return;
        }

        try {
            // Execute the script
            boolean success = executeScript("add_beauty_services.sql");
            
            if (success) {
                response.getWriter().write("Database seeded successfully with beauty services!");
            } else {
                response.getWriter().write("Failed to seed database. Check server logs for details.");
            }
        } catch (Exception e) {
            throw new ServletException("Error seeding database", e);
        }
    }

    private boolean executeScript(String scriptName) {
        try {
            // Load the script from resources
            InputStream inputStream = getClass().getClassLoader().getResourceAsStream(scriptName);
            if (inputStream == null) {
                System.err.println("Script file not found: " + scriptName);
                return false;
            }

            // Read the script content
            String script = new BufferedReader(new InputStreamReader(inputStream))
                    .lines().collect(Collectors.joining("\n"));

            // Execute the script
            try (Connection conn = DBConnection.getConnection();
                 Statement stmt = conn.createStatement()) {
                
                // Split the script by semicolons and execute each statement
                for (String statement : script.split(";")) {
                    if (!statement.trim().isEmpty()) {
                        try {
                            stmt.execute(statement);
                            System.out.println("Successfully executed SQL statement");
                        } catch (SQLException e) {
                            // If the service already exists, MySQL will throw an error
                            // We can safely ignore this error
                            System.out.println("Warning: " + e.getMessage());
                        }
                    }
                }
                return true;
            }
        } catch (Exception e) {
            System.err.println("Error executing script: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
