SELECT Version();
-- PostgreSQL 15.0, compiled by Visual C++ build 1914, 64-bit

/* PostgreSQL Primary Key */
/*

A primary key is a column or a group of columns used to identify a row uniquely in a table.

You define primary keys through primary key constraints.
Technically, a primary key constraint is the combination of a not-null constraint and a UNIQUE constraint.

A table can have one and only one primary key.
It is a good practice to add a primary key to every table.
When you add a primary key to a table, PostgreSQL creates a unique B-tree index on the column 
or a group of columns used to define the primary key.

Normally, we add the primary key to a table when we define the table’s structure using CREATE TABLE statement.

CREATE TABLE TABLE (
	column_1 data_type PRIMARY KEY,
	column_2 data_type,
	…
);
*/

CREATE TABLE po_headers (
	po_no INTEGER PRIMARY KEY,
	vendor_no INTEGER,
	description TEXT,
	shipping_address TEXT
);

/*
In case the primary key consists of two or more columns, you define the primary key constraint as follows:

CREATE TABLE TABLE (
	column_1 data_type,
	column_2 data_type,
	… 
    PRIMARY KEY (column_1, column_2)
);
*/

CREATE TABLE po_items (
	po_no INTEGER,
	item_no INTEGER,
	product_no INTEGER,
	qty INTEGER,
	net_price NUMERIC,
	PRIMARY KEY (po_no, item_no)
);

/*
If you don’t specify explicitly the name for primary key constraint, 
PostgreSQL will assign a default name to the primary key constraint. 
By default, PostgreSQL uses table-name_pkey as the default name for the primary key constraint. 

In this example, PostgreSQL creates the primary key constraint with the name po_items_pkey for the po_items table.

In case you want to specify the name of the primary key constraint, you use CONSTRAINT clause as follows:

CONSTRAINT constraint_name PRIMARY KEY(column_1, column_2,...);
*/

/*
Define primary key when changing the existing table structure

It is rare to define a primary key for existing table. 
In case you have to do it, you can use the ALTER TABLE statement to add a primary key constraint.

ALTER TABLE table_name ADD PRIMARY KEY (column_1, column_2);
*/

DROP TABLE IF EXISTS products;
CREATE TABLE products (
	product_no INTEGER,
	description TEXT,
	product_cost NUMERIC
);

ALTER TABLE products 
ADD PRIMARY KEY (product_no);

/* How to add an auto-incremented primary key to an existing table */

CREATE TABLE vendors (name VARCHAR(255));

INSERT INTO vendors (name)
VALUES
	('Microsoft'),
	('IBM'),
	('Apple'),
	('Samsung');
	
SELECT * FROM vendors;

-- add serial pk
ALTER TABLE vendors ADD COLUMN id SERIAL PRIMARY KEY;

/* 
Remove primary key
ALTER TABLE table_name DROP CONSTRAINT primary_key_constraint;
*/

ALTER TABLE products
DROP CONSTRAINT products_pkey;

/* PostgreSQL Foreign Key */
/*
A foreign key is a column or a group of columns in a table that reference the primary key of another table.

The table that contains the foreign key is called the referencing table or child table.
And the table referenced by the foreign key is called the referenced table or parent table.

A table can have multiple foreign keys depending on its relationships with other tables.

In PostgreSQL, you define a foreign key using the foreign key constraint. 
The foreign key constraint helps maintain the referential integrity of data between the child and parent tables.

A foreign key constraint indicates that values in a column or a group of columns in the child table equal the values 
in a column or a group of columns of the parent table.

PostgreSQL foreign key constraint syntax

[CONSTRAINT fk_name]
   FOREIGN KEY(fk_columns) 
   REFERENCES parent_table(parent_key_columns)
   [ON DELETE delete_action]
   [ON UPDATE update_action]

. First, specify the name for the foreign key constraint after the CONSTRAINT keyword. 
The CONSTRAINT clause is optional. If you omit it, PostgreSQL will assign an auto-generated name.

. Second, specify one or more foreign key columns in parentheses after the FOREIGN KEY keywords.

. Third, specify the parent table and parent key columns referenced by the foreign key columns in the REFERENCES clause.

. Finally, specify the delete and update actions in the ON DELETE and ON UPDATE clauses.
The delete and update actions determine the behaviors when the primary key in the parent table is deleted and updated.
Since the primary key is rarely updated, the ON UPDATE action is not often used in practice. 
We’ll focus on the ON DELETE action.

PostgreSQL supports the following actions:
. SET NULL
. SET DEFAULT
. RESTRICT
. NO ACTION
. CASCADE
*/

DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS contacts CASCADE;

CREATE TABLE customers(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_name VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);

CREATE TABLE contacts(
   contact_id INT GENERATED ALWAYS AS IDENTITY,
   customer_id INT,
   contact_name VARCHAR(255) NOT NULL,
   phone VARCHAR(15),
   email VARCHAR(100),
   PRIMARY KEY(contact_id),
   CONSTRAINT fk_customer
      FOREIGN KEY(customer_id) 
	  REFERENCES customers(customer_id)
);

-- NO ACTION (by default)

INSERT INTO customers(customer_name)
VALUES('BlueBird Inc'),
      ('Dolphin LLC');	   
	   
INSERT INTO contacts(customer_id, contact_name, phone, email)
VALUES(1,'John Doe','(408)-111-1234','john.doe@bluebird.dev'),
      (1,'Jane Doe','(408)-111-1235','jane.doe@bluebird.dev'),
      (2,'David Wright','(408)-222-1234','david.wright@dolphin.dev');

DELETE FROM customers
WHERE customer_id = 1;
/*
ERROR:  update or delete on table "customers" violates foreign key constraint "fk_customer" on table "contacts"
DETAIL:  Key (customer_id)=(1) is still referenced from table "contacts".
SQL state: 23503
*/

/*
Because of the ON DELETE NO ACTION,
PostgreSQL issues a constraint violation because the referencing rows of the customer id 1 still exist in the contacts table

The RESTRICT action is similar to the NO ACTION.
The difference only arises when you define the foreign key constraint as DEFERRABLE with an INITIALLY DEFERRED 
or INITIALLY IMMEDIATE mode.
*/

-- SET NULL
/*
The SET NULL automatically sets NULL to the foreign key columns in the referencing rows of the child table 
when the referenced rows in the parent table are deleted.
*/

DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_name VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);

CREATE TABLE contacts(
   contact_id INT GENERATED ALWAYS AS IDENTITY,
   customer_id INT,
   contact_name VARCHAR(255) NOT NULL,
   phone VARCHAR(15),
   email VARCHAR(100),
   PRIMARY KEY(contact_id),
   CONSTRAINT fk_customer
      FOREIGN KEY(customer_id) 
	  REFERENCES customers(customer_id)
	  ON DELETE SET NULL
);

INSERT INTO customers(customer_name)
VALUES('BlueBird Inc'),
      ('Dolphin LLC');	   
	   
INSERT INTO contacts(customer_id, contact_name, phone, email)
VALUES(1,'John Doe','(408)-111-1234','john.doe@bluebird.dev'),
      (1,'Jane Doe','(408)-111-1235','jane.doe@bluebird.dev'),
      (2,'David Wright','(408)-222-1234','david.wright@dolphin.dev');

-- set null
DELETE FROM customers
WHERE customer_id = 1;

SELECT * FROM contacts;

-- CASCADE
/*
The ON DELETE CASCADE automatically deletes all the referencing rows in the child table 
when the referenced rows in the parent table are deleted. 
In practice, the ON DELETE CASCADE is the most commonly used option.
*/

DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_name VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);

CREATE TABLE contacts(
   contact_id INT GENERATED ALWAYS AS IDENTITY,
   customer_id INT,
   contact_name VARCHAR(255) NOT NULL,
   phone VARCHAR(15),
   email VARCHAR(100),
   PRIMARY KEY(contact_id),
   CONSTRAINT fk_customer
      FOREIGN KEY(customer_id) 
	  REFERENCES customers(customer_id)
	  ON DELETE CASCADE
);

INSERT INTO customers(customer_name)
VALUES('BlueBird Inc'),
      ('Dolphin LLC');	   
	   
INSERT INTO contacts(customer_id, contact_name, phone, email)
VALUES(1,'John Doe','(408)-111-1234','john.doe@bluebird.dev'),
      (1,'Jane Doe','(408)-111-1235','jane.doe@bluebird.dev'),
      (2,'David Wright','(408)-222-1234','david.wright@dolphin.dev');

-- cascade
DELETE FROM customers
WHERE customer_id = 1;

SELECT * FROM contacts;

-- SET DEFAULT
/*
The ON DELETE SET DEFAULT sets the default value to the foreign key column of the referencing rows in the child table 
when the referenced rows from the parent table are deleted.
*/

/*
Add a foreign key constraint to an existing table

ALTER TABLE child_table 
ADD CONSTRAINT constraint_name 
FOREIGN KEY (fk_columns) 
REFERENCES parent_table (parent_key_columns);

When you add a foreign key constraint with ON DELETE CASCADE option to an existing table, you need to follow these steps:

First, drop existing foreign key constraints:

ALTER TABLE child_table
DROP CONSTRAINT constraint_fkey;

Then, add a new foreign key constraint with  ON DELETE CASCADE action:

ALTER TABLE child_table
ADD CONSTRAINT constraint_fk
FOREIGN KEY (fk_columns)
REFERENCES parent_table(parent_key_columns)
ON DELETE CASCADE;
*/

/* PostgreSQL CHECK Constraint */
/*
A CHECK constraint is a kind of constraint that allows you to specify if values in a column must meet a specific requirement.

The CHECK constraint uses a Boolean expression to evaluate the values before they are inserted or updated to the column.

If the values pass the check, PostgreSQL will insert or update these values to the column. 
Otherwise, PostgreSQL will reject the changes and issue a constraint violation error.

Typically, you use the CHECK constraint at the time of creating the table using the CREATE TABLE statement.
*/

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR (50),
	last_name VARCHAR (50),
	birth_date DATE CHECK (birth_date > '1900-01-01'),
	joined_date DATE CHECK (joined_date > birth_date),
	salary numeric CHECK(salary > 0)
);

INSERT INTO employees (first_name, last_name, birth_date, joined_date, salary)
VALUES ('John', 'Doe', '1972-01-01', '2015-07-01', - 100000);
/*
[Err] ERROR:  new row for relation "employees" violates check constraint "employees_salary_check"
DETAIL:  Failing row contains (1, John, Doe, 1972-01-01, 2015-07-01, -100000).
*/

/*
By default, PostgreSQL gives the CHECK constraint a name using the following pattern:

{table}_{column}_check

example: employees_salary_check

However, if you want to assign a CHECK constraint a specific name, 
you can specify it after the CONSTRAINT expression as follows:

column_name data_type CONSTRAINT constraint_name CHECK(...)

example:
salary numeric CONSTRAINT positive_salary CHECK(salary > 0)
*/

-- Define PostgreSQL CHECK constraints for existing tables

CREATE TABLE prices_list (
	id serial PRIMARY KEY,
	product_id INT NOT NULL,
	price NUMERIC NOT NULL,
	discount NUMERIC NOT NULL,
	valid_from DATE NOT NULL,
	valid_to DATE NOT NULL
);

-- with alter
ALTER TABLE prices_list 
ADD CONSTRAINT price_discount_check 
CHECK (
	price > 0
	AND discount >= 0
	AND price > discount
);

ALTER TABLE prices_list 
ADD CONSTRAINT valid_range_check 
CHECK (valid_to >= valid_from);

/* PostgreSQL UNIQUE Constraint */
/*
Sometimes, you want to ensure that values stored in a column or a group of columns are unique across the whole table 
such as email addresses or usernames.

PostgreSQL provides you with the UNIQUE constraint that maintains the uniqueness of the data correctly.

When a UNIQUE constraint is in place, every time you insert a new row, it checks if the value is already in the table. 
It rejects the change and issues an error if the value already exists. 
The same process is carried out for updating existing data.

When you add a UNIQUE constraint to a column or a group of columns, 
PostgreSQL will automatically create a unique index on the column or the group of columns.
*/

CREATE TABLE person (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR (50),
	last_name VARCHAR (50),
	email VARCHAR (50) UNIQUE
);

-- or
CREATE TABLE person (
	id SERIAL  PRIMARY KEY,
	first_name VARCHAR (50),
	last_name  VARCHAR (50),
	email      VARCHAR (50),
        UNIQUE(email)
);


INSERT INTO person(first_name,last_name,email)
VALUES('john','doe','j.doe@postgresqltutorial.com');

INSERT INTO person(first_name,last_name,email)
VALUES('jack','doe','j.doe@postgresqltutorial.com');
/*
[Err] ERROR:  duplicate key value violates unique constraint "person_email_key"
DETAIL:  Key (email)=(j.doe@postgresqltutorial.com) already exists.
*/

/*
Creating a UNIQUE constraint on multiple columns
PostgreSQL allows you to create a UNIQUE constraint to a group of columns using the following syntax:

CREATE TABLE table (
    c1 data_type,
    c2 data_type,
    c3 data_type,
    UNIQUE (c2, c3)
);

The combination of values in column c2 and c3 will be unique across the whole table. 
The value of the column c2 or c3 needs not to be unique.
*/

-- Adding unique constraint using a unique index
-- Sometimes, you may want to add a unique constraint to an existing column or group of columns. 

-- First, suppose you have a table named equipment:
CREATE TABLE equipment (
	id SERIAL PRIMARY KEY,
	name VARCHAR (50) NOT NULL,
	equip_id VARCHAR (16) NOT NULL
);

-- Second, create a unique index based on the equip_id column.
CREATE UNIQUE INDEX CONCURRENTLY equipment_equip_id 
ON equipment (equip_id);

-- Third, add a unique constraint to the equipment table using the equipment_equip_id index.
ALTER TABLE equipment 
ADD CONSTRAINT unique_equip_id 
UNIQUE USING INDEX equipment_equip_id;

/*
Notice that the ALTER TABLE statement acquires an exclusive lock on the table. 
If you have any pending transactions, it will wait for all transactions to complete before changing the table. 
Therefore, you should check the  pg_stat_activity table to see the current pending transactions 
that are on-going using the following query:
*/

SELECT
	datid,
	datname,
	usename,
	state
FROM
	pg_stat_activity;
	
/*
You should look at the result to find the state column with the value 'idle' in transaction.
Those are the transactions that are pending to complete.
*/

/* PostgreSQL Not-Null Constraint */
/*
Introduction to NULL
In database theory, NULL represents unknown or information missing.
NULL is not the same as an empty string or the number zero.

Suppose that you need to insert an email address of a contact into a table. 
You can request his or her email address. 
However, if you don’t know whether the contact has an email address or not, 
you can insert NULL into the email address column. 
In this case, NULL indicates that the email address is not known at the time of recording.

NULL is very special. It does not equal anything, even itself. 
The expression NULL = NULL returns NULL because it makes sense that two unknown values should not be equal.

To check if a value is NULL or not, you use the IS NULL boolean operator. 

email_address IS NULL

The IS NOT NULL operator negates the result of the IS NULL operator.
*/

/*
PostgreSQL NOT NULL constraint

CREATE TABLE table_name(
   ...
   column_name data_type NOT NULL,
   ...
);

If a column has a NOT NULL constraint, any attempt to insert or update NULL in the column will result in an error.
*/

CREATE TABLE invoices(
  id SERIAL PRIMARY KEY,
  product_id INT NOT NULL,
  qty numeric NOT NULL CHECK(qty > 0),
  net_price numeric CHECK(net_price > 0) 
);

/*
This example uses the NOT NULL keywords that follow the data type of the product_id 
and qty columns to declare NOT NULL constraints.

Note that a column can have multiple constraints such as NOT NULL, check, unique, foreign key appeared next to each other. 
The order of the constraints is not important. PostgreSQL can check the constraint in the list in any order.

If you use NULL instead of NOT NULL, the column will accept both NULL and non-NULL values. 
If you don’t explicitly specify NULL or NOT NULL, it will accept NULL by default.
*/

-- Adding NOT NULL Constraint to existing columns
/*

ALTER TABLE table_name
ALTER COLUMN column_name SET NOT NULL;

ALTER TABLE table_name
ALTER COLUMN column_name_1 SET NOT NULL,
ALTER COLUMN column_name_2 SET NOT NULL,
...;
*/

CREATE TABLE production_orders (
	id SERIAL PRIMARY KEY,
	description VARCHAR (40) NOT NULL,
	material_id VARCHAR (16),
	qty NUMERIC,
	start_date DATE,
	finish_date DATE
);

INSERT INTO production_orders (description)
VALUES('Make for Infosys inc.');

UPDATE production_orders
SET qty = 1;

ALTER TABLE production_orders 
ALTER COLUMN qty
SET NOT NULL;

UPDATE production_orders
SET material_id = 'ABC',
    start_date = '2015-09-01',
    finish_date = '2015-09-01';
	
ALTER TABLE production_orders 
ALTER COLUMN material_id SET NOT NULL,
ALTER COLUMN start_date SET NOT NULL,
ALTER COLUMN finish_date SET NOT NULL;

UPDATE production_orders
SET qty = NULL;
/*
[Err] ERROR:  null value in column "qty" violates not-null constraint
DETAIL:  Failing row contains (1, make for infosys inc., ABC, null, 2015-09-01, 2015-09-01).
*/

-- The special case of NOT NULL constraint
/*
Besides the NOT NULL constraint, you can use a CHECK constraint to force a column to accept not NULL values. 
The NOT NULL constraint is equivalent to the following CHECK constraint:

CHECK(column IS NOT NULL)
*/

CREATE TABLE users (
 id serial PRIMARY KEY,
 username VARCHAR (50),
 password VARCHAR (50),
 email VARCHAR (50),
 CONSTRAINT username_email_notnull CHECK (
   NOT (
     ( username IS NULL  OR  username = '' )
     AND
     ( email IS NULL  OR  email = '' )
   )
 )
);

INSERT INTO users (username, email)
VALUES
	('user1', NULL),
	(NULL, 'email1@example.com'),
	('user2', 'email2@example.com'),
	('user3', '');
	
INSERT INTO users (username, email)
VALUES
	(NULL, NULL),
	(NULL, ''),
	('', NULL),
	('', '');
-- [Err] ERROR:  new row for relation "users" violates check constraint "username_email_notnull"

/*
Summary

. Use the NOT NULL constraint for a column to enforce a column not accept NULL. 
By default, a column can hold NULL.

. To check if a value is NULL or not, you use the IS NULL operator. 
The IS NOT NULL negates the result of the IS NULL.

. Never use equal operator = to compare a value with NULL because it always returns NULL.
*/