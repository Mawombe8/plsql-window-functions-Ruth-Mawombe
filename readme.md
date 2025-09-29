## PROBLEM DEFINITION

Business context: A convinience store's sales and sales department in the retail industry.

Data Challenge:The store struggles in knowing and understand the product demanded on the market,sales performance,monthly sales growth and frequent customers in-order to optimize inventory and the overall performance of the store.

Expected Outcome: Enumerating the top products per region, a clear segment for customers including the customer frequency and monthly sales growth for marketing.

## SUCCESS CRITERIA 

We will define these measurable goals using the windows functions.
  Top 5 products per region using RANK() function.
  Running monthly sales totals using SUM() and OVER() functions.
  Month-over-month growth using  LAG() and LEAD() functions.
  Customer quartiles using NTILE(4) function.
  3-month moving averages using AVG() and OVER() functions.

## DATABASE SCHEMA
## Creating table CUSTOMERS and after inserting some values
 Query: create table CUSTOMERS (customer_id int primary key, name varchar(30), region varchar(30));
<img width="1920" height="383" alt="Screenshot (134)" src="https://github.com/user-attachments/assets/c1b04846-2ea6-4d07-a1ed-f767ea75d340" />
## Creating table PRODUCTS and after inserting some values
Query: create table PRODUCTS (product_id int primary key, name varchar(30), category varchar(30));
<img width="1920" height="404" alt="Screenshot (135)" src="https://github.com/user-attachments/assets/0447f09c-b837-468a-882c-03b2e6e716ae" />
## Creating table TRANSACTIONS and after inserting some values
Query: create table TRANSACTIONS (transaction_id int primary key, customer_id int, product_id int, sale_date varchar(30), amount int, 
FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(customer_id),FOREIGN KEY (product_id) REFERENCES PRODUCTS(product_id));
<img width="1920" height="519" alt="Screenshot (137)" src="https://github.com/user-attachments/assets/9d66df70-7fc2-487b-a09f-314c1860e492" />

ER DIAGRAM OF THE STORE
<img width="795" height="871" alt="Screenshot (139)" src="https://github.com/user-attachments/assets/b22f6d04-0574-45a6-801d-344d5c62849d" />

## 1. Top 5 customers by revenue
SELECT customer_id, SUM(amount) AS total_revenue,
       ROW_NUMBER() OVER (ORDER BY SUM(amount) DESC) AS row_num,
       RANK() OVER (ORDER BY SUM(amount) DESC) AS revenue_rank,
       DENSE_RANK() OVER (ORDER BY SUM(amount) DESC) AS dense_rank,
       PERCENT_RANK() OVER (ORDER BY SUM(amount) DESC) AS percentage_rank
FROM transactions
GROUP BY customer_id;
<img width="1920" height="392" alt="Screenshot (140)" src="https://github.com/user-attachments/assets/3d51712f-ec0f-4725-84a6-147c9e8cbfe7" />
Interpretation: It shows from the first customer to the last customer according to the revenue or the total revenue they spent in the store.

## 4. Customer segmentation
SELECT customer_id, SUM(amount) AS total_revenue,
       NTILE(4) OVER (ORDER BY SUM(amount) DESC) AS revenue_quartile,
       CUME_DIST() OVER (ORDER BY SUM(amount) DESC) AS cumulative_distribution
FROM transactions
GROUP BY customer_id;
<img width="1920" height="431" alt="Screenshot (138)" src="https://github.com/user-attachments/assets/afa3446d-30cd-4442-8ed4-5ccd11a560ae" />
Interpretation: We observe the classifying of customers into quartiles (Q1= UPPER 25%) and their cumulative distribution with reference to 
their total revenue of the products they purchased in the convinience store which aids in improving the store's performance.

## RESULTS ANALYSIS

Descriptive (What happened?)
Foods products was the most purchased.
Major sales occurred on September 18th with a 780,000 Rwf transaction.

Diagnostic (Why?)
Electronics had higher transaction value but fewer transaction.
Peple from all regions were very interested in the food.

Prescriptive (What next?)
Develop bundles for electronics to increase frequency.
Analyse the September 18th transaction to understand if it implements a sustainable business.
Improve marketing of regional top products.

## REFERENCES


	Computer science s6 student's book ,   
	https://youtu.be/Ww71knvhQ-s?si=AbPDAPB9vy_UnNZz ,  
	https://mode.com/sql-tutorial/sql-window-functions ,   
	[L-G-0012901204-0037023834.pdf](https://github.com/user-attachments/files/22594786/L-G-0012901204-0037023834.pdf)
	https://dev.mysql.com/doc/refman/8.4/en/window-functions-usage.html ,
	https://www.datacamp.com/cheat-sheet/sql-window-functions-cheat-sheet, 
	Jonathan Gennick, SQL Pocket Guide, 3rd Edition,  
	[Chapter 01 - SQL Windowing.sql](https://github.com/user-attachments/files/22593196/Chapter.01.-.SQL.Windowing.sql), 
	
	https://www.geeksforgeeks.org/sql/window-functions-in-sql/ ,  
