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