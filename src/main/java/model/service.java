package model;

import java.util.ArrayList;
import java.util.List;

public class service {
    private int service_Id;
    private String service_Name;
    private String description;
    private double price;
    private String duration;
    private String status;
    private String category;
    private List<String> features;

    public service() {
        this.features = new ArrayList<>();
    }

    public service(int service_Id, String service_Name, String description, double price, String duration, String status) {
        this.service_Id = service_Id;
        this.service_Name = service_Name;
        this.description = description;
        this.price = price;
        this.duration = duration;
        this.status = status;
        this.features = new ArrayList<>();
    }



		public int getService_Id() {
			return service_Id;
		}



		public void setService_Id(int service_Id) {
			this.service_Id = service_Id;
		}



		public String getService_Name() {
			return service_Name;
		}



		public void setService_Name(String service_Name) {
			this.service_Name = service_Name;
		}



		public String getDescription() {
			return description;
		}



		public void setDescription(String description) {
			this.description = description;
		}



		public double getPrice() {
			return price;
		}



		public void setPrice(double price) {
			this.price = price;
		}



		public String getDuration() {
			return duration;
		}



		public void setDuration(String duration) {
			this.duration = duration;
		}



		public String getStatus() {
			return status;
		}



		public void setStatus(String status) {
			this.status = status;
		}

		public String getCategory() {
			return category;
		}

		public void setCategory(String category) {
			this.category = category;
		}

		public List<String> getFeatures() {
			return features;
		}

		public void setFeatures(List<String> features) {
			this.features = features;
		}

		public void addFeature(String feature) {
			if (this.features == null) {
				this.features = new ArrayList<>();
			}
			this.features.add(feature);
		}
}
