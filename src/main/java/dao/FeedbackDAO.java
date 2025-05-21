package dao;

import model.feedback;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


public class FeedbackDAO {

    // Create a new feedback
    public boolean createFeedback(feedback feedback) throws SQLException {
        String query = "INSERT INTO feedback (rating, comments, submitted_at, user_Id, service_Id) VALUES (?, ?, NOW(), ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, feedback.getRating());
            pstmt.setString(2, feedback.getComments());
            pstmt.setInt(3, feedback.getUser_id());
            pstmt.setInt(4, feedback.getService_id());

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        feedback.setFeedback_id(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        }
    }

    // Get feedback by ID
    public feedback getFeedbackById(int feedbackId) throws SQLException {
        String query = "SELECT * FROM feedback WHERE feedback_Id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, feedbackId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new feedback(
                        rs.getInt("feedback_Id"),
                        rs.getInt("rating"),
                        rs.getString("comments"),
                        rs.getString("submitted_at"),
                        rs.getInt("user_Id"),
                        rs.getInt("service_Id")
                    );
                }
                return null;
            }
        }
    }
    // Get all feedback
    public List<feedback> getAllFeedback() throws SQLException {
        List<feedback> feedbacks = new ArrayList<>();
        String query = "SELECT * FROM feedback ORDER BY submitted_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                feedback feedback = new feedback(
                    rs.getInt("feedback_Id"),
                    rs.getInt("rating"),
                    rs.getString("comments"),
                    rs.getString("submitted_at"),
                    rs.getInt("user_Id"),
                    rs.getInt("service_Id")
                );
                feedbacks.add(feedback);
            }
        }
        return feedbacks;
    }
    // Get feedback by user ID
    public List<feedback> getFeedbackByUserId(int userId) throws SQLException {
        List<feedback> feedbacks = new ArrayList<>();
        String query = "SELECT * FROM feedback WHERE user_Id = ? ORDER BY submitted_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    feedback feedback = new feedback(
                        rs.getInt("feedback_Id"),
                        rs.getInt("rating"),
                        rs.getString("comments"),
                        rs.getString("submitted_at"),
                        rs.getInt("user_Id"),
                        rs.getInt("service_Id")
                    );
                    feedbacks.add(feedback);
                }
            }
        }
        return feedbacks;
    }
    // Get feedback by service ID
    public List<feedback> getFeedbackByServiceId(int serviceId) throws SQLException {
        List<feedback> feedbacks = new ArrayList<>();
        String query = "SELECT * FROM feedback WHERE service_Id = ? ORDER BY submitted_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, serviceId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    feedback feedback = new feedback(
                        rs.getInt("feedback_Id"),
                        rs.getInt("rating"),
                        rs.getString("comments"),
                        rs.getString("submitted_at"),
                        rs.getInt("user_Id"),
                        rs.getInt("service_Id")
                    );
                    feedbacks.add(feedback);
                }
            }
        }
        return feedbacks;
    }

    // Update feedback
    public boolean updateFeedback(feedback feedback) throws SQLException {
        String query = "UPDATE feedback SET rating = ?, comments = ? WHERE feedback_Id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, feedback.getRating());
            pstmt.setString(2, feedback.getComments());
            pstmt.setInt(3, feedback.getFeedback_id());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Delete feedback
    public boolean deleteFeedback(int feedbackId) throws SQLException {
        String query = "DELETE FROM feedback WHERE feedback_Id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, feedbackId);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Get average rating for a service
    public double getAverageRatingForService(int serviceId) throws SQLException {
        String query = "SELECT AVG(rating) FROM feedback WHERE service_Id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, serviceId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble(1);
                }
                return 0.0;
            }
        }
    }

    // Get detailed feedback with user and service information
    public List<Object[]> getDetailedFeedback() throws SQLException {
        List<Object[]> detailedFeedbacks = new ArrayList<>();
        String query = "SELECT f.*, u.name as user_name, s.service_Name " +
                      "FROM feedback f " +
                      "JOIN user u ON f.user_Id = u.user_id " +
                      "JOIN service s ON f.service_Id = s.service_Id " +
                      "ORDER BY f.submitted_at DESC";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Object[] feedbackDetails = new Object[7];
                feedbackDetails[0] = rs.getInt("feedback_Id");
                feedbackDetails[1] = rs.getInt("rating");
                feedbackDetails[2] = rs.getString("comments");
                feedbackDetails[3] = rs.getString("submitted_at");
                feedbackDetails[4] = rs.getString("user_name");
                feedbackDetails[5] = rs.getInt("user_Id");
                feedbackDetails[6] = rs.getString("service_Name");

                detailedFeedbacks.add(feedbackDetails);
            }
        }

        return detailedFeedbacks;
    }
}
