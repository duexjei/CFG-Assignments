# CGFdegree Assignment 3: SQL ✨
## Question❓
### Design and implement a database that solves a specific problem as per your chosen theme. 
Requirements:
- ⭐ Create a database with at least 3 tables with several columns, use good naming
conventions
- ⭐ Link tables using primary and foreign keys effectively
- ⭐ Populate the database with at least 8 rows of mock data per table to show use of DML
commands. The data does not need to be real or accurate.
- ⭐ Keep in your code all commands you used to set up your database, tables, and all demo
queries. You can comment out queries you do not want to be auto run
- ⭐ Use at least 3 different data types while creating tables
- ⭐ Use at least 2 constraints while creating tables, not including primary key or foreign key
- ⭐ Use at least 3 queries to insert data
- ⭐ Use at least 5 queries to retrieve data
- ⭐ Use at least 1 query to delete data
- ⭐ Use at least 2 aggregate functions
- ⭐ Use at least 2 joins
- ⭐ Use at least 2 additional in-built functions (to the two aggregate functions already
counted in previous point)
- ⭐ Use data sorting for majority of queries with ORDER BY
- ⭐ Create and use one stored procedure or function to achieve a goal
- ⭐ Normalise the DB by splitting the data out in tables where appropriate and not
containing any duplicate data.
- ⭐ Provide a creative scenario of use
  
Scenario of Use:
> I want to help a boutique hotel manage its room inventory, guest information, and reservations efficiently. To do this, I will store rooms (room_id, room_number, room_type, price_per_night, availability_status) to keep track of each room's details and availability. I will also store guests (guest_id, first_name, last_name, email, phone_number, check_in_date) to maintain records of each guest who stays in the hotel. I will also have a reservations table (reservation_id, room_id, guest_id, reservation_date, check_out_date) to record all reservations made, linked to specific rooms. The database will prevent double bookings by implementing a procedure that checks for overlapping reservation dates and alerts the user if a conflict is detected. I will create a function to calculate the total profit from all reservations within a specific date range, to help track financial performance. I will insert mock data into the Rooms, Guests, and Reservations tables to populate the database, and will write queries to add new reservations, update room availability, and delete old reservation records. I will use aggregate functions to count the total number of reservations, total profit etc. I will utilise built-in date functions to find reservations made within a certain period and string functions to search for guests using incomplete details. I will connect the tables using IDs as primary keys and link reservations to rooms and guests through foreign keys. For data integrity, room_number and email will be unique, and NOT NULL constraints will be used where appropriate. I will use data types including INT for IDs, VARCHAR for text fields, DECIMAL for prices, and BOOLEAN for availability. 

Requirements met:
- [x] Create a database with at least 3 tables with several columns, use good naming
conventions

The code creates a database named 'HotelManagement' and defines three tables: ```Rooms```, ```Guests```, and ```Reservations```. Each table has multiple columns with clear names, following standard naming conventions.

- [x] Link tables using primary and foreign keys effectively

The tables are linked using primary and foreign keys. The 'Reservation' table has ```room_id``` and ```guest_id``` columns, which are foreign keys referencing the ```room_id``` column in the ```Rooms``` table and the ```guest_id``` column in the ```Guests``` table. This ensures referential integrity and links reservations to specific rooms and guests.

- [x] Populate the database with at least 8 rows of mock data per table to show use of DML
commands. The data does not need to be real or accurate.

The code includes ```INSERT INTO``` statements to add eight rows of mock data into each of the tables, showing use of DML commands.

- [x] Keep in your code all commands you used to set up your database, tables, and all demo
queries. You can comment out queries you do not want to be auto run

The code includes all commands necessary to set up the database and tables, insert data, and run queries. I have also included comments for extra clarification.

- [x] Use at least 3 different data types while creating tables

The code uses at least three different data types, including ```INT``` for integer values, ```VARCHAR()``` for variable-length character strings, ```DECIMAL()``` for prices, ```BOOLEAN``` for hotel room availability, and ```DATE``` for date values.

- [x] Use at least 2 constraints while creating tables, not including primary key or foreign key

The code includes the ```UNIQUE``` constraint on ```room_number``` and ```email```, and the ```CHECK``` constraint to ensure ```check_out_date``` is later than the ```reservation_date``` in the ```Reservations``` table.

- [x]  Use at least 3 queries to insert data

The code includes ```INSERT INTO``` statements to populate the three tables with mock data.

- [x] Use at least 5 queries to retrieve data

The code includes ```SELECT``` queries to retrieve data from the database. These retrieve room information, reservation history, recent reservations, and guest lookup.

- [x] Use at least 1 query to delete data

A 'DELETE' query is included to remove reservation records from the 'Reservations' table.

- [x] Use at least 2 aggregate functions

Aggregate functions such as ```COUNT(*)``` to count the total number of reservations and ```SUM(price_per_night * DATEDIFF(check_out_date, reservation_date))``` to calculate total profit from reservations.

- [x] Use at least 2 joins

```JOIN``` operations are used to combine data from the ```Reservations``` table with the ```Guests``` table and the ```Rooms``` table. These retrieve information on reservation details along with guests' names and room details.

- [x] Use at least 2 additional in-built functions (to the two aggregate functions already

counted in the previous point)
```DATEDIFF``` is used to calculate the difference in days between two dates and ```DATE_SUB``` to subtract from the current date to find reservations made within a certain period.

- [x] Use data sorting for majority of queries with ORDER BY

```ORDER BY``` is used to sort retrieved data e.g. sorting available rooms by room number and sorting reservation history by reservation date.

- [x] Create and use one stored procedure or function to achieve a goal

The procedure ```CheckDoubleBooking``` is created to check for double bookings and returns a message if a conflict is found.

- [x] Normalise the DB by splitting the data out in tables where appropriate and not
containing any duplicate data.

The database follows normalisation rules by separating data into separate tables (```Rooms```, ```Guests```, ```Reservations```) without repeating data.

### Project Set-Up 🤖
1. Ensure MySQL is installed on your system. Follow the installation instructions for your operating system [here](https://dev.mysql.com/downloads/mysql/).
2. Open MySQL Workbench or your preferred SQL client.
3. Copy and paste the provided SQL into the query editor. Execute the commands step-by-step (after the ; symbol) to create the database and tables.
4. Run the 'INSERT INTO' commands to populate the tables with mock data.
5. Use the provided 'SELECT' queries to interact with the database and verify its functionality.
6. Test the 'UPDATE' and 'DELETE' commands to modify and remove data.
7. Create and test the stored procedure to check for double bookings.
8. Ensure all commands execute successfully and the database operates as expected.

### Step-by-Step Walkthrough

**1. Create the initial database**
```
  CREATE DATABASE HotelManagement;
```
``` 
USE HotelMangement
```
- This sets the context to the newly created database, so all commands will be executed within this database.
  
**2. Create the 'Rooms' table**
```
CREATE TABLE Rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(3) NOT NULL UNIQUE,
    room_type VARCHAR(10) NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    availability_status BOOLEAN NOT NULL DEFAULT TRUE
);
```
- Creates the room ID integer column that automatically increments with each new record and sets it as the primary key.
- Creates a room number column that stores strings, cannot be null, and must be unique.
- Creates a room type column that stores strings and does not allow null values.
- Creates a price per night column that stores decimal price values and does not allow null values.
- Creates an availability status column that stores boolean values, does not allow null values, and defaults to TRUE (empty room).
  
**3. Create the Guests table**
```
CREATE TABLE Guests (
    guest_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15),
    check_in_date DATE
);
```
- Creates similar values as described in Step 2.
  
**4. Create the Reservations table**
```
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
```
- Creates similar values to those in Step 2 & 3.
- Sets the room ID and guest ID to foreign keys.
- Adds a check constraint to ensure that the checkout date is later than the reservation date to minimise errors.
  
**5. Insert data into tables**
```
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
```
- Inserts 8 rows of data into the 'Rooms' table
```
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
```
- Inserts 8 rows of data into the 'Guests' table
```
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
```
- Inserts data into the 'Reservations' table
  
**6. Retrieve data**
```
CREATE VIEW available_rooms AS
SELECT room_id AS 'Room ID',
	room_number AS 'Room Number', 
    room_type AS 'Room Type', 
    price_per_night AS 'Price Per Night (£)', 
    availability_status AS 'Availability'
FROM Rooms
WHERE availability_status = TRUE ORDER BY room_number;
```
- Creates a view that can be easily executed repeatedly
- Uses aliases for a nicer and more readable format
- Retrieves all data from all available rooms from the 'Rooms' table, sorted by the room number
```
SELECT * FROM available_rooms;
```
- Utilises the view
```
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
```
- Retrieves reservation records from a guest's email address, including first name and last name, and sorted by reservation date
- Creates a view that can be easily executed repeatedly
- Uses aliases for a nicer and more readable format
```
SELECT * FROM guest_reservation_history;
```
- Utilises the view
```
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
```
- Retrieves all reservation records along with corresponding room number and room type, sorted by reservation date
- Creates a view that can be easily executed repeatedly
- Uses aliases for a nicer and more readable format
```
SELECT * FROM room_details;
```
- Utilises the view
```
CREATE VIEW monthly_reservations AS
SELECT reservation_id AS 'Reservation ID',
	Reservations.room_id AS 'Room ID',
    Reservations.guest_id AS 'Guest ID',
    DATE_FORMAT(reservation_date, "%d/%l/%Y") AS 'Reservation Date',
    DATE_FORMAT(check_out_date, "%d/%l/%Y") AS 'Checkout Date'
FROM Reservations
WHERE reservation_date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
ORDER BY reservation_date;
```
- Retrieves all reservation records where the reservation date is within the last month, sorted by reservation date
- Creates a view 
- Uses aliases for better readability
- Date formatted for better presentation
```
SELECT * FROM Guests 
WHERE email LIKE '%hotmail.com%' 
ORDER BY last_name;
```
- Retrieves guest records using incomplete/missing details (in this case, email) in case of incorrectly entered reservation information during booking
  
**7. Update data**
```
UPDATE Rooms SET availability_status = FALSE WHERE room_id = 1;
```
- Updates availability status boolean to FALSE to indicate the room is now booked and no longer available, and updates the system
  
**8. Delete data**
```
DELETE FROM Reservations WHERE reservation_id = 1;
```
- Deletes potentially old or outdated reservation records according to reservation ID number

**9. Aggregate functions**
```
SELECT COUNT(*) AS 'Total Reservations' FROM Reservations;
```
- Counts the total number of records in the 'Reservations' table
```
CREATE VIEW total_profit AS
SELECT SUM(Rooms.price_per_night * DATEDIFF(Reservations.check_out_date, Reservations.reservation_date)) AS 'Total Profit (£)'
FROM Reservations
JOIN Rooms on Reservations.room_id = Rooms.room_id;
```
- Calculates the total profit generated from all reservations by multiplying the price per night by the number of nights stayed (using DATEDIFF) for each reservation

**10. Create and use stored procedure**
```
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
```
- Defines a stored procedure with three input parameters
- BEGIN/END encapsulates the body of the procedure
- Declares an integer variable 'conflict' and initialises it to 0
- Counts the number of overlapping reservations for the specified room and stores the result in the 'conflict' variable
- Checks the value of conflict and returns a message based on whether or not conflicts were found
```
CALL CheckDoubleBooking(1, '2024-06-01', '2024-06-05');
```
- Example of returning an error where room is already reserved for these dates
```
CALL CheckDoubleBooking(8, '2024-06-12', '2024-06-14');
```
- Example of not returning an error as room is not reserved
