-- Create table customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(30),
    region VARCHAR(30)
);

--creating table products
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(30),
    category VARCHAR(30)
);

--creating table transactions
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    sale_date DATE ,
    amount INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Inserting the attributes of Table Customers
INSERT INTO customers VALUES
(1001, 'John Doe', 'Kigali'),
(1002, 'Reece Carter', 'Karongi'),
(1003, 'Luca Ross', 'Kimironko'),
(1004, 'Korede Bello', 'Kagarama'),
(1005, 'Armani Knight', 'Masaka');


-- Inserting the attributes of the Table products
INSERT INTO products VALUES
(2001, 'Pants', 'Clothing'),
(2002, 'Smart phone', 'Electronics'),
(2003, 'Knife', 'Kitchenware'),
(2004, 'Spaghetti', 'Foods'),
(2005, 'Fanta', 'Beverages')

-- Inserting the attributes of the Table transactions
INSERT INTO transactions VALUES
(5, 1002, 2003, '20-09-2025', 800),
(1, 1001, 2004, '15-09-2025', 5000),
(4, 1004, 2005, '19-09-2025', 1500),
(9, 1005, 2004, '25-09-2025', 5000),
(2, 1003, 2001, '17-09-2025', 20000),
(3, 1005, 2002, '18-09-2025', 780000),
(6, 1001, 2001, '25-09-2025', 20000),
(7, 1005, 2003, '22-09-2025', 800),
(8, 1003, 2004, '19-09-2025', 5000);

-- Running total trend
SELECT
    TO_CHAR(TO_DATE(sale_date, 'DD-MM-YYYY'), 'MM-YYYY') AS sale_month,
    SUM(TO_NUMBER(amount)) AS total_sales,
    SUM(SUM(TO_NUMBER(amount))) OVER (ORDER BY TO_CHAR(TO_DATE(sale_date, 'DD-MM-YYYY'), 'MM-YYYY')) AS running_total,
    AVG(SUM(TO_NUMBER(amount))) OVER (
        ORDER BY TO_CHAR(TO_DATE(sale_date, 'DD-MM-YYYY'), 'MM-YYYY')
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS three_month_moving_avg,
    MIN(SUM(TO_NUMBER(amount))) OVER (ORDER BY TO_CHAR(TO_DATE(sale_date, 'DD-MM-YYYY'), 'MM-YYYY')) AS min_monthly_sales,
    MAX(SUM(TO_NUMBER(amount))) OVER (ORDER BY TO_CHAR(TO_DATE(sale_date, 'DD-MM-YYYY'), 'MM-YYYY')) AS max_monthly_sales
FROM transactions
GROUP BY TO_CHAR(TO_DATE(sale_date, 'DD-MM-YYYY'), 'MM-YYYY')
ORDER BY sale_month;
