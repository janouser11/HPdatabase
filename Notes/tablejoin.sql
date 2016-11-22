-- Display Customer Name who ordered any product

-- Equi-Join
Select Customer_Name
  from S_Customer_T, S_ORDER_t
    where S_Customer_T.Customer_Id = S_Order_T.customer_id;

-- Natural Join
Select Customer_Name
  from S_Customer_T
    Natural Join S_Order_T;
