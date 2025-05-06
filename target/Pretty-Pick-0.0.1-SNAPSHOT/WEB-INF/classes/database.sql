-- Create database
CREATE DATABASE IF NOT EXISTS `pretty-pick`;
USE `pretty-pick`;

-- Create user table
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `phone` VARCHAR(20),
  `password` VARCHAR(255) NOT NULL,
  `role` VARCHAR(20) NOT NULL DEFAULT 'user'
);

-- Create service table
CREATE TABLE IF NOT EXISTS `service` (
  `service_Id` INT AUTO_INCREMENT PRIMARY KEY,
  `service_Name` VARCHAR(100) NOT NULL,
  `description` TEXT,
  `price` DECIMAL(10,2) NOT NULL,
  `duration` VARCHAR(50) NOT NULL,
  `status` VARCHAR(20) NOT NULL DEFAULT 'Active'
);

-- Create booking table
CREATE TABLE IF NOT EXISTS `booking` (
  `booking_Id` INT AUTO_INCREMENT PRIMARY KEY,
  `booking_Date` DATE NOT NULL,
  `booking_Time` TIME NOT NULL,
  `status` VARCHAR(20) NOT NULL DEFAULT 'Pending',
  `notes` TEXT,
  `user_Id` INT NOT NULL,
  `service_Id` INT NOT NULL,
  FOREIGN KEY (`user_Id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE,
  FOREIGN KEY (`service_Id`) REFERENCES `service`(`service_Id`) ON DELETE CASCADE
);

-- Create appointment table
CREATE TABLE IF NOT EXISTS `appointment` (
  `appointment_Id` INT AUTO_INCREMENT PRIMARY KEY,
  `appointment_Date` DATE NOT NULL,
  `appointment_Time` TIME NOT NULL,
  `appointment_Status` VARCHAR(20) NOT NULL DEFAULT 'Pending',
  `user_Id` INT NOT NULL,
  `service_Id` INT NOT NULL,
  FOREIGN KEY (`user_Id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE,
  FOREIGN KEY (`service_Id`) REFERENCES `service`(`service_Id`) ON DELETE CASCADE
);

-- Create feedback table
CREATE TABLE IF NOT EXISTS `feedback` (
  `feedback_Id` INT AUTO_INCREMENT PRIMARY KEY,
  `rating` INT NOT NULL,
  `comments` TEXT,
  `submitted_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `user_Id` INT NOT NULL,
  `service_Id` INT NOT NULL,
  FOREIGN KEY (`user_Id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE,
  FOREIGN KEY (`service_Id`) REFERENCES `service`(`service_Id`) ON DELETE CASCADE
);

-- Insert sample admin user (password: admin123)
INSERT INTO `user` (`name`, `email`, `phone`, `password`, `role`) 
VALUES ('Admin User', 'admin@prettypick.com', '1234567890', '$2a$10$8K1p/a7OqMk.LJJ5gQ.4i.XPaZU4ULpV8q9qO5NqRbPX0wR1JLK1W', 'admin');

-- Insert sample regular user (password: user123)
INSERT INTO `user` (`name`, `email`, `phone`, `password`, `role`) 
VALUES ('Regular User', 'user@prettypick.com', '9876543210', '$2a$10$8K1p/a7OqMk.LJJ5gQ.4i.XPaZU4ULpV8q9qO5NqRbPX0wR1JLK1W', 'user');

-- Insert sample services
INSERT INTO `service` (`service_Name`, `description`, `price`, `duration`, `status`) 
VALUES 
('Haircut', 'Professional haircut by our expert stylists', 50.00, '30 min', 'Active'),
('Manicure', 'Complete nail care and polish application', 35.00, '45 min', 'Active'),
('Facial', 'Deep cleansing facial treatment', 75.00, '60 min', 'Active'),
('Hair Coloring', 'Professional hair coloring service', 120.00, '90 min', 'Active'),
('Pedicure', 'Complete foot care and polish application', 45.00, '60 min', 'Active');

-- Insert sample bookings
INSERT INTO `booking` (`booking_Date`, `booking_Time`, `status`, `notes`, `user_Id`, `service_Id`) 
VALUES 
(DATE_ADD(CURDATE(), INTERVAL 1 DAY), '10:00:00', 'Pending', 'First time customer', 2, 1),
(DATE_ADD(CURDATE(), INTERVAL 2 DAY), '14:00:00', 'Confirmed', 'Returning customer', 2, 2),
(DATE_ADD(CURDATE(), INTERVAL -1 DAY), '15:00:00', 'Completed', 'Very satisfied', 2, 3),
(DATE_ADD(CURDATE(), INTERVAL 3 DAY), '11:00:00', 'Cancelled', 'Customer had to reschedule', 2, 4);

-- Insert sample feedback
INSERT INTO `feedback` (`rating`, `comments`, `user_Id`, `service_Id`) 
VALUES 
(5, 'Excellent service! Very professional and friendly staff.', 2, 1),
(4, 'Good service, but had to wait a bit longer than expected.', 2, 2),
(5, 'Amazing facial treatment! My skin feels so refreshed.', 2, 3);
