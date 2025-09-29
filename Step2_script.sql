-- step2 Scripts from the assignments

-- 1. Top 5 products per region/quarter using RANK()
SELECT 
    customer_id,
    SUM(amount) AS total_revenue,
    ROW_NUMBER() OVER (ORDER BY SUM(amount) DESC) AS row_num,
    RANK() OVER (ORDER BY SUM(amount) DESC) AS revenue_rank,
    DENSE_RANK() OVER (ORDER BY SUM(amount) DESC) AS dense_rank,
    PERCENT_RANK() OVER (ORDER BY SUM(amount) DESC) AS percentage_rank
FROM 
    transactions
GROUP BY 
    customer_id;


-- 2. Running monthly sales totals using SUM() and over()
SELECT 
    TO_CHAR(TO_DATE(sale_date, 'DD-MM-YYYY'), 'MM-YYYY') AS sale_month,
    SUM(TO_NUMBER(amount)) AS total_sales,
    SUM(SUM(TO_NUMBER(amount))) OVER (
        ORDER BY TO_CHAR(TO_DATE(sale_date, 'DD-MM-YYYY'), 'MM-YYYY')
    ) AS running_total,
    AVG(SUM(TO_NUMBER(amount))) OVER (
        ORDER BY TO_CHAR(TO_DATE(sale_date, 'DD-MM-YYYY'), 'MM-YYYY')
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS three_month_moving_avg,
    MIN(SUM(TO_NUMBER(amount))) OVER (
        ORDER BY TO_CHAR(TO_DATE(sale_date, 'DD-MM-YYYY'), 'MM-YYYY')
    ) AS min_monthly_sales,
    MAX(SUM(TO_NUMBER(amount))) OVER (
        ORDER BY TO_CHAR(TO_DATE(sale_date, 'DD-MM-YYYY'), 'MM-YYYY')
    ) AS max_monthly_sales
FROM 
    transactions
GROUP BY 
    TO_CHAR(TO_DATE(sale_date, 'DD-MM-YYYY'), 'MM-YYYY')
ORDER BY 
    sale_month;


-- 4. Customer quartiles
SELECT 
    customer_id,
    SUM(amount) AS total_revenue,
    NTILE(4) OVER (ORDER BY SUM(amount) DESC) AS revenue_quartile,
    CUME_DIST() OVER (ORDER BY SUM(amount) DESC) AS cumulative_distribution
FROM 
    transactions
GROUP BY 
    customer_id;

