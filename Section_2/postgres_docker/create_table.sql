BEGIN;

CREATE SCHEMA "CAR_DEALER"

CREATE TABLE "CAR_DEALER"."INVOICE" (
	"ID" varchar(3) NOT NULL,
	"SALESPERSON_ID" varchar(3) NOT NULL,
	"DATETIME" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"CUSTOMER_ID" varchar(30) NOT NULL,
	"CAR_ID" varchar(10) NOT NULL,
	"CAR_SN" varchar(30) NOT NULL,
	CONSTRAINT "INVOICE_pkey" PRIMARY KEY ("ID")
);

-- "CAR_DEALER"."CAR" definition
CREATE TABLE "CAR_DEALER"."CAR" (
	"ID" varchar(10) NOT NULL,
	"MANUFACTURER" varchar(30) NULL,
	"MODEL_NAME" varchar(30) NULL,
	"WEIGHT" numeric(3, 1) NULL,
	"PRICE" numeric(18, 2) NULL,
	CONSTRAINT "CAR_pkey" PRIMARY KEY ("ID")
);

-- "CAR_DEALER"."CUSTOMER" definition
CREATE TABLE "CAR_DEALER"."CUSTOMER" (
	"ID" varchar(3) NOT NULL,
	"NAME" varchar(30) NULL,
	"PHONE" varchar(10) NULL,
	CONSTRAINT "CUSTOMER_pkey" PRIMARY KEY ("ID")
);

-- "CAR_DEALER"."SALES" definition

CREATE TABLE "CAR_DEALER"."SALES" (
	"ID" varchar(3) NOT NULL,
	"NAME" varchar(30) NULL,
	CONSTRAINT "SALES_pkey" PRIMARY KEY ("ID")
);


-- "CAR_DEALER"."INVOICE" foreign keys
-- RUN ALL CREATE TABLE BEFORE SETTING FKs
ALTER TABLE "CAR_DEALER"."INVOICE" ADD CONSTRAINT "FK_CAR_ID" FOREIGN KEY ("CAR_ID") REFERENCES "CAR_DEALER"."CAR"("ID");
ALTER TABLE "CAR_DEALER"."INVOICE" ADD CONSTRAINT "FK_CUSTOMER_ID" FOREIGN KEY ("CUSTOMER_ID") REFERENCES "CAR_DEALER"."CUSTOMER"("ID");
ALTER TABLE "CAR_DEALER"."INVOICE" ADD CONSTRAINT "FK_SALESPERSON_ID" FOREIGN KEY ("SALESPERSON_ID") REFERENCES "CAR_DEALER"."SALES"("ID");

COMMIT;