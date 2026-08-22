# 🪙 GOLD_DIGGER — E-Commerce SQL Database Project

A relational database project simulating a simple e-commerce system — customers, orders, products, and order details — built to practice core SQL concepts: schema design, CRUD operations, joins, aggregate functions, and foreign key relationships.

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Entity Relationship Diagram](#-entity-relationship-diagram)
- [Database Schema](#-database-schema)
- [Tech Stack](#-tech-stack)
- [Getting Started](#-getting-started)
- [Features & Operations Covered](#-features--operations-covered)
- [Sample Queries & Output](#-sample-queries--output)
- [Known Limitations / Notes](#-known-limitations--notes)
- [Possible Enhancements](#-possible-enhancements)
- [Project Structure](#-project-structure)
- [Author](#-author)
- [License](#-license)

---

## 📖 Overview

**GOLD_DIGGER** is a beginner-to-intermediate level SQL project that models four related tables of a basic online store:

| Table | Purpose |
|---|---|
| `Customers` | Stores customer contact and address details |
| `Orders` | Stores orders placed by customers, with date and total amount |
| `Products` | Stores the product catalog with price and stock |
| `OrderDetails` | Line-item table linking orders to products (many-to-many bridge) |

The project demonstrates:
- Table creation with primary keys and foreign key constraints
- `INSERT`, `SELECT`, `UPDATE`, `DELETE` (full CRUD) on every table
- Filtering with `WHERE`, `BETWEEN`, and date conditions
- Sorting with `ORDER BY`
- Aggregate functions: `MAX()`, `MIN()`, `AVG()`, `SUM()`, `COUNT()`
- Multi-table `JOIN` with `GROUP BY` for reporting (top-selling products, revenue, etc.)

---

## 🗺 Entity Relationship Diagram

```
┌───────────────┐        ┌───────────────┐        ┌───────────────┐
│   Customers   │        │    Orders     │        │  OrderDetails │
├───────────────┤        ├───────────────┤        ├───────────────┤
│ CustomerID PK │◄──────┐│ OrderID    PK │◄──────┐│ OrderDetailID │
│ Name          │       └│ CustomerID FK │       └│ PK            │
│ Email         │        │ OrderDate     │        │ OrderID    FK │
│ Address       │        │ TotalAmount   │        │ ProductID  FK │
└───────────────┘        └───────────────┘        │ Quantity      │
                                                   │ SubTotal      │
                          ┌───────────────┐        └───────────────┘
                          │   Products    │                ▲
                          ├───────────────┤                │
                          │ ProductID  PK │◄───────────────┘
                          │ ProductName   │
                          │ price         │
                          │ stock         │
                          └───────────────┘
```

> Note: `Orders.CustomerID` is not currently enforced with a `FOREIGN KEY` constraint in the script (see [Known Limitations](#-known-limitations--notes)) — the diagram shows the intended relationship.

---

## 🧱 Database Schema

<details>
<summary><b>Customers</b></summary>

| Column | Type | Constraint |
|---|---|---|
| CustomerID | INT | PRIMARY KEY, AUTO_INCREMENT |
| Name | VARCHAR(50) | |
| Email | VARCHAR(100) | |
| Address | VARCHAR(150) | |
</details>

<details>
<summary><b>Orders</b></summary>

| Column | Type | Constraint |
|---|---|---|
| OrderID | INT | PRIMARY KEY, AUTO_INCREMENT |
| CustomerID | INT | references `Customers.CustomerID` |
| OrderDate | DATE | |
| TotalAmount | DECIMAL(10,2) | |
</details>

<details>
<summary><b>Products</b></summary>

| Column | Type | Constraint |
|---|---|---|
| ProductID | INT | PRIMARY KEY, AUTO_INCREMENT |
| ProductName | VARCHAR(50) | |
| price | DECIMAL(10,2) | |
| stock | INT | |
</details>

<details>
<summary><b>OrderDetails</b></summary>

| Column | Type | Constraint |
|---|---|---|
| OrderDetailID | INT | PRIMARY KEY, AUTO_INCREMENT |
| OrderID | INT | FOREIGN KEY → `Orders.OrderID` |
| ProductID | INT | FOREIGN KEY → `Products.ProductID` |
| Quantity | INT | |
| SubTotal | DECIMAL(10,2) | |
</details>

---

## 🛠 Tech Stack

- **Database:** MySQL (5.7+ / 8.0)
- **Client:** MySQL Workbench, `mysql` CLI, or any GUI client (DBeaver, HeidiSQL, phpMyAdmin)
- **Language:** Standard SQL (DDL + DML)

---

## 🚀 Getting Started

### Prerequisites
- MySQL Server installed locally, **or** a free-tier cloud MySQL instance (e.g. Aiven, Railway, Clever Cloud, or a local XAMPP/WAMP setup)
- A SQL client (MySQL Workbench is recommended for beginners)

### Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/<your-username>/GOLD_DIGGER.git
   cd GOLD_DIGGER
   ```

2. **Open the SQL file**
   Open `GOLD_DIGGER.sql` in MySQL Workbench (or run it via CLI):
   ```bash
   mysql -u root -p < GOLD_DIGGER.sql
   ```

3. **Run it top to bottom**
   The script creates the database, creates all four tables in the correct order (so foreign keys resolve), inserts sample data, and then runs a series of example queries for each CRUD/reporting operation.

4. **Explore**
   Run individual `SELECT` statements from the file to see each feature in action, or connect a BI tool / dashboard to the resulting database for further practice.

---

## ✅ Features & Operations Covered

| # | Operation | Table(s) |
|---|---|---|
| 1 | Create table with `AUTO_INCREMENT` primary key | All |
| 2 | Bulk `INSERT` of sample records | All |
| 3 | Retrieve all rows (`SELECT *`) | Customers, Orders, Products |
| 4 | Filter by exact match (`WHERE Name = ...`) | Customers |
| 5 | Filter by date/range condition | Orders |
| 6 | Filter by numeric range (`BETWEEN`) | Products |
| 7 | `UPDATE` a specific row | Customers, Orders, Products |
| 8 | `DELETE` a specific row / conditional delete | Customers, Orders, Products |
| 9 | Sort results (`ORDER BY ... DESC`) | Products |
| 10 | Aggregate functions — `MAX`, `MIN`, `AVG`, `SUM` | Orders, Products, OrderDetails |
| 11 | Foreign key relationships | OrderDetails → Orders, Products |
| 12 | Multi-table `JOIN` + `GROUP BY` | OrderDetails + Products |
| 13 | `COUNT()` for frequency reporting | OrderDetails + Products |
| 14 | Business reporting: top-selling products, total revenue | OrderDetails |

---

## 📊 Sample Queries & Output

> The tables below were generated by actually running the schema and queries against a test database, so the numbers reflect the sample data included in the script (adjusted slightly where the original script's row order affects results).

**All customers**

| CustomerID | Name | Email | Address |
|---:|---|---|---|
| 1 | Alice | alice@email.com | 12 MG Road, Surat |
| 2 | Bhavesh | bhavesh@email.com | 103, Station Road, Navsari |
| 3 | Alice | alice.j@email.com | 9 Park Street, Ahmedabad |
| 4 | Kavita | kavita@email.com | 78 Station Road, Vadodara |
| 5 | Rohit | rohit@email.com | 3 Lake View, Rajkot |

**Customers named 'Alice'**

| CustomerID | Name | Email | Address |
|---:|---|---|---|
| 1 | Alice | alice@email.com | 12 MG Road, Surat |
| 3 | Alice | alice.j@email.com | 9 Park Street, Ahmedabad |

**Products sorted by price (descending)**

| ProductID | ProductName | price | stock |
|---:|---|---:|---:|
| 2 | Mechanical Keyboard | 2200.00 | 15 |
| 5 | Bluetooth Speaker | 1899.00 | 10 |
| 3 | USB-C Hub | 1499.00 | 0 |
| 4 | Laptop Stand | 899.00 | 25 |
| 1 | Wireless Mouse | 650.00 | 40 |

**Products priced between ₹500 and ₹2000**

| ProductID | ProductName | price | stock |
|---:|---|---:|---:|
| 1 | Wireless Mouse | 650.00 | 40 |
| 3 | USB-C Hub | 1499.00 | 0 |
| 4 | Laptop Stand | 899.00 | 25 |
| 5 | Bluetooth Speaker | 1899.00 | 10 |

**Order amount statistics**

| MaxOrder | MinOrder | AvgOrder |
|---:|---:|---:|
| 5600.00 | 899.00 | 2879.80 |

**Total revenue (from OrderDetails)**

| TotalRevenue |
|---:|
| 8794.00 |

**Top 3 most-ordered products**

| ProductName | TotalQuantitySold |
|---|---:|
| Wireless Mouse | 5 |
| Mechanical Keyboard | 2 |
| Laptop Stand | 1 |

---

## ⚠️ Known Limitations / Notes

A few things worth being aware of if you extend this project (good talking points if this comes up in an interview or code review):

- **`Orders.CustomerID` has no `FOREIGN KEY` constraint**, so it's possible to insert an order for a customer that was later deleted (this actually happens in the script — Customer 1 is deleted, then later referenced in new orders). Add `FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)` to enforce this.
- **`WHERE OrderDate > 30`** does not correctly filter "orders in the last 30 days" — it compares a `DATE` column to the integer `30`, which is not meaningful in MySQL. The correct version is:
  ```sql
  SELECT * FROM orders
  WHERE OrderDate >= CURDATE() - INTERVAL 30 DAY;
  ```
- **Duplicate customer names** (`Alice` appears twice with different emails) are allowed since `Name` isn't unique — this is intentional in the sample data to demonstrate filtering by a non-unique column, but a real system would key on `CustomerID` or a unique `Email`.
- Deleting a product with `DELETE FROM products WHERE stock = 0` will fail (or leave dangling references) if that product already has rows in `OrderDetails`, since `OrderDetails.ProductID` is a foreign key — run deletes before creating dependent child rows, as the script does.

---

## 🔮 Possible Enhancements

- Add the missing `Orders → Customers` foreign key
- Add `ON DELETE CASCADE` / `ON DELETE SET NULL` policies for safer deletes
- Add a `Categories` table and link it to `Products`
- Add indexes on frequently filtered columns (`Email`, `OrderDate`)
- Wrap common reports (top products, revenue by month) into `VIEW`s or stored procedures
- Connect the database to a small Python (pandas / SQLAlchemy) script to turn this into a mini analytics dashboard

---

## 📁 Project Structure

```
GOLD_DIGGER/
│
├── GOLD_DIGGER.sql     # Full schema + sample data + queries
└── README.md           # Project documentation (this file)
```

---

## 👤 Author

Built as a hands-on SQL practice project — part of ongoing prep for a data analyst role (Python + SQL focus).

---

## 📄 License

This project is open-sourced for learning purposes. Feel free to fork, adapt, and use it in your own portfolio.
