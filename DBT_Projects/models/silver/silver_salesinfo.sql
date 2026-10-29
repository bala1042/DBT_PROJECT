WITH sales AS (
    SELECT
        sales_id,
        product_sk,
        customer_sk,
        {{ multiply('unit_price', 'quantity') }} AS calucated_gross_amount,
        gross_amount,
        payment_method
    FROM {{ ref('bronze_sales') }}
),
product AS (
    SELECT
        product_sk,
        category
    FROM {{ ref('bronze_product') }}
),
customer as(
    SELECT
        customer_sk,
        gender
    FROM {{ ref('bronze_customer') }}
),
joined_query AS (
SELECT
    b.sales_id,
    b.product_sk,
    b.customer_sk,
    b.gross_amount,
    b.payment_method,
    p.category,
    c.gender
FROM sales b
LEFT JOIN product p
    ON b.product_sk = p.product_sk
LEFT JOIN customer c
    ON b.customer_sk = c.customer_sk )
SELECT
    category,
    gender,
    sum(gross_amount) AS total_sales
FROM joined_query
GROUP BY category, gender
ORDER BY total_sales DESC