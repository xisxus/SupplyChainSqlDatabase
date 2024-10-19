# SupplyChainSqlDatabase

SupplyChainSqlDatabase is a SQL-based project designed to manage and optimize supply chain operations. This repository includes all essential database structures, including tables, relationships, views, and stored procedures necessary for managing inventory, suppliers, orders, and customers in a supply chain system.

## Table of Contents
- [Features](#features)
- [Database Schema](#database-schema)
- [Installation](#installation)
- [Usage](#usage)
  - [Product Management](#product-management)
  - [Supplier Management](#supplier-management)
  - [Customer Management](#customer-management)
  - [Order Management](#order-management)
  - [Inventory Management](#inventory-management)
- [Stored Procedures](#stored-procedures)
  - [Product Procedures](#product-procedures)
  - [Order Procedures](#order-procedures)
  - [Supplier Procedures](#supplier-procedures)
  - [Customer Procedures](#customer-procedures)
  - [Inventory Procedures](#inventory-procedures)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Comprehensive Supply Chain Management**: Manage products, suppliers, customers, orders, and inventory levels.
- **Product Inventory Tracking**: Keep track of stock levels, reorders, and available products.
- **Order Management**: Handle customer orders, status updates, and shipping details.
- **Supplier Relationship Management**: Track supplier data, deliveries, and order fulfillment.
- **Customer Management**: Maintain customer records, including order history and preferences.
- **Reporting Tools**: Generate detailed reports on sales, inventory levels, and supplier performance.

## Database Schema

The database schema consists of the following key entities and relationships:

- **Products**: Stores details about each product, including `ProductId`, `ProductName`, `Price`, `StockLevel`, and `SupplierId`.
- **Suppliers**: Contains supplier data such as `SupplierId`, `SupplierName`, `ContactInfo`, and the products they supply.
- **Customers**: Holds customer information like `CustomerId`, `CustomerName`, `Address`, and `ContactInfo`.
- **Orders**: Tracks orders with `OrderId`, `CustomerId`, `OrderDate`, `TotalAmount`, and order statuses.
- **OrderDetails**: Links orders and products through `OrderDetailId`, `OrderId`, `ProductId`, and `Quantity`.
- **Inventory**: Tracks product inventory and stock levels using `InventoryId`, `ProductId`, and `StockLevel`.

### Relationships
- One-to-many relationships between `Suppliers` and `Products`.
- One-to-many relationships between `Customers` and `Orders`.
- Many-to-many relationships between `Orders` and `Products`, managed through `OrderDetails`.
- One-to-many relationships between `Products` and `Inventory`.

## Installation

To set up the SupplyChainSqlDatabase:

1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/xisxus/SupplyChainSqlDatabase.git
