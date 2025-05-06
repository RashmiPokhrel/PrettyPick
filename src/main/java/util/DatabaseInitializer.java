package util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.Statement;
import java.util.stream.Collectors;

@WebListener
public class DatabaseInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            // Execute the update script
            executeScript("update_database.sql");
            System.out.println("Database update script executed successfully");
        } catch (Exception e) {
            System.err.println("Error executing database update script: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void executeScript(String scriptName) throws Exception {
        // Load the script from resources
        InputStream inputStream = getClass().getClassLoader().getResourceAsStream(scriptName);
        if (inputStream == null) {
            throw new Exception("Script file not found: " + scriptName);
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
                        System.out.println("Successfully executed SQL statement: " + statement);
                    } catch (Exception e) {
                        // If the column already exists, MySQL will throw an error
                        // We can safely ignore this error
                        System.out.println("Warning: " + e.getMessage());
                    }
                }
            }
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Cleanup if needed
    }
}


