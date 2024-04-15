CREATE TABLE orders (customer_id INTEGER, total_cost FLOAT);
INSERT INTO orders (43563, 734.12);
INSERT INTO orders (65758, 211.15);
INSERT INTO orders (23235, 1264.98);
INSERT INTO orders (43563, 583.23);
INSERT INTO orders (89786, 278.66);
INSERT INTO orders (13253, 401.97);
INSERT INTO orders (98765, 1042.23);
INSERT INTO orders (23235, 699.23);
INSERT INTO orders (43563, 935.35);
INSERT INTO orders (88354, 375.09);

-- support subsequently definition (defer define)

WITH multiple_order_totals AS (
   SELECT customer_id, SUM(total_cost) AS total_spend
   FROM orders
   WHERE customer_id IN (SELECT customer_id FROM multiple_orders) 
   GROUP BY customer_id
),
multiple_orders AS (
   SELECT customer_id, COUNT(*) AS order_count
   FROM orders
   GROUP BY customer_id
   HAVING COUNT(*) > 1
)
SELECT * FROM multiple_order_totals
ORDER BY total_spend DESC;
