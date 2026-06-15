# ⚽ Football Ticket Booking System – Database Design & SQL Queries

A relational database project for a simplified **Football Ticket Booking System**, covering ERD design, table relationships, and intermediate-to-advanced SQL queries (joins, subqueries, aggregates, pattern matching, NULL handling, and pagination).

---

## 📌 Overview

The system manages three core entities:

- **Users** – administrative staff and football fans using the platform
- **Matches** – tournament fixtures, stadium logistics, and ticket pricing
- **Bookings** – individual ticket purchase records linking users to matches

---

## 🗂️ Database Schema

### 1. Users Table

| Field | Type | Description |
|---|---|---|
| `user_id` | INT (PK) | Unique identifier for each registered user |
| `full_name` | VARCHAR(100) | First and last name of the user |
| `email` | VARCHAR(100), UNIQUE | Email address used for login |
| `role` | VARCHAR(50) | Access permission – `Ticket Manager` or `Football Fan` |
| `phone_number` | VARCHAR(20), nullable | Contact mobile number |

### 2. Matches Table

| Field | Type | Description |
|---|---|---|
| `match_id` | INT (PK) | Unique identifier for each football match |
| `fixture` | VARCHAR(150) | Competing teams (e.g., Real Madrid vs Barcelona) |
| `tournament_category` | VARCHAR(100) | League or cup title |
| `base_ticket_price` | DECIMAL(10,2) | Base price for a standard entry seat |
| `match_status` | VARCHAR(50) | `Available`, `Selling Fast`, `Sold Out`, or `Postponed` |

### 3. Bookings Table

| Field | Type | Description |
|---|---|---|
| `booking_id` | INT (PK) | Unique transaction number for the ticket purchase |
| `user_id` | INT (FK → Users.user_id) | The user who made the booking |
| `match_id` | INT (FK → Matches.match_id) | The match being attended |
| `seat_number` | VARCHAR(10), nullable | Allocated seat identifier (e.g., A-12) |
| `payment_status` | VARCHAR(50), nullable | `Pending`, `Confirmed`, `Cancelled`, or `Refunded` |
| `total_cost` | DECIMAL(10,2) | Final invoice price for the booking |

---

## 🔗 Entity Relationship Diagram (ERD)

**Relationships:**

- **One-to-Many** – One `User` → Many `Bookings` (a fan can book tickets for multiple matches)
- **Many-to-One** – Many `Bookings` → One `Match` (a match can have thousands of bookings)
- **Logical One-to-One** – Each `Bookings` row maps exactly one user to one match for a specific seat

📎 **ERD Link (Lucidchart/Draw.io):** _[Add your public, view-only ERD link here]_

---

## 🧠 SQL Queries (`QUERY.sql`)

| # | Query | Concepts Used |
|---|---|---|
| 1 | Available Champions League matches | `WHERE`, filtering |
| 2 | Users named "Tanvir..." or containing "Haque" | `LIKE`, `ILIKE` |
| 3 | Bookings with missing payment status | `IS NULL`, `COALESCE` |
| 4 | Booking details with user & fixture names | `INNER JOIN` |
| 5 | All users with their bookings (incl. fans with none) | `LEFT JOIN` |
| 6 | Bookings priced above the average cost | Subquery, `AVG()` |
| 7 | Top 2 most expensive matches, skipping the highest | `ORDER BY`, `LIMIT`, `OFFSET` |

Full table creation (with PK/FK constraints), sample data inserts, and all queries are in [`QUERY.sql`](./QUERY.sql).

---

## ⚙️ Tech Stack

- **Database:** PostgreSQL (uses `ILIKE`; for MySQL, see the in-file note for Query 2)
- **ERD Tool:** Lucidchart / Draw.io
- **Version Control:** Git & GitHub

---

## 🚀 How to Run

**PostgreSQL:**
```bash
psql -U your_username -d your_database -f QUERY.sql
```

**MySQL:**
```bash
mysql -u your_username -p your_database < QUERY.sql
```

This will create the `Users`, `Matches`, and `Bookings` tables, insert the sample data, and run all 7 queries.

---

## 📁 Project Structure

```
B7A3/
├── QUERY.sql      # Table creation, sample data, and all queries
└── README.md      # Project documentation
```

---

## ✅ Submission Links

- **ERD (public view link):** _[Add here]_
- **GitHub Repository (public):** _[Add here]_
- **Video Walkthrough (public):** _[Add here]_

---

## 👤 Author

**A A Masud**
