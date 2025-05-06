-- Add duration column to service table if it doesn't exist
ALTER TABLE `service`
ADD COLUMN `duration` VARCHAR(50) NOT NULL DEFAULT '30 min' AFTER `price`;

-- Add category column to service table if it doesn't exist
ALTER TABLE `service`
ADD COLUMN `category` VARCHAR(50) AFTER `status`;

-- Add duration column to booking table if it doesn't exist
ALTER TABLE `booking`
ADD COLUMN `duration` VARCHAR(50) AFTER `notes`;
