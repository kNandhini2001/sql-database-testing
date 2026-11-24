-- Expected results are predictions, not executed evidence.
-- Q01: All customers
-- Expected: 3 rows
SELECT * FROM customers ORDER BY customer_id;

-- Q02: Chennai customers
-- Expected: Asha, Meera
SELECT customer_name FROM customers WHERE city='Chennai' ORDER BY customer_id;

-- Q03: Distinct cities
-- Expected: Bengaluru, Chennai
SELECT DISTINCT city FROM customers ORDER BY city;

-- Q04: Available products
-- Expected: 10, 20
SELECT product_id FROM products WHERE stock>0 ORDER BY product_id;

-- Q05: Out of stock
-- Expected: 30
SELECT product_id FROM products WHERE stock=0;

-- Q06: Price range
-- Expected: 10, 20
SELECT product_id FROM products WHERE price BETWEEN 500 AND 1000 ORDER BY product_id;

-- Q07: Name pattern
-- Expected: Asha
SELECT customer_name FROM customers WHERE customer_name LIKE 'A%';

-- Q08: Status filter
-- Expected: 101, 102
SELECT order_id FROM orders WHERE status IN ('PLACED','DELIVERED') ORDER BY order_id;

-- Q09: Date filter
-- Expected: 102, 103
SELECT order_id FROM orders WHERE order_date >= DATE '2026-01-02' ORDER BY order_id;

-- Q10: Sort price
-- Expected: 30, 10, 20
SELECT product_id FROM products ORDER BY price DESC;

-- Q11: Customer count
-- Expected: 3
SELECT COUNT(*) FROM customers;

-- Q12: Total stock
-- Expected: 15
SELECT SUM(stock) FROM products;

-- Q13: Average price
-- Expected: 3166.666...
SELECT AVG(price) FROM products;

-- Q14: Minimum price
-- Expected: 500
SELECT MIN(price) FROM products;

-- Q15: Maximum price
-- Expected: 8000
SELECT MAX(price) FROM products;

-- Q16: Group by city
-- Expected: Bengaluru 1; Chennai 2
SELECT city,COUNT(*) FROM customers GROUP BY city ORDER BY city;

-- Q17: Having
-- Expected: Chennai
SELECT city FROM customers GROUP BY city HAVING COUNT(*)>1;

-- Q18: Orders by status
-- Expected: Each status has 1
SELECT status,COUNT(*) FROM orders GROUP BY status ORDER BY status;

-- Q19: Order quantities
-- Expected: 101:3; 102:1; 103:1
SELECT order_id,SUM(quantity) FROM order_items GROUP BY order_id ORDER BY order_id;

-- Q20: Order totals
-- Expected: 101:2000; 102:500; 103:8000
SELECT order_id,SUM(quantity*unit_price) FROM order_items GROUP BY order_id ORDER BY order_id;

-- Q21: Inner join
-- Expected: 101 Asha; 102 Asha; 103 Ravi
SELECT o.order_id,c.customer_name FROM orders o JOIN customers c ON c.customer_id=o.customer_id ORDER BY o.order_id;

-- Q22: Left join
-- Expected: 1:2; 2:1; 3:0
SELECT c.customer_id,COUNT(o.order_id) FROM customers c LEFT JOIN orders o ON o.customer_id=c.customer_id GROUP BY c.customer_id ORDER BY c.customer_id;

-- Q23: Customers without orders
-- Expected: 3
SELECT c.customer_id FROM customers c LEFT JOIN orders o ON o.customer_id=c.customer_id WHERE o.order_id IS NULL;

-- Q24: Product join
-- Expected: 4 rows
SELECT i.order_id,p.product_name FROM order_items i JOIN products p ON p.product_id=i.product_id ORDER BY i.order_id,i.product_id;

-- Q25: Three table join
-- Expected: 4 rows
SELECT c.customer_name,o.order_id,i.product_id FROM customers c JOIN orders o ON c.customer_id=o.customer_id JOIN order_items i ON i.order_id=o.order_id;

-- Q26: Above average price
-- Expected: 30
SELECT product_id FROM products WHERE price>(SELECT AVG(price) FROM products);

-- Q27: Customers with orders
-- Expected: 1, 2
SELECT customer_id FROM customers WHERE customer_id IN (SELECT customer_id FROM orders) ORDER BY customer_id;

-- Q28: Exists
-- Expected: 1, 2
SELECT customer_id FROM customers c WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id=c.customer_id) ORDER BY customer_id;

-- Q29: Not exists
-- Expected: 3
SELECT customer_id FROM customers c WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id=c.customer_id);

-- Q30: Most expensive
-- Expected: 30
SELECT product_id FROM products WHERE price=(SELECT MAX(price) FROM products);

-- Q31: Duplicate email check
-- Expected: 0 rows
SELECT email FROM customers GROUP BY email HAVING COUNT(*)>1;

-- Q32: Null email check
-- Expected: 0 rows
SELECT customer_id FROM customers WHERE email IS NULL;

-- Q33: Orphan orders
-- Expected: 0 rows
SELECT o.order_id FROM orders o LEFT JOIN customers c ON c.customer_id=o.customer_id WHERE c.customer_id IS NULL;

-- Q34: Invalid quantity
-- Expected: 0 rows
SELECT * FROM order_items WHERE quantity<=0;

-- Q35: Noncancelled revenue
-- Expected: 2500
SELECT SUM(i.quantity*i.unit_price) FROM order_items i JOIN orders o ON o.order_id=i.order_id WHERE o.status<>'CANCELLED';

-- Q36: Insert and rollback
-- Expected: 4 before rollback; original 3 restored
SAVEPOINT practice;
INSERT INTO customers VALUES (4,'Test','test@example.com','Pune');
SELECT COUNT(*) FROM customers;
ROLLBACK TO practice;

-- Q37: Update and rollback
-- Expected: 6 before rollback; 5 restored
SAVEPOINT practice;
UPDATE products SET stock=6 WHERE product_id=10;
SELECT stock FROM products WHERE product_id=10;
ROLLBACK TO practice;

-- Q38: Delete and rollback
-- Expected: 2 before rollback; 3 restored
SAVEPOINT practice;
DELETE FROM customers WHERE customer_id=3;
SELECT COUNT(*) FROM customers;
ROLLBACK TO practice;

-- Q39: Table metadata
-- Expected: 4
SELECT COUNT(*) FROM user_tables WHERE table_name IN ('CUSTOMERS','PRODUCTS','ORDERS','ORDER_ITEMS');

-- Q40: Primary key metadata
-- Expected: 4
SELECT COUNT(*) FROM user_constraints WHERE constraint_type='P' AND table_name IN ('CUSTOMERS','PRODUCTS','ORDERS','ORDER_ITEMS');
