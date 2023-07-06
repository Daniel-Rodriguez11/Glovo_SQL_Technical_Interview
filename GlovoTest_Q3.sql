--SQL Server code for Q3 resolution

SELECT
    o.customer_id,
    o.id,
    o.activation_time,
    DATEDIFF(DAY, LAG(o.activation_time) OVER (PARTITION BY o.customer_id ORDER BY o.activation_time), o.activation_time) AS days_since_previous_order
FROM
    dbo.question3_orders o;
