-- Question 1
Select Customer_Id, Customer_Name
    From S_Customer_T;

-- Question 2
Select Customer_Name AS "Name", Customer_Address AS "Address"
    From S_Customer_T
    Where Customer_Name = 'Home Furnishings';

-- Question 3
Select Product_ID
    From S_Product_T
    Where Standard_Price < 200;

-- Question 4   
Select AVG(Standard_Price)
    From S_Product_T;

-- Question 5
Select MAX(Standard_Price)
    From S_Product_T;

-- Question 6
Select COUNT(Order_ID)
    From S_Order_T;
