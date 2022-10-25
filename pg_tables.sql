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