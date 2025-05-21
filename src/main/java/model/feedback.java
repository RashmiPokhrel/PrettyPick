package model;

public class feedback {
    private int feedback_id;
    private int user_id;
    private String rating;
    private int service_id;
    private String Comments;
    private String submitted_at;


    public feedback(int feedback_id, int user_id, int service_id, String Comments) {
        this.feedback_id = feedback_id;
        this.user_id = user_id;
        this.service_id = service_id;
        this.Comments = Comments;
    }

    public feedback(int feedback_id, int rating, String comments, String submitted_at, int user_id, int service_id) {
        this.feedback_id = feedback_id;
        this.rating = String.valueOf(rating);
        this.Comments = comments;
        this.submitted_at = submitted_at;
        this.user_id = user_id;
        this.service_id = service_id;
    }

    public feedback(){}

    public String getSubmitted_at() {
        return submitted_at;
    }

    public void setSubmitted_at(String submitted_at) {
        this.submitted_at = submitted_at;
    }

    public int getFeedback_Id() {
        return feedback_id;
    }

    public int getFeedback_id() {
        return feedback_id;
    }

    public void setFeedback_id(int feedback_id) {
        this.feedback_id = feedback_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getRating() {
        return rating;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }

    public int getService_id() {
        return service_id;
    }

    public void setService_id(int service_id) {
        this.service_id = service_id;
    }

    public String getComments() {
        return Comments;
    }

    public void setFeedback_text(String feedback_text) {
        this.Comments= feedback_text;
    }


}
