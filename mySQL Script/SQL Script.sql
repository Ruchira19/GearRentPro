-- Create the database
DROP DATABASE IF EXISTS gearrent_pro;
CREATE DATABASE gearrent_pro;
USE gearrent_pro;

-- Membership Table
CREATE TABLE membership (
    membership_id INT AUTO_INCREMENT PRIMARY KEY,
    level ENUM('REGULAR','SILVER','GOLD') UNIQUE NOT NULL,
    discount_percent DECIMAL(5,2) NOT NULL
);

-- Branch Table
CREATE TABLE branch (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,
    branch_code VARCHAR(10) UNIQUE NOT NULL,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(200),
    contact_number VARCHAR(12)
);

-- Customer Table
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50),
    nic VARCHAR(20) UNIQUE NOT NULL,
    contact VARCHAR(12),
    address VARCHAR(200),
    membership_id INT,
    FOREIGN KEY (membership_id) REFERENCES membership(membership_id)
);

-- System User Table
CREATE TABLE system_user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(20) NOT NULL,
    role ENUM('ADMIN','MANAGER','STAFF') NOT NULL,
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

-- Categories Table
CREATE TABLE category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(100),
    base_price_factor DECIMAL(5,2) NOT NULL,
    weekend_multiplier DECIMAL(5,2) NOT NULL,
    default_late_fee_per_day DECIMAL(10,2),
    active BOOLEAN DEFAULT TRUE
);

-- Equipment Table
CREATE TABLE equipment (
    equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    branch_id INT NOT NULL,
    brand VARCHAR(50),
    model VARCHAR(50),
    purchase_year INT,
    base_daily_price DECIMAL(10,2) NOT NULL,
    security_deposit DECIMAL(10,2) NOT NULL,
    status ENUM('AVAILABLE','RESERVED','RENTED','MAINTENANCE') DEFAULT 'AVAILABLE',
    FOREIGN KEY (category_id) REFERENCES category(category_id),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

-- Reservation Table
CREATE TABLE reservation (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    equipment_id INT NOT NULL,
    customer_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status ENUM('ACTIVE','CANCELLED') DEFAULT 'ACTIVE',
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Rental Table
CREATE TABLE rental (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    equipment_id INT NOT NULL,
    customer_id INT NOT NULL,
    branch_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    rental_amount DECIMAL(10,2),
    security_deposit DECIMAL(10,2),
    membership_discount DECIMAL(10,2),
    long_rental_discount DECIMAL(10,2),
    final_payable DECIMAL(10,2),
    payment_status ENUM('PAID','PARTIALLY_PAID','UNPAID') DEFAULT 'UNPAID',
    rental_status ENUM('ACTIVE','RETURNED','OVERDUE','CANCELLED') DEFAULT 'ACTIVE',
    actual_return_date DATE,
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

-- Damages Table
CREATE TABLE damage (
    damage_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_id INT NOT NULL,
    description VARCHAR(200),
    damage_charge DECIMAL(10,2),
    FOREIGN KEY (rental_id) REFERENCES rental(rental_id)
);


-- SAMPLE DATA 

-- Branches (3)
INSERT INTO branch (branch_code, name, address, contact_number) VALUES
('B001', 'Colombo Branch', 'Colombo 05', '011-2005005'),
('B002', 'Kandy Branch', 'Kandy City Center', '081-2233445'),
('B003', 'Galle Branch', 'Galle Fort', '091-3344556');


-- Membership (3)
INSERT INTO membership (level, discount_percent) VALUES
('REGULAR', 0.00),
('SILVER', 5.00),
('GOLD', 10.00);

-- Customers 
INSERT INTO customer (name, email, nic, contact, address, membership_id) VALUES
('Ravi Perera', 'ravi@gmail.com', '951234567V', '0771234567', 'Nugegoda', 2),
('Tharushi Fernando', 'tharushi@yahoo.com', '992289765V', '0769876543', 'Kandy', 1),
('Malith Dissanayake', 'malith@gmail.com', '942345678V', '0713456789', 'Galle', 3),
('Kasun Silva', 'kasun@gmail.com', '972156789V', '0705678912', 'Dehiwala', 1),
('Nadeesha Perera', 'nadee@yahoo.com', '982345671V', '0756789123', 'Moratuwa', 2),
('Hansani Kumari', 'hansani@gmail.com', '993216789V', '0789876543', 'Gampaha', 3),
('Charith Weerasinghe', 'charithw@gmail.com', '902198765V', '0777896541', 'Maharagama', 2),
('Supuni Jayasuriya', 'supuni@gmail.com', '992345612V', '0713456987', 'Panadura', 1),
('Dineth Madusanka', 'dineth@gmail.com', '952345621V', '0764567891', 'Matara', 3),
('Sajani Gunathilaka', 'sajani@hotmail.com', '962345678V', '0755678999', 'Battaramulla', 1);

-- Users (3)
INSERT INTO system_user (user_name, password, role, branch_id) VALUES
('admin', 'admin123', 'ADMIN', 1),
('manager_col', 'pass123', 'MANAGER', 1),
('staff_kandy', 'staff001', 'STAFF', 2);

-- Categories
INSERT INTO category (name, description, base_price_factor, weekend_multiplier, default_late_fee_per_day, active) VALUES
('Camera', 'DSLR and Mirrorless Cameras', 1.20, 1.50, 500.00, TRUE),
('Lens', 'Professional Camera Lenses', 1.10, 1.40, 300.00, TRUE),
('Tripod', 'Camera Tripods', 1.00, 1.20, 200.00, TRUE),
('Drone', 'Aerial Photography Equipment', 1.50, 1.80, 800.00, TRUE),
('Lighting', 'Studio and Outdoor Lighting Equipment', 1.00, 1.30, 250.00, TRUE);

-- Equipments
INSERT INTO equipment (category_id, branch_id, brand, model, purchase_year, base_daily_price, security_deposit, status) VALUES
-- Cameras
(1, 1, 'Canon', 'EOS 90D', 2022, 3500.00, 15000.00, 'AVAILABLE'),
(1, 1, 'Sony', 'A7III', 2021, 4500.00, 20000.00, 'RESERVED'),
(1, 2, 'Nikon', 'Z6 II', 2022, 4000.00, 18000.00, 'AVAILABLE'),
(1, 3, 'Panasonic', 'GH5', 2020, 3800.00, 17000.00, 'MAINTENANCE'),
-- Lenses
(2, 1, 'Canon', '24-70mm f2.8', 2020, 2000.00, 12000.00, 'AVAILABLE'),
(2, 2, 'Sony', '70-200mm f2.8', 2021, 2500.00, 15000.00, 'AVAILABLE'),
(2, 2, 'Nikon', '50mm f1.8', 2023, 1500.00, 10000.00, 'AVAILABLE'),
(2, 3, 'Sigma', '18-35mm f1.8', 2019, 1800.00, 11000.00, 'RESERVED'),
-- Tripods
(3, 1, 'Benro', 'T660EX', 2019, 800.00, 5000.00, 'AVAILABLE'),
(3, 3, 'Manfrotto', 'MT055', 2021, 1200.00, 7000.00, 'AVAILABLE'),
(3, 2, 'Yunteng', 'VCT-5208', 2020, 600.00, 4000.00, 'AVAILABLE'),
-- Drones
(4, 1, 'DJI', 'Mavic Air 2', 2021, 6000.00, 25000.00, 'AVAILABLE'),
(4, 2, 'DJI', 'Mini 3 Pro', 2023, 6500.00, 26000.00, 'RENTED'),
(4, 3, 'DJI', 'Phantom 4 Pro', 2019, 7000.00, 30000.00, 'AVAILABLE'),
-- Lighting
(5, 3, 'Godox', 'SL60W', 2022, 1500.00, 8000.00, 'AVAILABLE'),
(5, 1, 'Aputure', 'Amaran 100d', 2023, 2000.00, 10000.00, 'AVAILABLE'),
(5, 2, 'Neewer', '660 LED Panel', 2020, 1000.00, 6000.00, 'AVAILABLE'),
(5, 1, 'Godox', 'VL150', 2021, 2500.00, 11000.00, 'AVAILABLE'),
(5, 2, 'Aputure', 'Light Dome II', 2020, 1800.00, 9000.00, 'AVAILABLE'),
(5, 3, 'Godox', 'SK400II', 2019, 2000.00, 10000.00, 'MAINTENANCE');

-- Reservations (some active)
INSERT INTO reservation (equipment_id, customer_id, start_date, end_date, status) VALUES
(2, 1, '2025-02-01', '2025-02-03', 'ACTIVE'),
(8, 4, '2025-02-10', '2025-02-12', 'ACTIVE'),
(10, 3, '2025-02-05', '2025-02-05', 'ACTIVE');

-- Rentals (including overdue + returned)
INSERT INTO rental (equipment_id, customer_id, branch_id, start_date, end_date, rental_amount, security_deposit, membership_discount, long_rental_discount, final_payable, payment_status, rental_status, actual_return_date) VALUES
-- Returned on time
(1, 1, 1, '2025-01-15', '2025-01-17', 7000.00, 15000.00, 350.00, 0.00, 31650.00, 'PAID', 'RETURNED', '2025-01-17'),
-- Returned late (overdue)
(12, 3, 3, '2025-01-20', '2025-01-22', 18000.00, 25000.00, 0.00, 0.00, 43000.00, 'PARTIALLY_PAID', 'OVERDUE', NULL),
-- Active rental
(6, 2, 2, '2025-01-28', '2025-02-02', 12500.00, 15000.00, 0.00, 0.00, 27500.00, 'UNPAID', 'ACTIVE', NULL),
-- Returned with damages
(4, 5, 3, '2025-01-10', '2025-01-12', 7500.00, 17000.00, 0.00, 0.00, 24500.00, 'PAID', 'RETURNED', '2025-01-12');

-- Damages
INSERT INTO damage (rental_id, description, damage_charge) VALUES
(4, 'Cracked screen protector', 3000.00);
