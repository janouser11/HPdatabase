-- Question 1
select Customer_Name
from S_Customer_t,S_ORDER_t
where s_customer_t.customer_id = S_ORDER_t.customer_id

-- Question 2
select product_description
from s_product_t, s_order_line_t, s_order_t
where s_product_t.product_id = s_order_line_t.product_id
and s_order_line_t.order_id = s_order_t.order_id
and customer_id = 1;

-- Question 3
select product_description
from s_product_t, s_order_line_t, s_order_t, s_customer_t
where s_product_t.product_id = s_order_line_t.product_id
and s_order_line_t.order_id = s_order_t.order_id
and s_order_t.customer_id = s_customer_t.customer_id
and customer_name = 'Impressions';

-- Question 4
select customer_name
from s_customer_t, s_order_t, s_order_line_t, s_product_t
where s_customer_t.customer_id = s_order_t.customer_id
and s_order_t.order_id = s_order_line_t.order_id
and s_order_line_t.product_id = s_product_t.product_id
and standard_price > 500;

-- Question 5
select s_customer_t.*, s_order_t.order_id
from s_customer_t
left outer join s_order_t
on s_customer_t.customer_id=s_order_t.customer_id;

-- Question 6
SELECT ORDER_ID, S_PRODUCT_T.PRODUCT_ID, STANDARD_PRICE, ORDERED_QUANTITY, STANDARD_PRICE * ORDERED_QUANTITY
FROM S_PRODUCT_T, S_ORDER_LINE_T
WHERE S_PRODUCT_T.PRODUCT_ID = S_ORDER_LINE_T.PRODUCT_ID
ORDER BY ORDER_ID, S_PRODUCT_T.PRODUCT_ID;

-- Question 7
SELECT ORDER_ID, SUM(STANDARD_PRICE * ORDERED_QUANTITY)
FROM S_PRODUCT_T, S_ORDER_LINE_T
WHERE S_PRODUCT_T.PRODUCT_ID = S_ORDER_LINE_T.PRODUCT_ID
GROUP BY ORDER_ID
ORDER BY ORDER_ID;
