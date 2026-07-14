-- =======================================================
-- PROJECT NAME: KrishiLink (Smart Agri-Supply & Soil Intelligence)
-- DATABASE SCHEMA DESIGN (8 CORE MODULES)
-- =======================================================

-- 1. Create Database
CREATE DATABASE IF NOT EXISTS KrishiLinkDB;
USE KrishiLinkDB;

-- ==========================================
-- MODULE 1: USER MANAGEMENT
-- ==========================================
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    user_role ENUM('Farmer', 'Buyer', 'Expert', 'LogisticsPartner') NOT NULL,
    location VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- MODULE 2: SOIL DIAGNOSTICS & CROP RECOMMENDATIONS
-- ==========================================
CREATE TABLE SoilReports (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    farmer_id INT,
    nitrogen_level DECIMAL(5,2),
    phosphorus_level DECIMAL(5,2),
    potassium_level DECIMAL(5,2),
    ph_value DECIMAL(3,2),
    moisture_percentage DECIMAL(5,2),
    tested_on DATE,
    FOREIGN KEY (farmer_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE CropRecommendations (
    recommendation_id INT AUTO_INCREMENT PRIMARY KEY,
    report_id INT,
    recommended_crop VARCHAR(100),
    fertilizer_advice TEXT,
    expert_id INT NULL,
    FOREIGN KEY (report_id) REFERENCES SoilReports(report_id) ON DELETE CASCADE,
    FOREIGN KEY (expert_id) REFERENCES Users(user_id) ON DELETE SET NULL
);

-- ==========================================
-- MODULE 3: MARKETPLACE & CROP SALES
-- ==========================================
CREATE TABLE CropListings (
    listing_id INT AUTO_INCREMENT PRIMARY KEY,
    farmer_id INT,
    crop_name VARCHAR(100) NOT NULL,
    quantity_kg DECIMAL(10,2) NOT NULL,
    price_per_kg DECIMAL(10,2) NOT NULL,
    harvest_date DATE,
    status ENUM('Available', 'Sold', 'Auction') DEFAULT 'Available',
    FOREIGN KEY (farmer_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    listing_id INT,
    buyer_id INT,
    quantity_ordered DECIMAL(10,2) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    order_status ENUM('Pending', 'Shipped', 'Delivered') DEFAULT 'Pending',
    ordered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (listing_id) REFERENCES CropListings(listing_id) ON DELETE CASCADE,
    FOREIGN KEY (buyer_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- ==========================================
-- MODULE 4: REAL-TIME AUCTION & BIDDING
-- ==========================================
CREATE TABLE Auctions (
    auction_id INT AUTO_INCREMENT PRIMARY KEY,
    listing_id INT,
    min_bid DECIMAL(10,2) NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    status ENUM('Active', 'Closed') DEFAULT 'Active',
    FOREIGN KEY (listing_id) REFERENCES CropListings(listing_id) ON DELETE CASCADE
);

CREATE TABLE Bids (
    bid_id INT AUTO_INCREMENT PRIMARY KEY,
    auction_id INT,
    buyer_id INT,
    bid_amount DECIMAL(10,2) NOT NULL,
    bid_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (auction_id) REFERENCES Auctions(auction_id) ON DELETE CASCADE,
    FOREIGN KEY (buyer_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- ==========================================
-- MODULE 5: SHARED EQUIPMENT RENTAL
-- ==========================================
CREATE TABLE Equipment (
    equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    owner_id INT,
    equipment_name VARCHAR(100) NOT NULL,
    hourly_rate DECIMAL(10,2) NOT NULL,
    availability_status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (owner_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE RentalBookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    equipment_id INT,
    renter_id INT,
    booking_date DATE NOT NULL,
    hours_booked INT NOT NULL,
    total_cost DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id) ON DELETE CASCADE,
    FOREIGN KEY (renter_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- ==========================================
-- MODULE 6: LOGISTICS & TRANSPORT
-- ==========================================
CREATE TABLE Shipments (
    shipment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    driver_id INT,
    delivery_partner VARCHAR(100),
    current_status ENUM('Dispatched', 'In-Transit', 'Delivered') DEFAULT 'Dispatched',
    estimated_delivery DATE,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (driver_id) REFERENCES Users(user_id) ON DELETE SET NULL
);

-- ==========================================
-- MODULE 7: WAREHOUSE & COLD STORAGE
-- ==========================================
CREATE TABLE Warehouses (
    warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
    warehouse_name VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL,
    capacity_tons DECIMAL(10,2) NOT NULL,
    available_capacity DECIMAL(10,2) NOT NULL,
    temp_controlled BOOLEAN DEFAULT FALSE
);

CREATE TABLE StorageBookings (
    storage_id INT AUTO_INCREMENT PRIMARY KEY,
    warehouse_id INT,
    farmer_id INT,
    crop_stored VARCHAR(100),
    weight_stored_tons DECIMAL(10,2),
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id) ON DELETE CASCADE,
    FOREIGN KEY (farmer_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- ==========================================
-- MODULE 8: MICRO-FINANCE & SUBSIDIES
-- ==========================================
CREATE TABLE Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    farmer_id INT,
    amount DECIMAL(10,2) NOT NULL,
    interest_rate DECIMAL(4,2) NOT NULL,
    status ENUM('Applied', 'Approved', 'Disbursed', 'Repaid') DEFAULT 'Applied',
    applied_on DATE,
    FOREIGN KEY (farmer_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- ==========================================
-- DUMMY DATA FOR TESTING
-- ==========================================
INSERT INTO Users (full_name, phone_number, password_hash, user_role, location) VALUES
('Ramesh Kumar', '9876543210', 'hash_123', 'Farmer', 'Punjab'),
('Suresh Singh', '8765432109', 'hash_456', 'Buyer', 'Delhi'),
('Dr. Amit Patel', '7654321098', 'hash_789', 'Expert', 'Haryana');

INSERT INTO SoilReports (farmer_id, nitrogen_level, phosphorus_level, potassium_level, ph_value, moisture_percentage, tested_on) VALUES
(1, 45.2, 12.8, 34.5, 6.5, 22.4, CURDATE());