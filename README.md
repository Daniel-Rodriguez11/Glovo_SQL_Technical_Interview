# Glovo_SQL_Test
## SQL technical interview for Glovo (food delivery company).
____________________________________________________________________________________________________________________________________________________________________________________

Note: The code must be written on T-SQL and must be scalable.
### 1. Let’s say you have two tables: orders and order_points.
Create an SQL query that shows the distance between the courier starting position and the pickup point, as well as the distance between the pickup point and the delivery point.
The orders table has 1M+ rows; here’s the first row:

| |id|customer_id|courier_id|acceptance_latitude|acceptance_longitude|
|:----|:----|:----|:----|:----|:----|
|642|89383867|1409080|576722|41.4034049|2.1895931|

The order_points table also has 2M+ rows. As FYI there are two types of point, ‘DELIVERY’ and ‘PICKUP’. Here’s an example:
| |order_id|point_type|latitude|longitude|
|:----|:----|:----|:----|:----|
|1280|89383867|PICKUP|41.401148|2.179275|
|1281|89383867|DELIVERY|41.3877537|2.1780942|
____________________________________________________________________________________________
### 2. Build one SQL query to create a cohort of Signup to First Order and show the result. The objective of this cohort is to see, out of the users that signed up in Week N, how many did their first order in Week N+1, N+2, N+3...
The users table has 1M+ rows; here’s the first three rows:

| |id|first_order_id|registration_date|
|:----|:----|:----|:----|
|1|27794|4369678|27/12/2015 22:09|
|2|10418502|21524154|07/12/2018 17:57|
|3|12096535|25486389|12/01/2019 16:19|

The orders table has 1M+ rows; here’s the first row:

| |id|customer_id|activation_time|
|:----|:----|:----|:----|
|1|96667655|4549790|01/02/2020 19:16|

The output must be scalable for all weeks and does not require to be in a cohort format. The end user could potentially use the pivot function from Excel or Google sheets to do so.
_______________________
### 3. Build a sql query to get the difference in days between an order and the previous order that the same customer placed.
The orders table has 1M+ rows; here’s the orders for a specific customer:

| |customer_id|id|activation_time|
|:----|:----|:----|:----|
|98|359954|13117981|11/09/2018 20:05|
|117|359954|36547197|31/03/2019 01:37|
|166|359954|89387881|01/01/2020 13:07|
|289|359954|12285462|30/08/2018 12:03|
|591|359954|8304239|09/06/2018 11:03|
|633|359954|70708941|13/10/2019 19:58|

And here’s the output we expect for this specific example:

| |customer_id|id|activation_time|
|:----|:----|:----|:----|
|359954|605316|2017-03-17 08:03:21.0000000|NULL|
|359954|2169631|2017-10-16 15:41:10.0000000|213|
|359954|7561125|2018-05-21 20:03:22.0000000|217|
|359954|8129714|2018-06-04 19:46:19.0000000|14|
|359954|8141054|2018-06-05 07:57:23.0000000|1|
|359954|8304239|2018-06-09 11:03:29.0000000|4|

