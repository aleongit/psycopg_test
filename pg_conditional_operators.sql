SELECT Version();
-- PostgreSQL 15.0, compiled by Visual C++ build 1914, 64-bit

/* PostgreSQL CASE */
/*
The PostgreSQL CASE expression is the same as IF/ELSE statement in other programming languages. 
It allows you to add if-else logic to the query to form a powerful query.
The CASE expression has two forms: general and simple form.
*/

-- 1) General PostgreSQL CASE expression
/*
CASE 
      WHEN condition_1  THEN result_1
      WHEN condition_2  THEN result_2
      [WHEN ...]
      [ELSE else_result]
END
*/

SELECT title,
       length,
       CASE
           WHEN length> 0
                AND length <= 50 THEN 'Short'
           WHEN length > 50
                AND length <= 120 THEN 'Medium'
           WHEN length> 120 THEN 'Long'
       END duration
FROM film
ORDER BY title;

-- B) Using CASE with an aggregate function example

SELECT
	SUM (CASE
               WHEN rental_rate = 0.99 THEN 1
	       ELSE 0
	      END
	) AS "Economy",
	SUM (
		CASE
		WHEN rental_rate = 2.99 THEN 1
		ELSE 0
		END
	) AS "Mass",
	SUM (
		CASE
		WHEN rental_rate = 4.99 THEN 1
		ELSE 0
		END
	) AS "Premium"
FROM
	film;
	
	
-- Simple PostgreSQL CASE expression
/*
CASE expression
   WHEN value_1 THEN result_1
   WHEN value_2 THEN result_2 
   [WHEN ...]
ELSE
   else_result
END
*/

-- A) Simple PostgreSQL CASE expression example

SELECT title,
       rating,
       CASE rating
           WHEN 'G' THEN 'General Audiences'
           WHEN 'PG' THEN 'Parental Guidance Suggested'
           WHEN 'PG-13' THEN 'Parents Strongly Cautioned'
           WHEN 'R' THEN 'Restricted'
           WHEN 'NC-17' THEN 'Adults Only'
       END rating_description
FROM film
ORDER BY title;

-- B) Using simple PostgreSQL CASE expression with aggregate function example

SELECT
       SUM(CASE rating
             WHEN 'G' THEN 1 
		     ELSE 0 
		   END) "General Audiences",
       SUM(CASE rating
             WHEN 'PG' THEN 1 
		     ELSE 0 
		   END) "Parental Guidance Suggested",
       SUM(CASE rating
             WHEN 'PG-13' THEN 1 
		     ELSE 0 
		   END) "Parents Strongly Cautioned",
       SUM(CASE rating
             WHEN 'R' THEN 1 
		     ELSE 0 
		   END) "Restricted",
       SUM(CASE rating
             WHEN 'NC-17' THEN 1 
		     ELSE 0 
		   END) "Adults Only"
FROM film;

/* PostgreSQL COALESCE */
/*
Function that returns the first non-null argument. 
You will learn how to apply this function in SELECT statement to handle null values effectively.

COALESCE (argument_1, argument_2, …);

The COALESCE function accepts an unlimited number of arguments.
It returns the first argument that is not null. If all arguments are null, the COALESCE function will return null.

The COALESCE function evaluates arguments from left to right until it finds the first non-null argument.
All the remaining arguments from the first non-null argument are not evaluated.

The COALESCE function provides the same functionality as NVL or IFNULL function provided by SQL-standard. 
MySQL has IFNULL function, while Oracle provides NVL function.
*/

SELECT
	COALESCE (1, 2);
-- 1

SELECT
	COALESCE (NULL, 2 , 1);
-- 2

/*
SELECT
	COALESCE (excerpt, LEFT(CONTENT, 150))
FROM
	posts;
*/

CREATE TABLE items (
	ID serial PRIMARY KEY,
	product VARCHAR (100) NOT NULL,
	price NUMERIC NOT NULL,
	discount NUMERIC
);

INSERT INTO items (product, price, discount)
VALUES
	('A', 1000 ,10),
	('B', 1500 ,20),
	('C', 800 ,5),
	('D', 500, NULL);
	
SELECT
	product,
	(price - discount) AS net_price
FROM
	items;

-- with coalesce
SELECT
	product,
	(price - COALESCE(discount,0)) AS net_price
FROM
	items;

-- equivalent with CASE
SELECT
	product,
	(
		price - CASE
		WHEN discount IS NULL THEN
			0
		ELSE
			discount
		END
	) AS net_price
FROM
	items;
	
/* PostgreSQL NULLIF */
/*

NULLIF(argument_1,argument_2);

The NULLIF function returns a null value if argument_1 equals to argument_2, 
otherwise it returns argument_1.
*/
SELECT
	NULLIF (1, 1); -- return NULL

SELECT
	NULLIF (1, 0); -- return 1

SELECT
	NULLIF ('A', 'B'); -- return A

CREATE TABLE posts (
  id serial primary key,
	title VARCHAR (255) NOT NULL,
	excerpt VARCHAR (150),
	body TEXT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP
);

INSERT INTO posts (title, excerpt, body)
VALUES
      ('test post 1','test post excerpt 1','test post body 1'),
      ('test post 2','','test post body 2'),
      ('test post 3', null ,'test post body 3');

SELECT ID, title, excerpt FROM posts;

-- with COALESCE
SELECT
	id,
	title,
	COALESCE (excerpt, LEFT(body, 40))
FROM
	posts;

-- with NULLIF
SELECT
	id,
	title,
	COALESCE (
		NULLIF (excerpt, ''),
		LEFT (body, 40)
	)
FROM
	posts;
	
/* Use NULLIF to prevent division-by-zero error */
-- ...

/* PostgreSQL CAST */ 
-- To Convert a Value of One Type to Another

/*
CAST ( expression AS target_type );

. First, specify an expression that can be a constant, a table column, an expression that evaluates to a value.
. Then, specify the target data type to which you want to convert the result of the expression.
*/

-- PostgreSQL type cast :: operator
/* 
Besides the type CAST syntax, 
you can use the following syntax to convert a value of one type into another:
expression::type
*/
SELECT
  '100'::INTEGER,
  '01-OCT-2015'::DATE;
-- Notice that the cast syntax with the cast operator (::) is PostgreSQL-specific and does not conform to the SQL standard

-- 1) Cast a string to an integer example
SELECT
	CAST ('100' AS INTEGER);
	
SELECT
	CAST ('10C' AS INTEGER);
/*
[Err] ERROR:  invalid input syntax for integer: "10C"
LINE 2:  CAST ('10C' AS INTEGER);
*/

-- 2) Cast a string to a date example
SELECT
   CAST ('2015-01-01' AS DATE),
   CAST ('01-OCT-2015' AS DATE);
   
-- 3) Cast a string to a double example
SELECT
	CAST ('10.2' AS DOUBLE);
/*
[Err] ERROR:  type "double" does not exist
LINE 2:  CAST ('10.2' AS DOUBLE)
*/
SELECT
   CAST ('10.2' AS DOUBLE PRECISION);

-- 4) Cast a string to a boolean example
SELECT 
   CAST('true' AS BOOLEAN),
   CAST('false' as BOOLEAN),
   CAST('T' as BOOLEAN),
   CAST('F' as BOOLEAN);
   
-- 5) Convert a string to a timestamp example
SELECT '2019-06-15 14:30:20'::timestamp;

-- 6) Convert a string to an interval example
SELECT '15 minute'::interval,
 '2 hour'::interval,
 '1 day'::interval,
 '2 week'::interval,
 '3 month'::interval;
 
-- 7) Using CAST with table data example

CREATE TABLE ratings (
	ID serial PRIMARY KEY,
	rating VARCHAR (1) NOT NULL
);

INSERT INTO ratings (rating)
VALUES
	('A'),
	('B'),
	('C');
	
INSERT INTO ratings (rating)
VALUES
	(1),
	(2),
	(3);


SELECT * FROM ratings;

-- fix
SELECT
	id,
	CASE
		WHEN rating~E'^\\d+$' THEN
			CAST (rating AS INTEGER)
		ELSE
			0
		END as rating
FROM
	ratings;