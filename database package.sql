---specification 
CREATE OR REPLACE PACKAGE practicum2_pkg AS
    PROCEDURE p_get_orders_for_cust(cust_in IN customers.CustomerId%type);
    FUNCTION get_cust_name (cust_in IN customers.CustomerId%type) RETURN VARCHAR2;
    FUNCTION get_avg_order_amount (cust_in IN customers.CustomerId%type) RETURN VARCHAR2;
END practicum2_pkg;

-- package body
CREATE OR REPLACE PACKAGE BODY practicum2_pkg AS
    -- sample package procedure
    PROCEDURE p_get_orders_for_cust(cust_in IN customers.customerid%type) IS

	--- declare variables
	    o_id NUMBER;
	    o_date char(16);
	    o_status VARCHAR2(16);
	    o_amount VARCHAR2(20);

	--- define cursor for select
	    CURSOR c_orders_per_cust IS
	        SELECT DISTINCT o.orderid, to_char(o.orderDate, 'DD/MON/YYYY'), NVL2(o.shippeddate, 'Shipped', 'Not Shipped'), TO_CHAR(SUM((od.quantity * od.unitprice * (1 - od.discount))), '$99,999.99')
		    FROM orders o INNER JOIN orderdetails od
            ON o.orderid = od.orderid
            WHERE o.customerid = cust_in
            GROUP BY o.orderid, o.orderdate, o.shippeddate
            ORDER BY 4 DESC;

	BEGIN 
	---- heading line, chr10 is an new line character
    dbms_output.put_line('Statistics for ' || get_cust_name(cust_in) || ' ' || TO_CHAR(sysdate, 'DD/MON/YYYY') || ' - Bruno Surdi Oliveira' || chr(10));
    dbms_output.put_line(RPAD('Order #', 16) || RPAD('Date', 20) || RPAD('Status', 20) || RPAD('Order Total', 20));
    dbms_output.put_line('');

    ---- Execute the cursor 
    OPEN c_orders_per_cust;

    ---- Retrieve each row from the resultset in a loop 
    LOOP
    FETCH c_orders_per_cust INTO o_id, o_date, o_status, o_amount;
        --- End of resultset reached
        EXIT WHEN c_orders_per_cust%notfound;
        --- dump out data
        dbms_output.put_line(RPAD(o_id, 16) || RPAD(o_date, 20) || RPAD(o_status,20) || RPAD(o_amount, 20));
    END LOOP;
    ----- Close the cursor  
    CLOSE c_orders_per_cust;
    dbms_output.put_line('');

    ---- Output the AVG
    dbms_output.put_line(RPAD('Avg. order amount for customer:', 46) || LPAD(get_avg_order_amount(cust_in),21));
	END;

    -- sample package function
    FUNCTION get_cust_name (cust_in IN customers.CustomerId%type) 
    RETURN VARCHAR2 IS
	    cust_name customers.companyname%type;
	BEGIN 
	    SELECT companyname INTO cust_name
		FROM customers
		WHERE customerId = cust_in;
		RETURN cust_name;
	END;

    FUNCTION get_avg_order_amount (cust_in IN customers.CustomerId%type) 
    RETURN VARCHAR2 IS 
    order_avg_amount NUMBER(10,2) := 0.00; 
    BEGIN
    SELECT AVG(SUM(od.unitprice * od.quantity * (1 - od.discount))) INTO order_avg_amount
    FROM orderdetails od INNER JOIN orders o
    ON o.orderid = od.orderid
    WHERE o.customerid = cust_in
    GROUP BY o.orderid;
    RETURN TO_CHAR(order_avg_amount, '$99,999.99');
    END;

END practicum2_pkg;
