# PrettyPick - Salon Appointment Booking System

PrettyPick is a web-based salon appointment booking system that allows users to book beauty services online. The application provides an intuitive interface for customers to browse services, book appointments, and manage their bookings. It also includes an admin dashboard for salon staff to manage services, appointments, and users.

## Features

### User Features
- User registration and login
- Browse available salon services
- Book appointments for services
- View and manage bookings (reschedule, cancel)
- Leave feedback for completed services

### Admin Features
- Dashboard with booking statistics
- Manage bookings (confirm, cancel, complete)
- Manage services (add, edit, delete)
- View user information
- View customer feedback

## Technologies Used

- Java Servlets and JSP
- MySQL Database
- HTML, CSS, JavaScript
- Jakarta EE
- Apache Tomcat
- Maven

## Setup Instructions

### Prerequisites
- Java Development Kit (JDK) 17 or higher
- Apache Tomcat 11
- MySQL Server
- Maven

### Database Setup
1. Create a MySQL database named `pretty-pick`
2. Run the SQL script located at `src/main/resources/database.sql` to create the necessary tables and sample data

### Configuration
1. Update the database connection settings in `src/main/java/util/DBConnection.java` if needed:
   ```java
   private static final String URL = "jdbc:mysql://localhost:3306/pretty-pick?useSSL=false&serverTimezone=UTC";
   private static final String USER = "root";
   private static final String PASSWORD = "";
   ```

### Building and Running
1. Clone the repository
2. Navigate to the project directory
3. Build the project using Maven:
   ```
   mvn clean package
   ```
4. Deploy the generated WAR file to Tomcat
5. Access the application at `http://localhost:8080/Pretty-Pick`

## Default Login Credentials

### Admin User
- Email: admin@prettypick.com
- Password: admin123

### Regular User
- Email: user@prettypick.com
- Password: user123

## Project Structure

- `src/main/java/model/` - Contains model classes (User, Service, Booking, etc.)
- `src/main/java/dao/` - Contains Data Access Objects for database operations
- `src/main/java/servlet/` - Contains servlet classes for handling HTTP requests
- `src/main/java/util/` - Contains utility classes
- `src/main/webapp/` - Contains JSP pages and static resources
- `src/main/resources/` - Contains configuration files and SQL scripts

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- Font Awesome for icons
- Bootstrap for styling inspiration
