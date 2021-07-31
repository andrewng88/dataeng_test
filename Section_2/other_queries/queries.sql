-- I want to know the list of our customers and their spending.

SELECT CU."NAME",SUM(C."PRICE") AS SPENDINGS FROM "CAR_DEALER"."CUSTOMER" CU
LEFT JOIN  "CAR_DEALER"."INVOICE" I
ON CU."ID" = I."CUSTOMER_ID"
LEFT JOIN "CAR_DEALER"."CAR" C
ON I."CAR_ID" = C."ID"
GROUP BY CU."NAME"
ORDER BY SUM(C."PRICE") DESC;


-- I want to find out the top 3 car manufacturers that customers bought by sales (quantity) and the sales number for it in the current month.

SELECT CA."MANUFACTURER",COUNT(I."CAR_SN") AS SALES_QTY,SUM("PRICE") AS SALES_DOLLAR
FROM "CAR_DEALER"."CAR" CA
LEFT JOIN "CAR_DEALER"."INVOICE" I
ON CA."ID" = I."CAR_ID"
WHERE to_char(I."DATETIME", 'YYYY-MM')=to_char(current_date, 'YYYY-MM')
GROUP BY CA."MANUFACTURER"
order by SALES_DOLLAR desc
limit 3;