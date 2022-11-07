SELECT Version();
-- PostgreSQL 15.0, compiled by Visual C++ build 1914, 64-bit

/* PostgreSQL Boolean type */
/*
PostgreSQL supports a single Boolean data type.

BOOLEAN that can have three values:
. true
. false
. NULL

PostgreSQL uses one byte for storing a boolean value in the database. 

The BOOLEAN can be abbreviated as BOOL.

In standard SQL, a Boolean value can be TRUE, FALSE, or NULL. 
However, PostgreSQL is quite flexible when dealing with TRUE and FALSE values.

The following table shows the valid literal values for TRUE and FALSE in PostgreSQL.
True	False
true	false
‘t’		‘f ‘
‘true’	‘false’
‘y’		‘n’
‘yes’	‘no’
‘1’		‘0’

Note that the leading or trailing whitespace does not matter 
and all the constant values except for 'true' and 'false' must be enclosed in single quotes.
*/

CREATE TABLE stock_availability (
   product_id INT PRIMARY KEY,
   available BOOLEAN NOT NULL
);

INSERT INTO stock_availability (product_id, available)
VALUES
	(100, TRUE),
	(200, FALSE),
	(300, 't'),
	(400, '1'),
	(500, 'y'),
	(600, 'yes'),
	(700, 'no'),
	(800, '0');

-- true
SELECT *
FROM stock_availability
WHERE available = 'yes';

-- equivalent
SELECT *
FROM stock_availability
WHERE available;

-- false
SELECT *
FROM stock_availability
WHERE available = 'no';

-- equivalent
SELECT *
FROM stock_availability
WHERE NOT available;

-- Set a default value of the Boolean column

ALTER TABLE stock_availability 
ALTER COLUMN available
SET DEFAULT FALSE;

INSERT INTO stock_availability (product_id)
VALUES (900);

SELECT *
FROM stock_availability
WHERE product_id = 900;

/*
Likewise, if you want to set a default value for a Boolean column when you create a table, 
you use the DEFAULT constraint in the column definition as follows:

CREATE TABLE boolean_demo(
   ...
   is_ok BOOL DEFAULT 't'
);
*/
-----------------------------------------------------------------------------------------------------

/* PostgreSQL Character Types: CHAR, VARCHAR, and TEXT */
/*
PostgreSQL provides three primary character types: 
. CHARACTER(n) or CHAR(n)
. CHARACTER VARYINGING(n) or VARCHAR(n)
. TEXT
* where n is a positive integer.

The following table illstrate the character types in PostgreSQL:

Character Types						Description
CHARACTER VARYING(n), VARCHAR(n)	variable-length with length limit
CHARACTER(n), CHAR(n)				fixed-length, blank padded
TEXT, VARCHAR						variable unlimited length

Both CHAR(n) and VARCHAR(n) can store up to n characters. 
If you try to store a string that has more than n characters, PostgreSQL will issue an error.

However, one exception is that if the excessive characters are all spaces, 
PostgreSQL truncates the spaces to the maximum length (n) and stores the characters.

If a string explicitly casts to a CHAR(n) or VARCHAR(n), 
PostgreSQL will truncate the string to n characters before inserting it into the table.

The TEXT data type can store a string with unlimited length.

If you do not specify the n integer for the VARCHAR data type, it behaves like the TEXT datatype. 
The performance of the VARCHAR (without the size n) and TEXT are the same.

The only advantage of specifying the length specifier for the VARCHAR data type is that PostgreSQL will issue an error 
if you attempt to insert a string that has more than n characters into the VARCHAR(n) column.

Unlike VARCHAR, The CHARACTER or CHAR without the length specifier (n) is the same as the CHARACTER(1) or CHAR(1).

Different from other database systems, in PostgreSQL, there is no performance difference among three character types.

In most cases, you should use TEXT or VARCHAR. 
And you use the VARCHAR(n) when you want PostgreSQL to check for the length.
*/

CREATE TABLE character_tests (
	id serial PRIMARY KEY,
	x CHAR (1),
	y VARCHAR (10),
	z TEXT
);

INSERT INTO character_tests (x, y, z)
VALUES('Yes','This is a test for varchar','This is a very long text for the PostgreSQL text column'
	);
-- ERROR:  value too long for type character(1)

INSERT INTO character_tests (x, y, z)
VALUES(	'Y','This is a test for varchar','This is a very long text for the PostgreSQL text column'	);
-- ERROR:  value too long for type character varying(10)

INSERT INTO character_tests (x, y, z)
VALUES(	'Y','varchar(n)','This is a very long text for the PostgreSQL text column'
	);
	
SELECT * FROM character_tests;

/*
Summary

. PostgreSQL supports CHAR, VARCHAR, and TEXT data types. 
The CHAR is fixed-length character type while the VARCHAR and TEXT are varying length character types.

. Use VARCHAR(n) if you want to validate the length of the string (n) before inserting into or updating to a column.

. VARCHAR (without the length specifier) and TEXT are equivalent.
*/
-----------------------------------------------------------------------------------------------------

/* PostgreSQL NUMERIC data type */
/*
The NUMERIC type can store numbers with a lot of digits.
Typically, you use the NUMERIC type for numbers that require exactness such as monetary amounts or quantities.

The following illustrate the syntax of the NUMERIC type:

NUMERIC(precision, scale)

In this syntax, the precision is the total number of digits and the scale is the number of digits in the fraction part.
For example, the number 1234.567 has the precision 7 and scale 3.

The NUMERIC type can hold a value up to 131,072 digits before the decimal point 16,383 digits after the decimal point.

The scale of the NUMERIC type can be zero or positive.

NUMERIC(precision)

If you omit both precision and scale, you can store any precision and scale up to the limit of the precision and scale mentioned above.

NUMERIC

In PostgreSQL, the NUMERIC and DECIMAL types are equivalent and both of them are also a part of SQL standard.

If precision is not required,
you should not use the NUMERIC type because calculations on NUMERIC values are typically slower than 
integers, floats, and double precisions.
*/

/*
Table 8.2. Numeric Types

Name	            Storage Size	                        Description	Range
smallint	        2 bytes	small-range integer	            -32768 to +32767
integer	            4 bytes	typical choice for integer	    -2147483648 to +2147483647
bigint	            8 bytes	large-range integer	            -9223372036854775808 to +9223372036854775807
decimal	variable	user-specified precision, exact	        up to 131072 digits before the decimal point; up to 16383 digits after the decimal point
numeric	variable	user-specified precision, exact	        up to 131072 digits before the decimal point; up to 16383 digits after the decimal point
real	            4 bytes	variable-precision, inexact	    6 decimal digits precision
double precision	8 bytes	variable-precision, inexact	    15 decimal digits precision
smallserial	        2 bytes	small autoincrementing integer	1 to 32767
serial	            4 bytes	autoincrementing integer	    1 to 2147483647
bigserial	        8 bytes	large autoincrementing integer	1 to 9223372036854775807
*/

-- 1) Storing numeric values

DROP TABLE IF EXISTS products;
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(5,2)
);

INSERT INTO products (name, price)
VALUES ('Phone',500.215), 
       ('Tablet',500.214);
	   
SELECT * FROM products;

-- error
INSERT INTO products (name, price)
VALUES('Phone',123456.21);
/*
ERROR:  numeric field overflow
DETAIL:  A field with precision 5, scale 2 must round to an absolute value less than 10^3.
*/

-- PostgreSQL NUMERIC type and NaN
/*
In addition to holding numeric values,
the NUMERIC type can also hold a special value called NaN which stands for not-a-number.
*/

UPDATE products
SET price = 'NaN'
WHERE id = 1;

SELECT * FROM products;

/*
Typically, the NaN is not equal to any number including itself.
It means that the expression NaN = NaN returns false.

However, two NaN values are equal and NaN is greater than other numbers. 
This implementation allows PostgreSQL to sort NUMERIC values and use them in tree-based indexes.
*/

SELECT * FROM products
ORDER BY price DESC;
-----------------------------------------------------------------------------------------------------

/* PostgreSQL integer types */
/*
To store the whole numbers in PostgreSQL, you use one of the following integer types:
. SMALLINT
. INTEGER
. BIGINT

The following table illustrates the specification of each integer type:

Name		Storage Size	Min							Max
SMALLINT	2 bytes			-32,768						+32,767
INTEGER		4 bytes			-2,147,483,648				+2,147,483,647
BIGINT		8 bytes			-9,223,372,036,854,775,808	+9,223,372,036,854,775,807

If you try to store a value outside of the permitted range, PostgreSQL will issue an error.

Unlike MySQL integer, PostgreSQL does not provide unsigned integer types.
*/

-- SMALLINT
DROP TABLE IF EXISTS books;
CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR (255) NOT NULL,
    pages SMALLINT NOT NULL CHECK (pages > 0)
);

-- INTEGER
CREATE TABLE cities (
    city_id serial PRIMARY KEY,
    city_name VARCHAR (255) NOT NULL,
    population INT NOT NULL CHECK (population >= 0)
);
-----------------------------------------------------------------------------------------------------

/* PostgreSQL SERIAL */
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
-----------------------------------------------------------------------------------------------------

/* PostgreSQL Date */
/*
To store date values, you use the PostgreSQL DATE data type. 
PostgreSQL uses 4 bytes to store a date value. 
The lowest and highest values of the DATE data type are 4713 BC and 5874897 AD.

When storing a date value, PostgreSQL uses the  yyyy-mm-dd format e.g., 2000-12-31. 
It also uses this format for inserting data into a date column.

If you create a table that has a DATE column and you want to use the current date as the default value for the column, 
you can use the CURRENT_DATE after the DEFAULT keyword.
*/

DROP TABLE IF EXISTS documents;

CREATE TABLE documents (
	document_id serial PRIMARY KEY,
	header_text VARCHAR (255) NOT NULL,
	posting_date DATE NOT NULL DEFAULT CURRENT_DATE
);

INSERT INTO documents (header_text)
VALUES('Billing to customer XYZ');

SELECT * FROM documents;

-- PostgreSQL DATE functions

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
	employee_id serial PRIMARY KEY,
	first_name VARCHAR (255),
	last_name VARCHAR (355),
	birth_date DATE NOT NULL,
	hire_date DATE NOT NULL
);

INSERT INTO employees (first_name, last_name, birth_date, hire_date)
VALUES ('Shannon','Freeman','1980-01-01','2005-01-01'),
	   ('Sheila','Wells','1978-02-05','2003-01-01'),
	   ('Ethel','Webb','1975-01-01','2001-01-01');

-- 1) Get the current date
/*
To get the current date and time, you use the built-in NOW() function.
However, to get the date part only (without the time part), 
you use the double colons (::) to cast a DATETIME value to a DATE value.
*/

SELECT NOW();
SELECT NOW()::date;
SELECT CURRENT_DATE;

-- 2) Output a PostgreSQL date value in a specific format
/*
To output a date value in a specific format, you use the TO_CHAR() function. 
The TO_CHAR() function accepts two parameters. 
The first parameter is the value that you want to format, 
and the second one is the template that defines the output format.
*/

SELECT TO_CHAR(NOW() :: DATE, 'dd/mm/yyyy');
SELECT TO_CHAR(NOW() :: DATE, 'Mon dd, yyyy');

-- 3) Get the interval between two dates
-- To get the interval between two dates, you use the minus (-) operator.

SELECT
	first_name,
	last_name,
	now() - hire_date as diff
FROM
	employees;

-- 4) Calculate ages in years, months, and days
-- To calculate age at the current date in years, months, and days, you use the AGE() function.

SELECT
	employee_id,
	first_name,
	last_name,
	AGE(birth_date)
FROM
	employees;
	
/*
If you pass a date value to the AGE() function, it will subtract that date value from the current date. 
If you pass two arguments to the AGE() function, it will subtract the second argument from the first
*/

SELECT
	employee_id,
	first_name,
	last_name,
	age('2015-01-01',birth_date)
FROM
	employees;
	
-- 5) Extract year, quarter, month, week, day from a date value
-- To get the year, quarter, month, week, day from a date value, you use the EXTRACT() function.

SELECT
	employee_id,
	first_name,
	last_name,
	EXTRACT (YEAR FROM birth_date) AS YEAR,
	EXTRACT (MONTH FROM birth_date) AS MONTH,
	EXTRACT (DAY FROM birth_date) AS DAY
FROM
	employees;
-----------------------------------------------------------------------------------------------------

/* PostgreSQL timestamp */
/*
PostgreSQL provides you with two temporal data types for handling timestamp:
. timestamp: a timestamp without timezone one.
. timestamptz: timestamp with a timezone.

The timestamp datatype allows you to store both date and time. 
However, it does not have any time zone data. 
It means that when you change the timezone of your database server, 
the timestamp value stored in the database will not change automatically.

The timestamptz datatype is the timestamp with the time zone. 
The timestamptz datatype is a time zone-aware date and time data type.

PostgreSQL stores the timestamptz in UTC value. 

When you insert a value into a timestamptz column, PostgreSQL converts the timestamptz value into a UTC value 
and stores the UTC value in the table.
When you query timestamptz from the database, PostgreSQL converts the UTC value back to the time value of the timezone 
set by the database server, the user, or the current database connection.
*/

CREATE TABLE timestamp_demo (
    ts TIMESTAMP, 
    tstz TIMESTAMPTZ
);

SET timezone = 'America/Los_Angeles';

SHOW TIMEZONE;

INSERT INTO timestamp_demo (ts, tstz)
VALUES('2016-06-22 19:10:25-07','2016-06-22 19:10:25-07');

SELECT ts, tstz FROM timestamp_demo;

-- change time zone
SET timezone = 'America/New_York';

SELECT ts, tstz FROM timestamp_demo;

-- timezone names
SELECT * FROM pg_timezone_names;
SELECT * FROM pg_timezone_names WHERE name LIKE 'Europe%';
SET timezone = 'Europe/Paris';
SELECT NOW();

/*
The value in the timestamp column does not change,
whereas the value in the timestamptz column is adjusted to the new time zone of 'America/New_York'.

Generally, it is a good practice to use the timestamptz datatype to store the timestamp data.
*/

-- PostgreSQL timestamp functions
-- Getting the current time

SELECT NOW();
SELECT CURRENT_TIMESTAMP;
SELECT TIMEOFDAY();

-- Convert between timezones

SHOW TIMEZONE;

SELECT timezone('America/New_York',NOW());
SELECT timezone('America/New_York','2016-06-01 00:00');
SELECT timezone('America/New_York','2016-06-01 00:00'::timestamptz);
-----------------------------------------------------------------------------------------------------

/* PostgreSQL interval */
/*
The interval data type allows you to store and manipulate a period of time in 
years, months, days, hours, minutes, seconds, etc. The following illustrates the interval type:

@ interval [ fields ] [ (p) ]   

An interval value requires 16 bytes storage size that can store a period with the allowed range 
from -178,000,000 years to 178,000,000 years.

In addition, an interval value can have an optional precision value p with the permitted range is from 0 to 6. 
The precisionp is the number of fraction digits retained in the second field.

The at sign ( @) is optional therefore you can omit it.

The following  examples show some interval values:

interval '2 months ago';
interval '3 hours 20 minutes';

Internally, PostgreSQL stores interval values as months, days, and seconds. 
The months and days values are integers while the seconds can field can have fractions.

The interval values are very useful when doing date or time arithmetic. 
*/

SELECT
	now(),
	now() - INTERVAL '1 year 3 hours 20 minutes' 
             AS "3 hours 20 minutes ago of last year";

-- PostgreSQL interval input format
/*
quantity unit [quantity unit...] [direction]

. quantity is a number, sign + or - is also accepted
. unit can be any of millennium, century, decade, year, month, week, day, hour, minute, second, millisecond, microsecond, 
or abbreviation (y, m, d, etc.,) or plural forms (months, days, etc.).
. direction can be ago or empty string ''

This format is called postgres_verbose which is also used for the interval output format.

INTERVAL '1 year 2 months 3 days';
INTERVAL '2 weeks ago';
*/

-- ISO 8601 interval format
-- ...

-- PostgreSQL interval output format
/*
The output style of interval values is set by using the SET intervalstyle command, for example:

SET intervalstyle = 'sql_standard';

PostgreSQL provides four output formats:
. sql standard
. postgres
. postgresverbose
. iso_8601

PostgresQL uses the postgres style by default for formatting the interval values.
*/

SET intervalstyle = 'sql_standard';
SELECT
INTERVAL '6 years 5 months 4 days 3 hours 2 minutes 1 second';

SET intervalstyle = 'postgres';
SELECT
INTERVAL '6 years 5 months 4 days 3 hours 2 minutes 1 second';

SET intervalstyle = 'postgres_verbose';
SELECT
INTERVAL '6 years 5 months 4 days 3 hours 2 minutes 1 second';

SET intervalstyle = 'iso_8601';
SELECT
INTERVAL '6 years 5 months 4 days 3 hours 2 minutes 1 second';

-- PostgreSQL interval related operators and functions
/*
Interval operators
You can apply the arithmetic operator ( +, -, *, etc.,) to the interval values, for examples:
*/

SELECT
INTERVAL '2h 50m' + INTERVAL '10m'; -- 03:00:00

SELECT
INTERVAL '2h 50m' - INTERVAL '50m'; -- 02:00:00

SELECT
600 * INTERVAL '1 minute'; -- 10:00:00

-- Converting PostgreSQL interval to string
/*
To convert an interval value to string, you use the TO_CHAR() function.

TO_CHAR(interval,format)

The TO_CHAR() function takes the first argument as an interval value, 
the second one as the format, and returns a string that represents the interval in the specified format.
*/

SELECT
    TO_CHAR(
        INTERVAL '17h 20m 05s',
        'HH24:MI:SS'
    );

-- Extracting data from a PostgreSQL interval
/*
To extract field such as year, month, date, etc., from an interval, you use the EXTRACT() function.

EXTRACT(field FROM interval)

The field can be the year, month, date, hour, minutes, etc., that you want to extract from the interval.
The extract function returns a value of type double precision.
*/

SELECT
    EXTRACT (
        MINUTE
        FROM
            INTERVAL '5 hours 21 minutes'
    );

-- Adjusting interval values
/*
PostgreSQL provides two functions justifydays and justifyhours that allows you to adjust the interval 
of 30-day as one month and the interval of 24-hour as one day:
*/

SELECT
    justify_days(INTERVAL '30 days'),
    justify_hours(INTERVAL '24 hours');

/*
In addition, the justify_interval function adjusts interval using justifydays and justifyhours 
with additional sign adjustments
*/
SELECT
    justify_interval(interval '1 year -1 hour');
	
/*  Unix timestamp */

SELECT extract(epoch from now());
SELECT extract(epoch from date '2030-08-15');
SELECT extract(epoch from timestamp '2030-08-15 03:30:45');
SELECT extract(
    epoch from timestamp with time zone '2030-08-15 03:30:45.12-08'
    );
SELECT extract(epoch from interval '7 days 2 hours');

-----------------------------------------------------------------------------------------------------

/* PostgreSQL TIME */
/*
PostgreSQL provides the TIME data type that allows you to store the time of day values.

column_name TIME(precision);

A time value may have a precision up to 6 digits.
The precision specifies the number of fractional digits placed in the second field.

The TIME data type requires 8 bytes and its allowed range is from 00:00:00 to 24:00:00. 
The following illustrates the common formats of the TIME values:

HH:MI   
HH:MI:SS
HHMISS

For example:
01:02
01:02:03
010203

If you want to use the precision, you can use the following formats:

MI:SS.pppppp    
HH:MI:SS.pppppp
HHMISS.pppppp

In this form, p is the precision. For example:

04:59.999999
04:05:06.777777
040506.777777

PostgreSQL actually accepts almost any reasonable TIME format including SQL-compatible, ISO 8601, etc.
*/

CREATE TABLE shifts (
    id serial PRIMARY KEY,
    shift_name VARCHAR NOT NULL,
    start_at TIME NOT NULL,
    end_at TIME NOT NULL
);

INSERT INTO shifts(shift_name, start_at, end_at)
VALUES('Morning', '08:00:00', '12:00:00'),
      ('Afternoon', '13:00:00', '17:00:00'),
      ('Night', '18:00:00', '22:00:00');
	  
SELECT * FROM shifts;

-- PostgreSQL TIME with time zone type
/*
Besides the TIME data type, PostgreSQL provides the TIME with time zone data type 
that allows you to store and manipulate the time of day with time zone.

column TIME with time zone

The storage size of the TIME with time zone data type is 12 bytes that allow you store 
a time value with the time zone that ranges from 00:00:00+1459 to 24:00:00-1459.

04:05:06 PST    
04:05:06.789-8 
*/

-- Handling PostgreSQL TIME values
-- Getting the current time

-- To get the current time with time zone, you use the CURRENT_TIME function as follows:
-- Notice that without specifying the precision, the CURRENT_TIME function returns a time value with the full available precision.
SELECT CURRENT_TIME;

-- To get the current time with a specific precision, you use the CURRENT_TIME(precision) function:
 SELECT CURRENT_TIME(5);
 
 -- To get the local time, you use the LOCALTIME function:
 SELECT LOCALTIME;
 SELECT LOCALTIME(0);
 
 -- Converting time to a different time zone
 -- [TIME with time zone] AT TIME ZONE time_zone
 
 SELECT LOCALTIME AT TIME ZONE 'UTC-7';
 
 -- Extracting hours, minutes, seconds from a time value
 -- EXTRACT(field FROM time_value);
 
 SELECT
    LOCALTIME,
    EXTRACT (HOUR FROM LOCALTIME) as hour,
    EXTRACT (MINUTE FROM LOCALTIME) as minute, 
    EXTRACT (SECOND FROM LOCALTIME) as second,
    EXTRACT (milliseconds FROM LOCALTIME) as milliseconds; 

-- Arithmetic operations on time values
/*
PostgreSQL allows you to apply arithmetic operators such as +, -,  and *  on time values and between time and interval values.
*/

SELECT time '10:00' - time '02:00' AS result;

SELECT LOCALTIME + interval '2 hours' AS result;
-----------------------------------------------------------------------------------------------------

/* PostgreSQL UUID */
/*
UUID stands for Universal Unique Identifier defined by RFC 4122 and other related standards.
A UUID value is 128-bit quantity generated by an algorithm that make it unique in the known universe using the same algorithm.

40e6215d-b5c6-4896-987c-f30f3678f608
6ecd8c99-4036-403d-bf84-cf8400f67836
3f333df6-90a4-4fda-8dd3-9485d27cee36

As you can see, a UUID is a sequence of 32 digits of hexadecimal digits represented in groups separated by hyphens.

Because of its uniqueness feature, 
you often found UUID in the distributed systems because it guarantees a better uniqueness than the SERIAL data type 
which generates only unique values within a single database.

To stores UUID values in the PostgreSQL database, you use the UUID data type.
*/

/*
Generating UUID values
PostgreSQL allows you store and compare UUID values 
but it does not include functions for generating the UUID values in its core.

Instead, it relies on the third-party modules that provide specific algorithms to generate UUIDs. 
For example the uuid-ossp module provides some handy functions that implement standard algorithms for generating UUIDs.
*/

-- To install the uuid-ossp module, you use the CREATE EXTENSION statement as follows:
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

/*
The IF NOT EXISTS clause allows you to avoid re-installing the module.

To generate the UUID values based on the combination of computer’s MAC address, current timestamp, 
and a random value, you use the uuid_generate_v1() function:
*/
SELECT uuid_generate_v1();

/*
If you want to generate a UUID value solely based on random numbers,
you can use the uuid_generate_v4() function. For example:
*/
SELECT uuid_generate_v4();

-- Creating a table with UUID column

DROP TABLE IF EXISTS contacts;
CREATE TABLE contacts (
    contact_id uuid DEFAULT uuid_generate_v4 (),
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    phone VARCHAR,
    PRIMARY KEY (contact_id)
);

INSERT INTO contacts (
    first_name,
    last_name,
    email,
    phone
)
VALUES
    (
        'John',
        'Smith',
        'john.smith@example.com',
        '408-237-2345'
    ),
    (
        'Jane',
        'Smith',
        'jane.smith@example.com',
        '408-237-2344'
    ),
    (
        'Alex',
        'Smith',
        'alex.smith@example.com',
        '408-237-2343'
    );

SELECT * FROM contacts;
-----------------------------------------------------------------------------------------------------

/* PostgreSQL JSON */
/*
JSON stands for JavaScript Object Notation.
JSON is an open standard format that consists of key-value pairs.

The main usage of JSON is to transport data between a server and a web application. 
Unlike other formats, JSON is human-readable text.

PostgreSQL supports native JSON data type since version 9.2. 
It provides many functions and operators for manipulating JSON data.
*/

CREATE TABLE orders (
	id serial NOT NULL PRIMARY KEY,
	info json NOT NULL
);
/*
The orders table consists of two columns:
. The id column is the primary key column that identifies the order.
. The info column stores the data in the form of JSON.
*/

-- Insert JSON data
-- To insert data into a JSON column, you have to ensure that data is in a valid JSON format.  

INSERT INTO orders (info)
VALUES('{ "customer": "John Doe", "items": {"product": "Beer","qty": 6}}');

-- insert multiple
INSERT INTO orders (info)
VALUES('{ "customer": "Lily Bush", "items": {"product": "Diaper","qty": 24}}'),
      ('{ "customer": "Josh William", "items": {"product": "Toy Car","qty": 1}}'),
      ('{ "customer": "Mary Clark", "items": {"product": "Toy Train","qty": 2}}');
	  
-- Querying JSON data

SELECT * FROM orders;
SELECT info FROM orders;

/*
PostgreSQL returns a result set in the form of JSON.
PostgreSQL provides two native operators -> and ->> to help you query JSON data.
. The operator -> returns JSON object field by key.
. The operator ->> returns JSON object field by text.
*/

-- The following query uses the operator -> to get all customers in form of JSON:
SELECT info -> 'customer' AS customer
FROM orders;

-- And the following query uses operator ->> to get all customers in form of text:
SELECT info ->> 'customer' AS customer
FROM orders;

-- Because -> operator returns a JSON object, you can chain it with the operator ->> to retrieve a specific node. 
SELECT info -> 'items' ->> 'product' as product
FROM orders
ORDER BY product;

-- Use JSON operator in WHERE clause
SELECT info ->> 'customer' AS customer
FROM orders
WHERE info -> 'items' ->> 'product' = 'Diaper';

SELECT 
info ->> 'customer' AS customer,
info -> 'items' ->> 'product' AS product
FROM orders
WHERE CAST ( info -> 'items' ->> 'qty' AS INTEGER) = 2

-- Apply aggregate functions to JSON data
SELECT 
   MIN (CAST (info -> 'items' ->> 'qty' AS INTEGER)),
   MAX (CAST (info -> 'items' ->> 'qty' AS INTEGER)),
   SUM (CAST (info -> 'items' ->> 'qty' AS INTEGER)),
   AVG (CAST (info -> 'items' ->> 'qty' AS INTEGER))
FROM orders;

/* PostgreSQL JSON functions */

-- json_each function
-- The json_each() function allows us to expand the outermost JSON object into a set of key-value pairs.
-- If you want to get a set of key-value pairs as text, you use the json_each_text() function instead.

SELECT json_each (info)
FROM orders;

SELECT info FROM orders;

-- json_object_keys function
-- To get a set of keys in the outermost JSON object, you use the json_object_keys() function.

SELECT json_object_keys (info->'items')
FROM orders;

SELECT DISTINCT json_object_keys (info->'items')
FROM orders;

SELECT DISTINCT json_object_keys(info) FROM orders;

-- json_typeof function
-- The json_typeof() function returns type of the outermost JSON value as a string.
-- It can be number, boolean, null, object, array, and string.

SELECT json_typeof (info->'items')
FROM orders;

SELECT json_typeof (info->'items'->'qty')
FROM orders;
-----------------------------------------------------------------------------------------------------

/* PostgreSQL hstore */
/*
The hstore module implements the hstore data type for storing key-value pairs in a single value.
The hstore data type is very useful in many cases, such as semi-structured data 
or rows with many attributes that are rarely queried. 
Notice that keys and values are just text strings only.
*/

-- Enable PostgreSQL hstore extension
-- Before working with the hstore data type, 
-- you need to enable the hstore extension which loads the contrib module to your PostgreSQL instance.

CREATE EXTENSION hstore;

-- ...
-----------------------------------------------------------------------------------------------------

/* PostgreSQL Array */
/*
Array plays an important role in PostgreSQL.
Every data type has its own companion array type e.g., integer has an integer[] array type, character has character[] array type, etc.
In case you define your own data type, PostgreSQL creates a corresponding array type in the background for you.

PostgreSQL allows you to define a column to be an array of any valid data type including built-in type, user-defined type 
or enumerated type.
*/

-- array TEXT
DROP TABLE IF EXISTS contacts;
CREATE TABLE contacts (
	id serial PRIMARY KEY,
	name VARCHAR (100),
	phones TEXT []
);

-- Insert PostgreSQL array values
INSERT INTO contacts (name, phones)
VALUES('John Doe',ARRAY [ '(408)-589-5846','(408)-589-5555' ]);

/*
We used the ARRAY constructor to construct an array and insert it into the contacts table. 
You can also use curly braces as follows:
*/
INSERT INTO contacts (name, phones)
VALUES('Lily Bush','{"(408)-589-5841"}'),
      ('William Gate','{"(408)-589-5842","(408)-589-58423"}');
/*
The statement above inserts two rows into the contacts table. 
Notice that when you use curly braces, 
you use single quotes ' to wrap the array 
and double quotes " to wrap text array items.
*/

-- Query array data
SELECT name, phones FROM contacts;

/*
We access array elements using the subscript within square brackets []. 
By default, PostgreSQL uses one-based numbering for array elements. 
It means the first array element starts with number 1. 
Suppose, we want to get the contact’s name and the first phone number, we use the following query:
*/
SELECT
	name,
	phones [ 1 ]
FROM
	contacts;
	
-- in where
SELECT
	name
FROM
	contacts
WHERE
	phones [ 2 ] = '(408)-589-58423';
	
-- Modifying PostgreSQL array
UPDATE contacts
SET phones [2] = '(408)-589-5843'
WHERE ID = 3;

SELECT
	id,
	name,
	phones [ 2 ]
FROM
	contacts
WHERE
	id = 3;
	
-- The following statement updates an array as a whole.
UPDATE contacts
SET phones = '{"(408)-589-5843"}'
WHERE id = 3;

SELECT
	name,
	phones
FROM
	contacts
WHERE
	id = 3;

-- Search in PostgreSQL Array
-- with ANY
SELECT
	name,
	phones
FROM
	contacts
WHERE
	'(408)-589-5555' = ANY (phones);
	
-- Expand Arrays
-- PostgreSQL provides the unnest() function to expand an array to a list of rows.
SELECT
	name,
	unnest(phones)
FROM
	contacts;
-----------------------------------------------------------------------------------------------------

/* PostgreSQL User-defined Data Types */

/*
Besides built-in data types, PostgreSQL allows you to create user-defined data types through the following statements:

. CREATE DOMAIN creates a user-defined data type with constraints such as NOT NULL, CHECK, etc.
. CREATE TYPE creates a composite type used in stored procedures as the data types of returned values.
*/

/* PostgreSQL CREATE DOMAIN statement */
/*
In PostgreSQL, a domain is a data type with optional constraints e.g., NOT NULL and CHECK. 
A domain has a unique name within the schema scope.

Domains are useful for centralizing the management of fields with common constraints. 
For example, some tables may have the same column that do not accept NULL and spaces.
*/

CREATE TABLE mailing_list (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    CHECK (
        first_name !~ '\s'
        AND last_name !~ '\s'
    )
);

/*
In this table, both first_name and last_name columns do not accept null and spaces. 
Instead of defining the CHECK constraint, you can create a contact_name domain and reuse it in multiple columns.

The following statement uses the CREATE DOMAIN to create a new domain called contact_name 
with the VARCHAR datatype and do not accept NULL and spaces:
*/
CREATE DOMAIN contact_name AS 
   VARCHAR NOT NULL CHECK (value !~ '\s');

-- And you use contact_name as the datatype of the first_name and last_name columns as a regular built-in type:
CREATE TABLE mailing_list (
    id serial PRIMARY KEY,
    first_name contact_name,
    last_name contact_name,
    email VARCHAR NOT NULL
);

INSERT INTO mailing_list (first_name, last_name, email)
VALUES('Jame V','Doe','jame.doe@example.com');
-- ERROR:  value for domain contact_name violates check constraint "contact_name_check"

INSERT INTO mailing_list (first_name, last_name, email)
VALUES('Jane','Doe','jane.doe@example.com');

-- \dD

-- Getting domain information
-- To get all domains in a specific schema, you use the following query:
SELECT typname 
FROM pg_catalog.pg_type 
  JOIN pg_catalog.pg_namespace 
  	ON pg_namespace.oid = pg_type.typnamespace 
WHERE 
	typtype = 'd' and nspname = 'public';

/* PostgreSQL CREATE TYPE */
-- The CREATE TYPE statement allows you to create a composite type, which can be used as the return type of a function.

-- The first step is to create a type e.g., film_summary as follows:
CREATE TYPE film_summary AS (
    film_id INT,
    title VARCHAR,
    release_year SMALLINT
); 

-- Second, use the film_summary data type as the return type of a function:
CREATE OR REPLACE FUNCTION get_film_summary (f_id INT) 
    RETURNS film_summary AS 
$$ 
SELECT
    film_id,
    title,
    release_year
FROM
    film
WHERE
    film_id = f_id ; 
$$ 
LANGUAGE SQL;

-- Third, call the get_film_summary() function:
SELECT * FROM get_film_summary (40);

/*
To change a user-defined type, you use the ALTER TYPE statement.
To remove a user-defined type, you use the DROP TYPE statement.

If you use the psql program, you can list all user-defined types in the current database using the \dT or \dT+ command:
*/