-- Create the database
CREATE DATABASE HotelManagement;
-- Initialise the database
USE HotelManagement;

-- Create the Rooms table
CREATE TABLE Rooms (
	room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(3) NOT NULL UNIQUE,
    room_type VARCHAR(10) NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    availability_status BOOLEAN NOT NULL DEFAULT TRUE
);

-- Create the Guests table
CREATE TABLE Guests (
	guest_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15),
    check_in_date date
);

-- Create the Reservations table
CREATE TABLE Reservations (
	reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    room_id INT NOT NULL,
    guest_id INT NOT NULL,
    reservation_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id),
    FOREIGN KEY (guest_id) REFERENCES Guests(guest_id),
    CHECK (check_out_date > reservation_date)
);

-- Insert data into Rooms table
INSERT INTO Rooms (room_number, room_type, price_per_night, availability_status)
VALUES
('101', 'Single', 100.00, TRUE),
('102', 'Double', 150.00, TRUE),
('103', 'Suite', 250.00, TRUE),
('104', 'Single', 100.00, TRUE),
('105', 'Double', 150.00, TRUE),
('106', 'Suite', 250.00, TRUE),
('107', 'Single', 100.00, TRUE),
('108', 'Double', 150.00, TRUE);

-- Insert data into Guests table
INSERT INTO Guests (first_name, last_name, email, phone_number, check_in_date)
VALUES
('Sarah', 'Smith', 'sarah.smith@gmail.com', '+447428538105', '2024-06-01'),
('Helena', 'Johnson', 'helenajohnson@hotmail.com', '+447836195847', '2024-06-01'),
('Chris', 'Sampson', 'christsampson@aol.com', '+487428538105', '2024-06-03'),
('Mariko', 'Miyashiro', 'mmiyashiro@gmail.com', '+81738475930', '2024-06-04'),
('Jazmin', 'Hood', 'jt.hoodxo@hotmail.com', '+447284750284', '2024-06-04'),
('Keelan', 'Garcia', 'keelan.garcia@outlook.com', '+447483294195', '2024-06-06'),
('Neo', 'Morales', 'neogmorales@icloud.com', '+18084738265', '2024-06-07'),
('Sameer', 'Wilkinson', 'stswilkinson@gmail.com', '+447295917403', '2024-06-09');

INSERT INTO Reservations (room_id, guest_id, reservation_date, check_out_date)
VALUES
(1, 1, '2024-06-01', '2024-06-05'),
(2, 2, '2024-06-01', '2024-06-07'),
(3, 3, '2024-06-03', '2024-06-04'),
(4, 4, '2024-06-04', '2024-06-09'),
(5, 5, '2024-06-04', '2024-06-10'),
(6, 6, '2024-06-06', '2024-06-10'),
(7, 7, '2024-06-07', '2024-06-09'),
(8, 8, '2024-06-09', '2024-06-11');

-- Create view of all available rooms in a readable format
CREATE VIEW available_rooms AS
SELECT room_id AS 'Room ID',
	room_number AS 'Room Number', 
    room_type AS 'Room Type', 
    price_per_night AS 'Price Per Night (£)', 
    availability_status AS 'Availability'
FROM Rooms
WHERE availability_status = TRUE ORDER BY room_number;

-- Retrieve all rooms currently available
SELECT * FROM available_rooms;

-- Create view to retrieve reservation history of a specific guest in a readible format
CREATE VIEW guest_reservation_history AS
SELECT reservation_id AS 'Reservation ID',
	room_id AS 'Room ID',
    Reservations.guest_id AS 'Guest ID',
    DATE_FORMAT(reservation_date, "%d/%l/%Y") AS 'Reservation Date',
    DATE_FORMAT(check_out_date, "%d/%l/%Y") AS 'Checkout Date',
    Guests.first_name AS 'First Name',
    Guests.last_name AS 'Surname'
FROM Reservations
JOIN Guests ON Reservations.guest_id = Guests.guest_id
WHERE Guests.email = 'sarah.smith@gmail.com'
ORDER BY Reservations.reservation_date;

-- Retrieve reservation history of a specific guest
SELECT * FROM guest_reservation_history;

-- Create view to retrieve all reservations with room details in a readible format
CREATE VIEW room_details AS
SELECT reservation_id AS 'Reservation ID',
	Reservations.room_id AS 'Room ID',
    Reservations.guest_id AS 'Guest ID',
    DATE_FORMAT(reservation_date, "%d/%l/%Y") AS 'Reservation Date',
    DATE_FORMAT(check_out_date, "%d/%l/%Y") AS 'Checkout Date',
    Rooms.room_number AS 'Room Number',
    Rooms.room_type AS 'Room Type'
FROM Reservations
JOIN Rooms ON Reservations.room_id = Rooms.room_id
ORDER BY Reservations.reservation_date;

-- Retrieve all reservations with room details
SELECT * FROM room_details;

-- Update the availability status of a room
UPDATE Rooms SET availability_status = FALSE WHERE room_id = 1;

-- Delete an old reservation record
DELETE FROM Reservations WHERE reservation_id = 1;

-- Fetch total number of reservations
SELECT COUNT(*) AS 'Total Reservations' FROM Reservations;

-- Create view to calculate total profit generated from reservations
CREATE VIEW total_profit AS
SELECT SUM(Rooms.price_per_night * DATEDIFF(Reservations.check_out_date, Reservations.reservation_date)) AS 'Total Profit (£)'
FROM Reservations
JOIN Rooms on Reservations.room_id = Rooms.room_id;

-- Retrieve total profit
SELECT * FROM total_profit;

-- Create view to find all reservations made in past month
CREATE VIEW monthly_reservations AS
SELECT reservation_id AS 'Reservation ID',
	Reservations.room_id AS 'Room ID',
    Reservations.guest_id AS 'Guest ID',
    DATE_FORMAT(reservation_date, "%d/%l/%Y") AS 'Reservation Date',
    DATE_FORMAT(check_out_date, "%d/%l/%Y") AS 'Checkout Date'
FROM Reservations
WHERE reservation_date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
ORDER BY reservation_date;

-- Retrieve all reservations made in past month
SELECT * FROM monthly_reservations;

-- Search for a guest by partial details match in case of forgotten details (e.g. email)
SELECT * FROM Guests
WHERE email LIKE '%@hotmail.com%'
ORDER BY last_name;

-- Procedure to check for double booking errors/if room is already reserved
DELIMITER $$
CREATE PROCEDURE CheckDoubleBooking(IN roomId INT, IN resDate DATE, IN chkOutDate DATE)
BEGIN
	DECLARE conflict INT DEFAULT 0;
    SELECT COUNT(*) INTO conflict
    FROM Reservations
    WHERE room_id = roomId
		AND (reservation_date < chkOutDate AND check_out_date > resDate);
	IF conflict > 0 THEN
		SELECT 'ERROR: Double booking detected. Please check reservation details.' AS Message;
	ELSE
		SELECT 'No duplicate bookings found.' AS Message;
	END IF;
END $$
DELIMITER ;

-- Will return an error as room is already reserved
CALL CheckDoubleBooking(1, '2024-06-01', '2024-06-05');

-- Will not return an error as room is not reserved
CALL CheckDoubleBooking(8, '2024-06-12', '2024-06-14');