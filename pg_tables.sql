SELECT Version();
-- PostgreSQL 15.0, compiled by Visual C++ build 1914, 64-bit

/*
PostgreSQL Data Types

PostgreSQL supports the following data types:

. Boolean
. Character types such as char, varchar, and text.
. Numeric types such as integer and floating-point number.
. Temporal types such as date, time, timestamp, and interval
. UUID for storing Universally Unique Identifiers
. Array for storing array strings, numbers, etc.
. JSON stores JSON data
. hstore stores key-value pair
. Special types such as network address and geometric data.

/Boolean/
A Boolean data type can hold one of three possible values: true, false or null. 
You use boolean or bool keyword to declare a column with the Boolean data type.

When you insert data into a Boolean column, PostgreSQL converts it to a Boolean value
. 1, yes, y, t, true values are converted to true
. 0, no, false, f values are converted to false.

When you select data from a Boolean column, PostgreSQL converts the values back e.g., t to true, f to false and space to null.

/Character/
PostgreSQL provides three character data types: CHAR(n), VARCHAR(n), and TEXT

. CHAR(n) is the fixed-length character with space padded. 
If you insert a string that is shorter than the length of the column, PostgreSQL pads spaces.
If you insert a string that is longer than the length of the column, PostgreSQL will issue an error.

. VARCHAR(n) is the variable-length character string.
With VARCHAR(n),  you can store up to n characters.
PostgreSQL does not pad spaces when the stored string is shorter than the length of the column.

. TEXT is the variable-length character string. Theoretically, text data is a character string with unlimited length.

/Numeric/
PostgreSQL provides two distinct types of numbers:
. integers
. floating-point numbers

/Integer/
There are three kinds of integers in PostgreSQL:
. Small integer ( SMALLINT) is 2-byte signed integer that has a range from -32,768 to 32,767.
. Integer ( INT) is a 4-byte integer that has a range from -2,147,483,648 to 2,147,483,647.
. Serial is the same as integer except that PostgreSQL will automatically generate and populate values into the SERIAL column. This is similar to AUTO_INCREMENT column in MySQL or AUTOINCREMENT column in SQLite.

/Floating-point number/
There three main types of floating-point numbers:
. float(n)  is a floating-point number whose precision, at least, n, up to a maximum of 8 bytes.
. realor float8is a 4-byte floating-point number.
. numeric or numeric(p,s) is a real number with p digits with s number after the decimal point. The numeric(p,s) is the exact number.

/Temporal data types/
The temporal data types allow you to store date and /or  time data.
PostgreSQL has five main temporal data types:

. DATE stores the dates only.
. TIME stores the time of day values.
. TIMESTAMP stores both date and time values.
. TIMESTAMPTZ is a timezone-aware timestamp data type. It is the abbreviation for timestamp with the time zone.
. INTERVAL stores periods of time.

The TIMESTAMPTZ is the PostgreSQL’s extension to the SQL standard’s temporal data types.

/Arrays/
In PostgreSQL, you can store an array of strings, an array of integers, etc., in array columns. 
The array comes in handy in some situations e.g., storing days of the week, months of the year.

/JSON/
PostgreSQL provides two JSON data types: JSON and JSONB for storing JSON data.

The JSON data type stores plain JSON data that requires reparsing for each processing, 
while JSONB data type stores JSON data in a binary format which is faster to process but slower to insert. 
In addition, JSONB supports indexing, which can be an advantage.

/UUID/
The UUID data type allows you to store Universal Unique Identifiers defined by RFC 4122 .
The UUID values guarantee a better uniqueness than SERIAL 
and can be used to hide sensitive data exposed to the public such as values of id in URL.

/Special data types/
Besides the primitive data types, PostgreSQL also provides several special data types related to geometric and network.

. box– a rectangular box.
. line – a set of points.
. point– a geometric pair of numbers.
. lseg– a line segment.
. polygon– a closed geometric.
. inet– an IP4 address.
. macaddr– a MAC address.
*/

/* PostgreSQL CREATE TABLE */
/*
CREATE TABLE [IF NOT EXISTS] table_name (
   column1 datatype(length) column_contraint,
   column2 datatype(length) column_contraint,
   column3 datatype(length) column_contraint,
   table_constraints
);

. First, specify the name of the table after the CREATE TABLE keywords.

. Second, creating a table that already exists will result in a error. 
The IF NOT EXISTS option allows you to create the new table only if it does not exist. 
When you use the IF NOT EXISTS option and the table already exists, 
PostgreSQL issues a notice instead of the error and skips creating the new table.

. Third, specify a comma-separated list of table columns. 
Each column consists of the column name, the kind of data that column stores, the length of data, and the column constraint. 
The column constraints specify rules that data stored in the column must follow. 
For example, the not-null constraint enforces the values in the column cannot be NULL. 
The column constraints include not null, unique, primary key, check, foreign key constraints.

. Finally, specify the table constraints including primary key, foreign key, and check constraints.

Note that some table constraints can be defined as column constraints like primary key, foreign key, check, unique constraints.

Constraints
PostgreSQL includes the following column constraints:

. NOT NULL – ensures that values in a column cannot be NULL.
. UNIQUE – ensures the values in a column unique across the rows within the same table.
. PRIMARY KEY – a primary key column uniquely identify rows in a table. 
A table can have one and only one primary key. 
The primary key constraint allows you to define the primary key of a table.
. CHECK – a CHECK constraint ensures the data must satisfy a boolean expression.
. FOREIGN KEY – ensures values in a column or a group of columns from a table exists in a column 
or group of columns in another table. 
Unlike the primary key, a table can have many foreign keys.

Table constraints are similar to column constraints except that they are applied to more than one column.
*/

CREATE TABLE accounts (
	user_id serial PRIMARY KEY,
	username VARCHAR ( 50 ) UNIQUE NOT NULL,
	password VARCHAR ( 50 ) NOT NULL,
	email VARCHAR ( 255 ) UNIQUE NOT NULL,
	created_on TIMESTAMP NOT NULL,
	last_login TIMESTAMP 
);

CREATE TABLE roles(
   role_id serial PRIMARY KEY,
   role_name VARCHAR (255) UNIQUE NOT NULL
);

CREATE TABLE account_roles (
  user_id INT NOT NULL,
  role_id INT NOT NULL,
  grant_date TIMESTAMP,
  PRIMARY KEY (user_id, role_id),
  FOREIGN KEY (role_id)
      REFERENCES roles (role_id),
  FOREIGN KEY (user_id)
      REFERENCES accounts (user_id)
);

/* PostgreSQL SELECT INTO */
/*
he PostgreSQL SELECT INTO statement creates a new table and inserts data returned from a query into the table.

The new table will have columns with the names the same as columns of the result set of the query. 
Unlike a regular SELECT statement, the SELECT INTO statement does not return a result to the client.

SELECT
    select_list
INTO [ TEMPORARY | TEMP | UNLOGGED ] [ TABLE ] new_table_name
FROM
    table_name
WHERE
    search_condition;

To create a new table with the structure and data derived from a result set, you specify the new table name after the INTO keyword.

The TEMP or TEMPORARY keyword is optional; it allows you to create a temporary table instead.

The UNLOGGED keyword if available will make the new table as an unlogged table.

The WHERE clause allows you to specify the rows from the original tables that should be inserted into the new table. 
Besides the WHERE clause, you can use other clauses in the SELECT statement for the SELECT INTO statement 
such as INNER JOIN, LEFT JOIN, GROUP BY, and HAVING.

Note that you cannot use the SELECT INTO statement in PL/pgSQL because it interprets the INTO clause differently.
In this case, you can use the CREATE TABLE AS statement which provides more functionality than the SELECT INTO statement.
*/

-- select into table
SELECT
    film_id,
    title,
    rental_rate
INTO TABLE film_r
FROM
    film
WHERE
    rating = 'R'
AND rental_duration = 5
ORDER BY
    title;

SELECT * FROM film_r;

-- select into TEMP table
/*
A temporary table, as its name implied, is a short-lived table that exists for the duration of a database session.
PostgreSQL automatically drops the temporary tables at the end of a session or a transaction.
*/

SELECT
    film_id,
    title,
    length 
INTO TEMP TABLE short_film
FROM
    film
WHERE
    length < 60
ORDER BY
    title;
	
SELECT * FROM short_film;

/* PostgreSQL CREATE TABLE AS */
/*
The CREATE TABLE AS statement creates a new table and fills it with the data returned by a query.

CREATE TABLE new_table_name
AS query;

. First, specify the new table name after the CREATE TABLE clause.
. Second, provide a query whose result set is added to the new table after the AS keyword.

CREATE TEMP TABLE new_table_name 
AS query; 

CREATE UNLOGGED TABLE new_table_name
AS query;

The columns of the new table will have the names and data types associated with the output columns of the SELECT clause.
If you want the table columns to have different names, you can specify the new table columns after the new table name:

CREATE TABLE new_table_name ( column_name_list)
AS query;

In case you want to avoid an error by creating a new table that already exists, you can use the IF NOT EXISTS option as follows:

CREATE TABLE IF NOT EXISTS new_table_name
AS query;
*/

CREATE TABLE action_film AS
SELECT
    film_id,
    title,
    release_year,
    length,
    rating
FROM
    film
INNER JOIN film_category USING (film_id)
WHERE
    category_id = 1;


SELECT * FROM action_film ORDER BY title;


/*
If the SELECT clause contains expressions, it is a good practice to override the columns, for example:
*/

CREATE TABLE IF NOT EXISTS film_rating (rating, film_count) 
AS 
SELECT
    rating,
    COUNT (film_id)
FROM
    film
GROUP BY
    rating;

/* Using PostgreSQL SERIAL To Create Auto-increment Column */
/*
In PostgreSQL, a sequence is a special kind of database object that generates a sequence of integers. 
A sequence is often used as the primary key column in a table.

When creating a new table, the sequence can be created through the SERIAL pseudo-type as follows:

CREATE TABLE table_name(
    id SERIAL
);

By assigning the SERIAL pseudo-type to the id column, PostgreSQL performs the following:

. First, create a sequence object and set the next value generated by the sequence as the default value for the column.
. Second, add a NOT NULL constraint to the id column because a sequence always generates an integer, which is a non-null value.
. Third, assign the owner of the sequence to the id column; as a result, the sequence object is deleted when the id column or table is dropped

Behind the scenes, is equivalent to the following statements:

CREATE SEQUENCE table_name_id_seq;
CREATE TABLE table_name (
    id integer NOT NULL DEFAULT nextval('table_name_id_seq')
);

ALTER SEQUENCE table_name_id_seq
OWNED BY table_name.id;

PostgreSQL provides three serial pseudo-types SMALLSERIAL, SERIAL, and BIGSERIAL with the following characteristics:

Name		Storage Size	Range
SMALLSERIAL	2 bytes			1 to 32,767
SERIAL		4 bytes			1 to 2,147,483,647
BIGSERIAL	8 bytes			1 to 9,223,372,036,854,775,807
*/

/*
It is important to note that the SERIAL does not implicitly create an index on the column 
or make the column as the primary key column. 
However, this can be done easily by specifying the PRIMARY KEY constraint for the SERIAL column.
*/

CREATE TABLE fruits(
   id SERIAL PRIMARY KEY,
   name VARCHAR NOT NULL
);

/*
To assign the default value for a serial column when you insert row into the table, 
you ignore the column name or use the DEFAULT keyword in the INSERT statement.
*/

INSERT INTO fruits(name) 
VALUES('Orange');

INSERT INTO fruits(id,name) 
VALUES(DEFAULT,'Apple');

SELECT * FROM fruits;

/*
To get the sequence name of a SERIAL column in a table, you use the pg_get_serial_sequence() function as follows:

pg_get_serial_sequence('table_name','column_name')

You can pass a sequence name to the  currval() function to get the recent value generated by the sequence. 
*/

SELECT currval(pg_get_serial_sequence('fruits', 'id'));

/* PostgreSQL Sequences */
/*
By definition, a sequence is an ordered list of integers.
The orders of numbers in the sequence are important. 
For example, {1,2,3,4,5} and {5,4,3,2,1} are entirely different sequences.

A sequence in PostgreSQL is a user-defined schema-bound object that generates a sequence of integers 
based on a specified specification.

CREATE SEQUENCE [ IF NOT EXISTS ] sequence_name
    [ AS { SMALLINT | INT | BIGINT } ]
    [ INCREMENT [ BY ] increment ]
    [ MINVALUE minvalue | NO MINVALUE ] 
    [ MAXVALUE maxvalue | NO MAXVALUE ]
    [ START [ WITH ] start ] 
    [ CACHE cache ] 
    [ [ NO ] CYCLE ]
    [ OWNED BY { table_name.column_name | NONE } ]

. sequence_name
Specify the name of the sequence after the CREATE SEQUENCE clause. 
The IF NOT EXISTS conditionally creates a new sequence only if it does not exist.
The sequence name must be distinct from any other sequences, tables, indexes, views, or foreign tables in the same schema.

[ AS { SMALLINT | INT | BIGINT } ]
Specify the data type of the sequence. 
The valid data type is SMALLINT, INT, and BIGINT. 
The default data type is BIGINT if you skip it.
The data type of the sequence which determines the sequence’s minimum and maximum values.

[ INCREMENT [ BY ] increment ]
The increment specifies which value to be added to the current sequence value to create new value.
A positive number will make an ascending sequence while a negative number will form a descending sequence.
The default increment value is 1.

[ MINVALUE minvalue | NO MINVALUE ]
[ MAXVALUE maxvalue | NO MAXVALUE ]
Define the minimum value and maximum value of the sequence. 
If you use NO MINVALUE and NO MAXVALUE, the sequence will use the default value.
For an ascending sequence, the default maximum value is the maximum value of the data type of the sequence 
and the default minimum value is 1.
In case of a descending sequence, the default maximum value is -1 
and the default minimum value is the minimum value of the data type of the sequence.

[ START [ WITH ] start ]
The START clause specifies the starting value of the sequence.
The default starting value is minvalue for ascending sequences and maxvalue for descending ones.

cache
The CACHE determines how many sequence numbers are preallocated and stored in memory for faster access. 
One value can be generated at a time.
By default, the sequence generates one value at a time i.e., no cache.

CYCLE | NO CYCLE
The CYCLE allows you to restart the value if the limit is reached.
The next number will be the minimum value for the ascending sequence and maximum value for the descending sequence.
If you use NO CYCLE, when the limit is reached, attempting to get the next value will result in an error.
The NO CYCLE is the default if you don’t explicitly specify CYCLE or NO CYCLE.

OWNED BY table_name.column_name
The OWNED BY clause allows you to associate the table column with the sequence 
so that when you drop the column or table, PostgreSQL will automatically drop the associated sequence.

Note that when you use the SERIAL pseudo-type for a column of a table, behind the scenes, 
PostgreSQL automatically creates a sequence associated with the column.
*/

-- 1) Creating an ascending sequence example

CREATE SEQUENCE mysequence
INCREMENT 5
START 100;

/*
To get the next value from the sequence to you use the nextval() function:
*/

SELECT nextval('mysequence');

-- 2) Creating a descending sequence example

CREATE SEQUENCE three
INCREMENT -1
MINVALUE 1 
MAXVALUE 3
START 3
CYCLE;

SELECT nextval('three');

-- 3) Creating a sequence associated with a table column

-- First, create a new table named order_details:
CREATE TABLE order_details(
    order_id SERIAL,
    item_id INT NOT NULL,
    item_text VARCHAR NOT NULL,
    price DEC(10,2) NOT NULL,
    PRIMARY KEY(order_id, item_id)
);

-- Second, create a new sequence associated with the item_id column of the order_details table
CREATE SEQUENCE order_item_id
START 10
INCREMENT 10
MINVALUE 10
OWNED BY order_details.item_id;

-- Third, insert three order line items into the order_details table:
INSERT INTO 
    order_details(order_id, item_id, item_text, price)
VALUES
    (100, nextval('order_item_id'),'DVD Player',100),
    (100, nextval('order_item_id'),'Android TV',550),
    (100, nextval('order_item_id'),'Speaker',250);
	
-- Fourth, query data from the order_details table:
SELECT
    order_id,
    item_id,
    item_text,
    price
FROM
    order_details;

/* Listing all sequences in a database */
SELECT
    relname sequence_name
FROM 
    pg_class 
WHERE 
    relkind = 'S';
	
/*
Deleting sequences
If a sequence is associated with a table column, 
it will be automatically dropped once the table column is removed or the table is dropped.

You can also remove a sequence manually using the DROP SEQUENCE statement:

DROP SEQUENCE [ IF EXISTS ] sequence_name [, ...] 
[ CASCADE | RESTRICT ];

. First, specify the name of the sequence which you want to drop.
The IF EXISTS option conditionally deletes the sequence if it exists. 
In case you want to drop multiple sequences at once, you can use a list of comma-separated sequence names.

. Then, use the CASCADE option if you want to recursively drops objects that depend on the sequence, 
and objects that depend on the dependent objects and so on.
*/

/* PostgreSQL Identity Column */
/*
PostgreSQL version 10 introduced a new constraint GENERATED AS IDENTITY 
that allows you to automatically assign a unique number to a column.

The GENERATED AS IDENTITY constraint is the SQL standard-conforming variant of the good old SERIAL column.

column_name type GENERATED { ALWAYS | BY DEFAULT } AS IDENTITY[ ( sequence_option ) ]

. The type can be SMALLINT, INT, or BIGINT.

. The GENERATED ALWAYS instructs PostgreSQL to always generate a value for the identity column. 
If you attempt to insert (or update) values into the GENERATED ALWAYS AS IDENTITY column, PostgreSQL will issue an error.

. The GENERATED BY DEFAULT also instructs PostgreSQL to generate a value for the identity column. 
However, if you supply a value for insert or update, PostgreSQL will use that value to insert into the identity column 
instead of using the system-generated value.

PostgreSQL allows you a table to have more than one identity column. 
Like the SERIAL, the GENERATED AS IDENTITY constraint also uses the SEQUENCE object internally.
*/

-- A) GENERATED ALWAYS example
-- First, create a table named color with the color_id as the identity column:
CREATE TABLE color (
    color_id INT GENERATED ALWAYS AS IDENTITY,
    color_name VARCHAR NOT NULL
);

-- Second, insert a new row into the color table:
INSERT INTO color(color_name)
VALUES ('Red');

-- Because color_id column has the GENERATED AS IDENTITY constraint,
-- PostgreSQL generates a value for it as shown in the query below:
SELECT * FROM color;

-- Third, insert a new row by supplying values for both color_id and color_name columns:

INSERT INTO color (color_id, color_name)
VALUES (2, 'Green');

-- PostgreSQL issued the following error:
/*
[Err] ERROR:  cannot insert into column "color_id"
DETAIL:  Column "color_id" is an identity column defined as GENERATED ALWAYS.
HINT:  Use OVERRIDING SYSTEM VALUE to override.
*/

-- To fix the error, you can use the OVERRIDING SYSTEM VALUE clause as follows:
INSERT INTO color (color_id, color_name)
OVERRIDING SYSTEM VALUE 
VALUES(2, 'Green');
-- Or use GENERATED BY DEFAULT AS IDENTITY instead.

-- B) GENERATED BY DEFAULT AS IDENTITY example

DROP TABLE color;

CREATE TABLE color (
    color_id INT GENERATED BY DEFAULT AS IDENTITY,
    color_name VARCHAR NOT NULL
);

INSERT INTO color (color_name)
VALUES ('White');

INSERT INTO color (color_id, color_name)
VALUES (2, 'Yellow');

SELECT * FROM color;

-- C) Sequence options example

DROP TABLE color;

CREATE TABLE color (
    color_id INT GENERATED BY DEFAULT AS IDENTITY 
    (START WITH 10 INCREMENT BY 10),
    color_name VARCHAR NOT NULL
);

INSERT INTO color (color_name)
VALUES ('Orange');

INSERT INTO color (color_name)
VALUES ('Purple');

SELECT * FROM color;

/* Adding an identity column to an existing table */
/*
ALTER TABLE table_name 
ALTER COLUMN column_name 
ADD GENERATED { ALWAYS | BY DEFAULT } AS IDENTITY { ( sequence_option ) }
*/

CREATE TABLE shape (
    shape_id INT NOT NULL,
    shape_name VARCHAR NOT NULL
);

ALTER TABLE shape 
ALTER COLUMN shape_id ADD GENERATED ALWAYS AS IDENTITY;
-- \d shape

/* Changing an identity column */
/*
ALTER TABLE table_name 
ALTER COLUMN column_name 
{ SET GENERATED { ALWAYS| BY DEFAULT } | 
  SET sequence_option | RESTART [ [ WITH ] restart ] }
*/

ALTER TABLE shape
ALTER COLUMN shape_id SET GENERATED BY DEFAULT;
-- \d shape

/* Removing the GENERATED AS IDENTITY constraint */
/*
ALTER TABLE table_name 
ALTER COLUMN column_name 
DROP IDENTITY [ IF EXISTS ]
*/

ALTER TABLE shape
ALTER COLUMN shape_id
DROP IDENTITY IF EXISTS;

/* PostgreSQL ALTER TABLE */

/*
ALTER TABLE table_name action;
*/

/*
PostgreSQL provides you with many actions:
. Add a column
. Drop a column
. Change the data type of a column
. Rename a column
. Set a default value for the column.
. Add a constraint to a column.
. Rename a table
*/

/*
. To add a new column to a table, you use ALTER TABLE ADD COLUMN statement:

ALTER TABLE table_name 
ADD COLUMN column_name datatype column_constraint;

. To drop a column from a table, you use ALTER TABLE DROP COLUMN statement:

ALTER TABLE table_name 
DROP COLUMN column_name;

. To rename a column, you use the ALTER TABLE RENAME COLUMN TO statement:

ALTER TABLE table_name 
RENAME COLUMN column_name 
TO new_column_name;

. To change a default value of the column, you use ALTER TABLE ALTER COLUMN SET DEFAULT or  DROP DEFAULT:

ALTER TABLE table_name 
ALTER COLUMN column_name 
[SET DEFAULT value | DROP DEFAULT];

. To change the NOT NULL constraint, you use ALTER TABLE ALTER COLUMN statement:

ALTER TABLE table_name 
ALTER COLUMN column_name 
[SET NOT NULL| DROP NOT NULL];

. To add a CHECK constraint, you use ALTER TABLE ADD CHECK statement:

ALTER TABLE table_name 
ADD CHECK expression;

. Generailly, to add a constraint to a table, you use ALTER TABLE ADD CONSTRAINT statement:

ALTER TABLE table_name 
ADD CONSTRAINT constraint_name constraint_definition;

. To rename a table you use ALTER TABLE RENAME TO statement:

ALTER TABLE table_name 
RENAME TO new_table_name;
*/

DROP TABLE IF EXISTS links;
CREATE TABLE links (
   link_id serial PRIMARY KEY,
   title VARCHAR (512) NOT NULL,
   url VARCHAR (1024) NOT NULL
);

-- add column
ALTER TABLE links
ADD COLUMN active boolean;

-- remove column
ALTER TABLE links 
DROP COLUMN active;

-- rename column
ALTER TABLE links 
RENAME COLUMN title TO link_title;

ALTER TABLE links 
ADD COLUMN target VARCHAR(10);

-- set default in column
ALTER TABLE links 
ALTER COLUMN target
SET DEFAULT '_blank';

INSERT INTO links (link_title, url)
VALUES('PostgreSQL Tutorial','https://www.postgresqltutorial.com/');

SELECT * FROM links;

-- adds a CHECK condition to 'target' column so only accepts the following values: _self, _blank, _parent, and _top:
ALTER TABLE links 
ADD CHECK (target IN ('_self', '_blank', '_parent', '_top'));

INSERT INTO links(link_title,url,target) 
VALUES('PostgreSQL','http://www.postgresql.org/','whatever');
/*
ERROR:  new row for relation "links" violates check constraint "links_target_check"
DETAIL:  Failing row contains (2, PostgreSQL, http://www.postgresql.org/, whatever).
*/

-- adds a UNIQUE constraint to 'url' column
ALTER TABLE links 
ADD CONSTRAINT unique_url UNIQUE ( url );

INSERT INTO links(link_title,url) 
VALUES('PostgreSQL','https://www.postgresqltutorial.com/');
/*
ERROR:  duplicate key value violates unique constraint "unique_url"
DETAIL:  Key (url)=(https://www.postgresqltutorial.com/) already exists.
*/

-- rename table
ALTER TABLE links 
RENAME TO urls;

/* PostgreSQL Rename Table */
/*
ALTER TABLE [IF EXISTS] table_name
RENAME TO new_table_name;
*/

DROP TABLE IF EXISTS vendors;
CREATE TABLE vendors (
    id serial PRIMARY KEY,
    name VARCHAR NOT NULL
);

-- rename
ALTER TABLE vendors RENAME TO suppliers;

CREATE TABLE supplier_groups (
    id serial PRIMARY KEY,
    name VARCHAR NOT NULL
);

ALTER TABLE suppliers 
ADD COLUMN group_id INT NOT NULL;

ALTER TABLE suppliers 
ADD FOREIGN KEY (group_id) REFERENCES supplier_groups (id);

CREATE VIEW supplier_data 
AS SELECT
    s.id,
    s.name,
    g.name  supply_group
FROM
    suppliers s
INNER JOIN supplier_groups g ON g.id = s.group_id;

/*
When you rename a table to the new one, 
PostgreSQL will automatically update its dependent objects such as foreign key constraints, views, and indexes.
*/

-- \d suppliers

ALTER TABLE supplier_groups RENAME TO groups;

-- \d suppliers
-- \d+ supplier_data

/* PostgreSQL ADD COLUMN: Add One Or More Columns To a Table */
/*
ALTER TABLE table_name
ADD COLUMN new_column_name data_type constraint;
*/

/*
To add multiple columns

ALTER TABLE table_name
ADD COLUMN column_name1 data_type constraint,
ADD COLUMN column_name2 data_type constraint,
...
ADD COLUMN column_namen data_type constraint;

*/

DROP TABLE IF EXISTS customers CASCADE;
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR NOT NULL
);

-- add column
ALTER TABLE customers 
ADD COLUMN phone VARCHAR;

-- add multiple columns
ALTER TABLE customers
ADD COLUMN fax VARCHAR,
ADD COLUMN email VARCHAR;

-- \d customers

/* Add a column with the NOT NULL constraint to a table that already has data */

INSERT INTO 
   customers (customer_name)
VALUES
   ('Apple'),
   ('Samsung'),
   ('Sony');

-- add column
ALTER TABLE customers 
ADD COLUMN contact_name VARCHAR NOT NULL;
--ERROR:  column "contact_name" contains null values
/*
This is because the contact_name column has the NOT NULL constraint. 
When PostgreSQL added the column, this new column receive NULL, which violates the NOT NULL constraint.
*/

-- To solve this problem…
-- First, add the column without the NOT NULL constraint:
ALTER TABLE customers 
ADD COLUMN contact_name VARCHAR;

-- Second, update the values in the contact_name column.
UPDATE customers
SET contact_name = 'John Doe'
WHERE id = 1;

UPDATE customers
SET contact_name = 'Mary Doe'
WHERE id = 2;

UPDATE customers
SET contact_name = 'Lily Bush'
WHERE id = 3;

-- Third, set the NOT NULL constraint for the contact_name column.
ALTER TABLE customers
ALTER COLUMN contact_name SET NOT NULL;

SELECT * FROM customers;

/* PostgreSQL DROP COLUMN: Remove One or More Columns of a Table */
/*

ALTER TABLE table_name 
DROP COLUMN [IF EXISTS] column_name;

When you remove a column from a table, PostgreSQL will automatically remove all of the indexes 
and constraints that involved the dropped column.
If the column that you want to remove is used in other database objects such as views, triggers, stored procedures, etc., 
you cannot drop the column because other objects are depending on it. 
In this case, you need to add the CASCADE option to the DROP COLUMN clause to drop the column and all of its dependent objects:

ALTER TABLE table_name 
DROP COLUMN column_name CASCADE;

If you want to drop multiple columns of a table:

ALTER TABLE table_name
DROP COLUMN column_name1,
DROP COLUMN column_name2,
...;

*/

DROP TABLE IF EXISTS publishers CASCADE;
CREATE TABLE publishers (
    publisher_id serial PRIMARY KEY,
    name VARCHAR NOT NULL
);

DROP TABLE IF EXISTS categories CASCADE;
CREATE TABLE categories (
    category_id serial PRIMARY KEY,
    name VARCHAR NOT NULL
);

DROP TABLE IF EXISTS books CASCADE;
CREATE TABLE books (
    book_id serial PRIMARY KEY,
    title VARCHAR NOT NULL,
    isbn VARCHAR NOT NULL,
    published_date DATE NOT NULL,
    description VARCHAR,
    category_id INT NOT NULL,
    publisher_id INT NOT NULL,
    FOREIGN KEY (publisher_id) 
       REFERENCES publishers (publisher_id),
    FOREIGN KEY (category_id) 
       REFERENCES categories (category_id)
);

CREATE VIEW book_info 
AS SELECT
    book_id,
    title,
    isbn,
    published_date,
    name
FROM
    books b
INNER JOIN publishers 
    USING(publisher_id)
ORDER BY title;

ALTER TABLE books 
DROP COLUMN category_id;

-- \d books

ALTER TABLE books 
DROP COLUMN publisher_id;
/*
ERROR:  cannot drop table books column publisher_id because other objects depend on it
DETAIL:  view book_info depends on table books column publisher_id
HINT:  Use DROP ... CASCADE to drop the dependent objects too.
*/

ALTER TABLE books 
DROP COLUMN publisher_id CASCADE;
-- NOTICE:  drop cascades to view book_info

-- delete multiple
ALTER TABLE books 
DROP COLUMN isbn,
DROP COLUMN description;

/* PostgreSQL Change Column Type */
/*

ALTER TABLE table_name
ALTER COLUMN column_name [SET DATA] TYPE new_data_type;

ALTER TABLE table_name
ALTER COLUMN column_name1 [SET DATA] TYPE new_data_type,
ALTER COLUMN column_name2 [SET DATA] TYPE new_data_type,
...;

PostgreSQL allows you to convert the values of a column to the new ones 
while changing its data type by adding a USING clause as follows:

ALTER TABLE table_name
ALTER COLUMN column_name TYPE new_data_type USING expression;

The USING clause specifies an expression that allows you to convert the old values to the new ones.
If you omit the USING clause, PostgreSQL will cast the values to the new ones implicitly. 
In case the cast fails, PostgreSQL will issue an error 
and recommends you provide the USING clause with an expression for the data conversion.
The expression after the USING keyword can be as simple 
as column_name::new_data_type such as price::numeric or as complex as a custom function.
*/

CREATE TABLE assets (
    id serial PRIMARY KEY,
    name TEXT NOT NULL,
    asset_no VARCHAR NOT NULL,
    description TEXT,
    location TEXT,
    acquired_date DATE NOT NULL
);

INSERT INTO assets(name,asset_no,location,acquired_date)
VALUES('Server','10001','Server room','2017-01-01'),
      ('UPS','10002','Server room','2017-01-01');

-- change type
ALTER TABLE assets 
ALTER COLUMN name TYPE VARCHAR;

-- change multiple
ALTER TABLE assets 
ALTER COLUMN location TYPE VARCHAR,
ALTER COLUMN description TYPE VARCHAR;

-- error
ALTER TABLE assets 
ALTER COLUMN asset_no TYPE INT;
/*
ERROR:  column "asset_no" cannot be cast automatically to type integer
HINT:  You might need to specify "USING asset_no::integer".
*/

ALTER TABLE assets
ALTER COLUMN asset_no TYPE INT 
USING asset_no::integer;

/* PostgreSQL RENAME COLUMN */
/*

ALTER TABLE table_name 
RENAME COLUMN column_name TO new_column_name;

For some reason, if you try to rename a column that does not exist, PostgreSQL will issue an error.
Unfortunately that PostgreSQL does not provide the IF EXISTS option for the RENAME clause.

To rename multiple columns, you need to execute the ALTER TABLE RENAME COLUMN statement multiple times, one column at a time:

ALTER TABLE table_name
RENAME column_name1 TO new_column_name1;

ALTER TABLE table_name
RENAME column_name2 TO new_column_name2;

If you rename a column referenced by other database objects such as views, foreign key constraints, 
triggers, and stored procedures, PostgreSQL will automatically change the column name in the dependent objects.
*/

DROP TABLE IF EXISTS customer_groups;
CREATE TABLE customer_groups (
    id serial PRIMARY KEY,
    name VARCHAR NOT NULL
);

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    id serial PRIMARY KEY,
    name VARCHAR NOT NULL,
    phone VARCHAR NOT NULL,
    email VARCHAR,
    group_id INT,
    FOREIGN KEY (group_id) REFERENCES customer_groups (id)
);

CREATE VIEW customer_data 
AS SELECT
    c.id,
    c.name,
    g.name customer_group
FROM
    customers c
INNER JOIN customer_groups g ON g.id = c.group_id;

-- 1) Using RENAME COLUMN to rename one column example

ALTER TABLE customers 
RENAME COLUMN email TO contact_email;

-- 2) Using RENAME COLUMN to rename a column that has dependent objects example

ALTER TABLE customer_groups 
RENAME COLUMN name TO group_name;

-- \d+ customer_data;

-- 3) Using multiple RENAME COLUMN to rename multiple columns example

ALTER TABLE customers 
RENAME COLUMN name TO customer_name;

ALTER TABLE customers
RENAME COLUMN phone TO contact_phone;

/* PostgreSQL DROP TABLE */
/*

DROP TABLE [IF EXISTS] table_name 
[CASCADE | RESTRICT];

If you remove a table that does not exist, PostgreSQL issues an error.
To avoid this situation, you can use the IF EXISTS option.

In case the table that you want to remove is used in other objects such as views, triggers, functions, 
and stored procedures, the DROP TABLE cannot remove the table. In this case, you have two options:

. The CASCADE option allows you to remove the table and its dependent objects.

. The RESTRICT option rejects the removal if there is any object depends on the table. 
The RESTRICT option is the default if you don’t explicitly specify it in the DROP TABLE statement.

To remove multiple tables at once, you can place a comma-separated list of tables after the DROP TABLE keywords:

DROP TABLE [IF EXISTS] 
   table_name_1,
   table_name_2,
   ...
[CASCADE | RESTRICT];

Note that you need to have the roles of the superuser, schema owner, or table owner in order to drop tables.
*/

-- 1) Drop a table that does not exist

DROP TABLE author;
-- [Err] ERROR:  table "author" does not exist

DROP TABLE IF EXISTS author;
-- NOTICE:  table "author" does not exist, skipping DROP TABLE

-- 2) Drop a table that has dependent objects

CREATE TABLE authors (
	author_id INT PRIMARY KEY,
	firstname VARCHAR (50),
	lastname VARCHAR (50)
);

CREATE TABLE pages (
	page_id serial PRIMARY KEY,
	title VARCHAR (255) NOT NULL,
	contents TEXT,
	author_id INT NOT NULL,
	FOREIGN KEY (author_id) 
          REFERENCES authors (author_id)
);

DROP TABLE IF EXISTS authors;
/*
ERROR:  cannot drop table authors because other objects depend on it
DETAIL:  constraint pages_author_id_fkey on table pages depends on table authors
HINT:  Use DROP ... CASCADE to drop the dependent objects too.
SQL state: 2BP01
*/

DROP TABLE authors CASCADE;
-- NOTICE:  drop cascades to constraint pages_author_id_fkey on table pages

-- 3) Drop multiple tables

CREATE TABLE tvshows(
	tvshow_id INT GENERATED ALWAYS AS IDENTITY,
	title VARCHAR,
	release_year SMALLINT,
	PRIMARY KEY(tvshow_id)
);

CREATE TABLE animes(
	anime_id INT GENERATED ALWAYS AS IDENTITY,
	title VARCHAR,
	release_year SMALLINT,
	PRIMARY KEY(anime_id)
);

DROP TABLE tvshows, animes;

/* PostgreSQL Temporary Table */
/*
A temporary table, as its name implied, is a short-lived table that exists for the duration of a database session.
PostgreSQL automatically drops the temporary tables at the end of a session or a transaction.

CREATE TEMPORARY TABLE temp_table_name(
   column_list
);

CREATE TEMP TABLE temp_table(
   ...
);

A temporary table is visible only to the session that creates it.
In other words, it is invisible to other sessions.

postgres=# CREATE DATABASE testa;
CREATE DATABASE
postgres-# \c testa;
You are now connected to database "test" as user "postgres".

test=# CREATE TEMP TABLE mytemp(c INT);
CREATE TABLE
test=# SELECT * FROM mytemp;
 c
---
(0 rows)

Then, launch another session that connects to the test database and query data from the mytemp table:

test=# SELECT * FROM mytemp;
ERROR:  relation "mytemp" does not exist
LINE 1: SELECT * FROM mytemp;

As can see clearly from the output, the second session could not see the mytemp table.
Only the first session can access it.

After that, quit all the sessions:

test=# \q

Finally, log in to the database server again and query data from the mytemp table:

test=# SELECT * FROM mytemp;
ERROR:  relation "mytemp" does not exist
LINE 1: SELECT * FROM mytemp;
                      ^
The mytemp table does not exist because it has been dropped automatically when the session ended, 
therefore, PostgreSQL issued an error.
*/

/* PostgreSQL TRUNCATE TABLE */
/*
To remove all data from a table, you use the DELETE statement.
However, when you use the DELETE statement to delete all data from a table that has a lot of data, it is not efficient.
In this case, you need to use the TRUNCATE TABLE statement:

TRUNCATE TABLE table_name;

The  TRUNCATE TABLE statement deletes all data from a table without scanning it. 
This is the reason why it is faster than the DELETE statement.

In addition, the TRUNCATE TABLE statement reclaims the storage right away so you do not have 
to perform a subsequent VACUMM operation, which is useful in the case of large tables.
*/

/*
Remove all data from one table

TRUNCATE TABLE table_name;

Besides removing data, you may want to reset the values in the identity column by using the RESTART IDENTITY option like this:

TRUNCATE TABLE table_name 
RESTART IDENTITY;

By default, the  TRUNCATE TABLE statement uses the CONTINUE IDENTITY option. 
This option basically does not restart the value in sequence associated with the column in the table.
*/

/*
Remove all data from multiple tables

TRUNCATE TABLE 
    table_name1, 
    table_name2,
    ...;
*/

/*
Remove all data from a table that has foreign key references

In practice, the table you want to truncate often has the foreign key references from other tables 
that are not listed in the  TRUNCATE TABLE statement.
By default, the  TRUNCATE TABLE statement does not remove any data from the table that has foreign key references.

To remove data from a table and other tables that have foreign key reference the table, 
you use CASCADE option in the TRUNCATE TABLE statement as follows :

TRUNCATE TABLE table_name 
CASCADE;

The CASCADE option should be used with further consideration or you may potentially delete data from tables that you did not want.
By default, the TRUNCATE TABLE statement uses the RESTRICT option which prevents you 
from truncating the table that has foreign key constraint references.

PostgreSQL TRUNCATE TABLE and ON DELETE trigger
Even though the  TRUNCATE TABLE statement removes all data from a table, 
it does not fire any  ON DELETE triggers associated with the table.

To fire the trigger when the  TRUNCATE TABLE command applied to a table, 
you must define  BEFORE TRUNCATE and/or  AFTER TRUNCATE triggers for that table.

PostgreSQL TRUNCATE TABLE and transaction
The  TRUNCATE TABLE is transaction-safe. It means that if you place it within a transaction, you can roll it back safely.

Summary
. Use the TRUNCATE TABLE statement to delete all data from a large table.
. Use the CASCADE option to truncate a table and other tables that reference the table via foreign key constraint.
. The TRUNCATE TABLE does not fire ON DELETE trigger. Instead, it fires the BEFORE TRUNCATE and AFTER TRUNCATE triggers.
. The TRUNCATE TABLE statement is transaction-safe.
*/