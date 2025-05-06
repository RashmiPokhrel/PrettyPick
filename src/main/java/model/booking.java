package model;

public class booking {
    private int booking_Id;
    private String booking_Date;
    private String booking_Time;
    private String status;
    private String notes;
    private String duration;
    private int user_Id;     // Foreign Key
    private int service_Id;  // Foreign Key

    public booking() {
    }

    public booking(int booking_Id, String booking_Date, String booking_Time, String status, String notes, String duration, int user_Id, int service_Id) {
        this.booking_Id = booking_Id;
        this.booking_Date = booking_Date;
        this.booking_Time = booking_Time;
        this.status = status;
        this.notes = notes;
        this.duration = duration;
        this.user_Id = user_Id;
        this.service_Id = service_Id;
    }

    public int getBooking_Id() {
        return booking_Id;
    }

    public void setBooking_Id(int booking_Id) {
        this.booking_Id = booking_Id;
    }

    public String getBooking_Date() {
        return booking_Date;
    }

    public void setBooking_Date(String booking_Date) {
        this.booking_Date = booking_Date;
    }

    public String getBooking_Time() {
        return booking_Time;
    }

    public void setBooking_Time(String booking_Time) {
        this.booking_Time = booking_Time;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public int getUser_Id() {
        return user_Id;
    }

    public void setUser_Id(int user_Id) {
        this.user_Id = user_Id;
    }

    public int getService_Id() {
        return service_Id;
    }

    public void setService_Id(int service_Id) {
        this.service_Id = service_Id;
    }
    public String getDuration() {
        return duration;
    }
    public void setDuration(String duration) {
        this.duration = duration;
    }

}
