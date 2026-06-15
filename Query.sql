
-- DROP TABLES IF THEY ALREADY EXIST TO PREVENT CONFLICTS
-- Order matters: drop child tables (with FKs) before parent tables.

DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Users;

-- 1. CREATE USERS TABLE

CREATE TABLE Users (
    user_id INT PRIMARY KEY, 
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE, 
    role VARCHAR(20) NOT NULL
        CHECK (role IN ('Ticket Manager', 'Football Fan')),
    phone_number VARCHAR(20) 
);



-- 2. CREATE MATCHES TABLE

CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    fixture VARCHAR(150) NOT NULL, 
    tournament_category VARCHAR(50)  NOT NULL,
    base_ticket_price DECIMAL(10,2) NOT NULL
                        CHECK (base_ticket_price >= 0),
    match_status VARCHAR(20) NOT NULL
                         CHECK (match_status IN
                               ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);


-- 3. CREATE BOOKINGS TABLE

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    user_id INT NOT NULL, 
    match_id INT NOT NULL,
    seat_number VARCHAR(10), 
    payment_status VARCHAR(20)
                    CHECK (payment_status IN
                          ('Pending', 'Confirmed', 'Cancelled', 'Refunded')),
    total_cost DECIMAL(10,2) NOT NULL
                    CHECK (total_cost >= 0),

    CONSTRAINT fk_bookings_user
        FOREIGN KEY (user_id) REFERENCES Users(user_id),

    CONSTRAINT fk_bookings_match
        FOREIGN KEY (match_id) REFERENCES Matches(match_id)
);




-- DATA SEEDING: INSERT SAMPLE DATA INTO USERS

INSERT INTO Users (user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);


-- DATA SEEDING: INSERT SAMPLE DATA INTO MATCHES

INSERT INTO Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');




-- DATA SEEDING: INSERT SAMPLE DATA INTO BOOKINGS

INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);






-- QUERY 1
-- Retrieve all upcoming Champions League matches that are 'Available'.

SELECT match_id, fixture, base_ticket_price
FROM Matches
WHERE tournament_category = 'Champions League'
  AND match_status = 'Available';



-- QUERY 2
-- Find users whose full name starts with 'Tanvir' OR contains 'Haque'
SELECT user_id, full_name, email
FROM Users
WHERE full_name LIKE 'Tanvir%'
   OR full_name ILIKE '%Haque%';



-- QUERY 3
-- Retrieve bookings where payment_status is NULL, replacing the NULL
-- with the label 'Action Required'.
SELECT booking_id,
       user_id,
       match_id,
       COALESCE(payment_status, 'Action Required') AS systematic_status
FROM Bookings
WHERE payment_status IS NULL;
