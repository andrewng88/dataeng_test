# Section_2 : Databases
##

## Step 0
Install [Docker Using WSL2](https://docs.docker.com/docker-for-windows/wsl/) as I'm using a windows lappy.
Install [dbeaver](https://dbeaver.io/download/) Universal Database Tool. It will also help us to generate the ER diagram

## Step 1
Initial brainstorming of the tables required based on the requirement.
![](https://i.imgur.com/GVFJv5m.png "Title")
> Note: `Color coded fields` to represent primary key linked to foreign keys

And we translate to an ER Diagram which is a very simple `star schema` and `normalized` to reduce redundancy.
![](https://i.imgur.com/8F4jBAI.png "Title")

## Step 2
## 
Using this as a [guide](https://dev.to/andre347/how-to-easily-create-a-postgres-database-in-docker-4moj) to install postgres and create tables via docker.

>What is Docker?
In my own words, it's a container that help us with deployment/dependencies(sometimes the framework that works in our system will not work in others ) and we will always use latest stable from the docker hub. Also it's similar to virtualization BUT more efficient with regards to resources as the former locked system resources.

Create `DOCKERFILE` as per below
```sh
#Pull down the latest Postgres image from the Docker Hub
FROM postgres

#Set the environment variable for password to 'docker'
ENV POSTGRES_PASSWORD docker

#Create a database, let's call it 'dbase'
ENV POSTGRES_DB dbase

#Use a .sql  file to create the table schema etc
COPY create_table.sql /docker-entrypoint-initdb.d/
```
Create `create_table.sql` w. In general, we are creating tables and we set the appropriate data types and we linked the primary and foreign keys.
```sh
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
```
## Step 3
Then we run the following at the terminal
![](https://i.imgur.com/2cjOSYx.png "Title")
The above line tells Docker to build an image from the Dockerfile and give it a name of 'my-postgres-db'

```sh
docker run -d --name my-postgresdb-container -p 5432:5432 my-postgres-db
```
The above command will run the container. Note we need to specify 5432 for the internal and host port.

Other useful commands include
```sh
# list all images
docker images -a

#obtain container_id
docker ps

# delete image
docker image rm -f input_container_id

# if your port is used and you need to free it
docker kill input_container_id
```
## Step 4 
We managed to create postgres tables via docker. Hurrah.

Then we configure and run `dbeaver` to access the db. We even created a `invoice view` for stakeholder's convenience.

![](https://i.imgur.com/dWX8Ikg.png "Title")
```sh
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
```

Next we will answer the 2 questions.

Key points are we need to left join so that we are able to see all of customers and if we do not do that the sql will not display customer that didn't purchase anything. Next, we need to group by customers ( in case they make repeated purchases) and order in a descending manner. 
![](https://i.imgur.com/ezMTILY.png "Title")

In the following question, the key point is we need to extract the `YYYY-MM` of the date and also extract the `current month` and use it as a dynamic filter and we can create a view for the stakeholders too. Also, we limit by 3 since we want top 3( sort descending ) and I assume `Revenue` is more important here. 
![](https://i.imgur.com/U0il6dJ.png "Title")
