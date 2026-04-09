# 🛒 E-Commerce Order Management System (SQL Project)

## 📌 Project Overview

This project is an **advanced Microsoft SQL Server database design** for an **E-Commerce Order Management System**.
It simulates real-world business operations including **customer management, product catalog, order processing, payments, and shipping**.

The database is designed with:

* **Optimized schema (minimum tables, maximum attributes)**
* **Scalable structure for analytics and reporting**
* **Real-world business logic implementation**

---

## 🎯 Objectives

* Design a **normalized and production-ready database schema**
* Support **end-to-end order lifecycle**
* Enable **advanced SQL querying and reporting**
* Prepare dataset for **Power BI dashboards and analytics**

---

## 🗂️ Database Schema

The system consists of **6 core tables**:

| Table Name | Description                                 |
| ---------- | ------------------------------------------- |
| Customers  | Stores customer profile and account details |
| Products   | Product catalog with pricing and inventory  |
| Orders     | Master order records                        |
| OrderItems | Line-level order details                    |
| Payments   | Payment transaction records                 |
| Shipments  | Delivery and shipping tracking              |

---

## 🧩 Entity Relationship Overview

```
Customers → Orders → OrderItems → Products
Orders → Payments
Orders → Shipments
```

---

## 🛠️ Technologies Used

* Microsoft SQL Server
* T-SQL (Transact-SQL)
* Relational Database Design
* Power BI (for visualization – optional extension)

---

📄 Table Structure

👤 Customers

Stores customer personal and account details.

Key Fields:

* CustomerID (Primary Key)
* CustomerCode (Unique)
* Email (Unique)
* LoyaltyPoints
* AccountStatus
* RegistrationDate

---

📦 Products

Stores product information and inventory details.

Key Fields:

* ProductID (Primary Key)
* SKU (Unique)
* Category, SubCategory
* UnitPrice, DiscountPercent, FinalPrice
* StockQuantity, ReorderLevel

---

🧾 Orders

Stores high-level order information.

Key Fields:

* OrderID (Primary Key)
* CustomerID (Foreign Key)
* OrderStatus
* PaymentStatus
* TotalAmount, DiscountAmount, TaxAmount, GrandTotal

---

🛍️ OrderItems

Stores product-level details for each order.

Key Fields:

* OrderItemID (Primary Key)
* OrderID (Foreign Key)
* ProductID (Foreign Key)
* Quantity, UnitPrice
* LineTotal, TaxAmount, FinalAmount

---

💳 Payments

Tracks payment transactions.

Key Fields:

* PaymentID (Primary Key)
* OrderID (Foreign Key)
* TransactionID (Unique)
* PaymentMethod
* AmountPaid
* PaymentStatus

---

🚚 Shipments

Handles order delivery tracking.

Key Fields:

* ShipmentID (Primary Key)
* OrderID (Foreign Key)
* TrackingNumber
* CourierName
* ShippingStatus
* DeliveredDate

---

🔑 Key Features

✅ Normalized relational database design
✅ Supports **multiple payment methods**
✅ Tracks **order lifecycle (Pending → Delivered)**
✅ Handles **inventory and pricing logic**
✅ Includes **customer loyalty system**
✅ Ready for **analytics and BI tools**

---

📊 Sample Use Cases

* 📈 Revenue analysis
* 🛒 Top-selling products
* 👥 Customer segmentation (RFM analysis)
* 🚚 Delivery performance tracking
* 💳 Payment method analysis
* 🔁 Customer retention & churn

---

📁 Project Structure

```
/Ecommerce-SQL-Project
│── schema.sql        # Table creation scripts
│── sample_data.sql   # Insert scripts (optional)
│── queries.sql       # Analytical queries
│── README.md         # Project documentation
```

---

🚀 Future Enhancements

* Stored Procedures for order processing
* Triggers for inventory updates
* Index optimization for performance
* Advanced RFM segmentation
* Integration with Power BI dashboard

---

👨‍💻 Author

**Ajit Kumar Giri**

SQL Developer | Data Analyst

---

⭐ If you like this project

Give it a ⭐ on GitHub and feel free to fork or contribute!

