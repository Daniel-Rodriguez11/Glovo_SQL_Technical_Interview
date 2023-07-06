--SQL Server code for Q2 resolution

WITH cohort_items AS (
  SELECT
    DATEADD(WEEK, DATEDIFF(WEEK, 0, O.activation_time), 0) AS cohort_week,
    customer_id
  FROM (
    SELECT
      customer_id,
      MIN(activation_time) AS activation_time
    FROM dbo.question2_orders
    GROUP BY customer_id
  ) O
),
user_activities AS (
  SELECT
    U.id AS user_id,
    DATEDIFF(WEEK, DATEADD(WEEK, DATEDIFF(WEEK, 0, U.registration_date), 0), C.cohort_week) AS week_number,
    C.cohort_week -- Include cohort_week column
  FROM dbo.question2_users U
  LEFT JOIN cohort_items C ON U.id = C.customer_id
  GROUP BY U.id, DATEDIFF(WEEK, DATEADD(WEEK, DATEDIFF(WEEK, 0, U.registration_date), 0), C.cohort_week), C.cohort_week
),
cohort_size AS (
  SELECT
    cohort_week,
    COUNT(1) AS num_users
  FROM cohort_items
  GROUP BY cohort_week
),
retention_table AS (
  SELECT
    C.cohort_week,
    A.week_number,
    COUNT(1) AS num_users
  FROM user_activities A
  LEFT JOIN cohort_items C ON A.user_id = C.customer_id
  GROUP BY C.cohort_week, A.week_number
),
week_users AS (
  SELECT
    cohort_week,
    week_number,
    COUNT(1) AS num_users
  FROM user_activities
  GROUP BY cohort_week, week_number
)
SELECT
  B.cohort_week,
  B.week_number,
  S.num_users AS total_users,
  W.num_users AS week_users,
  B.num_users * 100.0 / S.num_users AS percentage
FROM retention_table B
LEFT JOIN cohort_size S ON B.cohort_week = S.cohort_week
LEFT JOIN week_users W ON B.cohort_week = W.cohort_week AND B.week_number = W.week_number
WHERE B.cohort_week IS NOT NULL
ORDER BY B.cohort_week, B.week_number;
