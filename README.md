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

2. Open your preferred SQL Server Management Studio (SSMS) or another SQL tool.

3. Execute the supply_chain_schema.sql script provided in the repository to set up the database schema, tables, relationships, and stored procedures.

4. The database is now ready to be populated with data.


## Usage

### Product Management

- **Add a new product**: Use the `InsertProduct` stored procedure to add new products to the inventory.
- **Update a product**: Modify product details using the `UpdateProduct` procedure.
- **Delete a product**: Remove a product from the database using the `DeleteProduct` procedure.
- **View products**: Query the `Products` table or use `GetProducts` stored procedure to retrieve the product list.

### Supplier Management

- **Add a new supplier**: Insert supplier details with the `InsertSupplier` procedure.
- **Update supplier details**: Modify supplier information using the `UpdateSupplier` procedure.
- **Delete a supplier**: Use the `DeleteSupplier` procedure to remove a supplier.
- **View suppliers**: Query the `Suppliers` table or use `GetSuppliers` stored procedure to view supplier data.

### Customer Management

- **Add a new customer**: Use the `InsertCustomer` procedure to add customer details.
- **Update customer details**: Update customer records using the `UpdateCustomer` procedure.
- **Delete a customer**: Use the `DeleteCustomer` procedure to remove a customer.
- **View customers**: Query the `Customers` table or use `GetCustomers` stored procedure to retrieve customer records.

### Order Management

- **Create an order**: Use the `InsertOrder` stored procedure to create a new order, along with `InsertOrderDetails` to specify products in the order.
- **Update an order**: Modify order status or details with the `UpdateOrder` procedure.
- **Delete an order**: Use `DeleteOrder` to remove an order.
- **View orders**: Query the `Orders` table or use `GetOrders` stored procedure to retrieve orders.

### Inventory Management

- **Track inventory**: Use the `GetInventoryLevels` stored procedure to check stock levels.
- **Update inventory**: Adjust stock levels using `UpdateInventory`.

## Stored Procedures

### Product Procedures

- `InsertProduct`: Adds a new product.
- `UpdateProduct`: Updates product details.
- `DeleteProduct`: Removes a product from the system.
- `GetProducts`: Retrieves the list of products.

### Order Procedures

- `InsertOrder`: Adds a new order.
- `InsertOrderDetails`: Links products to orders.
- `UpdateOrder`: Updates order details or status.
- `DeleteOrder`: Deletes an order.
- `GetOrders`: Retrieves order data.

### Supplier Procedures

- `InsertSupplier`: Adds a new supplier.
- `UpdateSupplier`: Updates supplier details.
- `DeleteSupplier`: Removes a supplier.
- `GetSuppliers`: Retrieves supplier data.

### Customer Procedures

- `InsertCustomer`: Adds a new customer.
- `UpdateCustomer`: Updates customer information.
- `DeleteCustomer`: Deletes a customer.
- `GetCustomers`: Retrieves customer records.

### Inventory Procedures

- `UpdateInventory`: Adjusts stock levels for a product.
- `GetInventoryLevels`: Retrieves the current stock levels for all products.

## Contributing

Contributions are welcome! If you would like to contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes and commit them (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
