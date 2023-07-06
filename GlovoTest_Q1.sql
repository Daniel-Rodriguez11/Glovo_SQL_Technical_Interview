--SQL Server code for Q1 resolution
SELECT
    o.id AS order_id,
    p.latitude AS pickup_latitude,
    p.longitude AS pickup_longitude,
    d.latitude AS delivery_latitude,
    d.longitude AS delivery_longitude,
    ROUND(
        6371 * 2 * ASIN(
            SQRT(
                POWER(SIN((RADIANS(p.latitude) - RADIANS(o.acceptance_latitude)) / 2), 2) +
                COS(RADIANS(o.acceptance_latitude)) * COS(RADIANS(p.latitude)) *
                POWER(SIN((RADIANS(p.longitude) - RADIANS(o.acceptance_longitude)) / 2), 2)
            )
        ), 2) AS courier_to_pickup_distanceKM,-- Calculating the distance between the courier and the pickup point
    ROUND(
        6371 * 2 * ASIN(
            SQRT(
                POWER(SIN((RADIANS(d.latitude) - RADIANS(p.latitude)) / 2), 2) +
                COS(RADIANS(p.latitude)) * COS(RADIANS(d.latitude)) *
                POWER(SIN((RADIANS(d.longitude) - RADIANS(p.longitude)) / 2), 2)
            )
        ), 2) AS pickup_to_delivery_distanceKM-- Calculating the distance between the pickup and delivery points
FROM
    dbo.question1_orders o
    JOIN dbo.question1_order_points p ON o.id = p.order_id AND p.point_type = 'PICKUP'-- Joining the orders table with the pickup points table
    JOIN dbo.question1_order_points d ON o.id = d.order_id AND d.point_type = 'DELIVERY';-- Joining the orders table with the delivery points table