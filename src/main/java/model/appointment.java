package model;

public class appointment {
	private int appointment_Id;
    private String appointment_Date;
    private String appointment_Time;
    private String appointment_Status;
    private int user_Id;     // Foreign Key
    private int service_Id;  // Foreign Key

    public appointment() {
    }

    public appointment(int appointment_Id, String appointment_Date, String appointment_Time, String appointment_Status, int user_Id, int service_Id) {
        this.appointment_Id = appointment_Id;
        this.appointment_Date = appointment_Date;
        this.appointment_Time = appointment_Time;
        this.appointment_Status = appointment_Status;
        this.user_Id = user_Id;
        this.service_Id = service_Id;
    }

	public int getAppointment_Id() {
		return appointment_Id;
	}

	public void setAppointment_Id(int appointment_Id) {
		this.appointment_Id = appointment_Id;
	}

	public String getAppointment_Date() {
		return appointment_Date;
	}

	public void setAppointment_Date(String appointment_Date) {
		this.appointment_Date = appointment_Date;
	}

	public String getAppointment_Time() {
		return appointment_Time;
	}

	public void setAppointment_Time(String appointment_Time) {
		this.appointment_Time = appointment_Time;
	}

	public String getAppointment_Status() {
		return appointment_Status;
	}

	public void setAppointment_Status(String appointment_Status) {
		this.appointment_Status = appointment_Status;
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


}
