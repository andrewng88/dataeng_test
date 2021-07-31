-- view for invoice query
CREATE VIEW "CAR_DEALER".view_invoice AS
select 
S."NAME" as SALES_NAME,
CU."NAME" as CUST_NAME,
CU."PHONE",
C."MANUFACTURER",
C."MODEL_NAME",
C."WEIGHT",
C."PRICE"
from "CAR_DEALER"."INVOICE" I
left join "CAR_DEALER"."CAR" C
on I."CAR_ID" = C."ID" 
left join "CAR_DEALER"."CUSTOMER" CU
on I."CUSTOMER_ID" =CU."ID" 
left join "CAR_DEALER"."SALES" S
on I."SALESPERSON_ID" = S."ID";

-- view for top 3 manufactuer by current month query
CREATE VIEW "CAR_DEALER".view_top_3_mfg AS
SELECT CA."MANUFACTURER",COUNT(I."CAR_SN") AS SALES_QTY,SUM("PRICE") AS SALES_DOLLAR
FROM "CAR_DEALER"."CAR" CA
LEFT JOIN "CAR_DEALER"."INVOICE" I
ON CA."ID" = I."CAR_ID"
WHERE to_char(I."DATETIME", 'YYYY-MM')=to_char(current_date, 'YYYY-MM')
GROUP BY CA."MANUFACTURER"
order by SALES_DOLLAR desc
limit 3;