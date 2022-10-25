SELECT Version();

/*
The SELECT statement has the following clauses:

. Select distinct rows using DISTINCT operator.
. Sort rows using ORDER BY clause.
. Filter rows using WHERE clause.
. Select a subset of rows from a table using LIMIT or FETCH clause.
. Group rows into groups using GROUP BY clause.
. Filter groups using HAVING clause.
. Join with other tables using joins such as INNER JOIN, LEFT JOIN, FULL OUTER JOIN, CROSS JOIN clauses.
. Perform set operations using UNION, INTERSECT, and EXCEPT.
*/

SELECT * from customer;

SELECT first_name FROM customer;

SELECT
   first_name,
   last_name,
   email
FROM
   customer;

/* concatenation operator || */

SELECT 
   first_name || ' ' || last_name,
   email
FROM 
   customer;

-- càlculs
SELECT 5 * 3;

/* Column Aliases */
/*
. Assign a column or an expression a column alias using the syntax column_name AS alias_name or expression AS alias_name.
. The AS keyword is optional.
. Use double quotes (“) to surround a column alias that contains spaces.
*/

SELECT 
   first_name, 
   last_name AS surname
FROM customer;

-- equivalent, no cal AS
SELECT 
   first_name, 
   last_name surname
FROM customer;


SELECT
    first_name || ' ' || last_name AS full_name
FROM
    customer;

-- per alias amb espais cal ""
SELECT
    first_name || ' ' || last_name "full name"
FROM
    customer;
	
/* order by */

/*
. Use the ORDER BY clause in the SELECT statement to sort rows.
. Use the ASC option to sort rows in ascending order and DESC option to sort rows in descending order.
. The ORDER BY clause uses the ASC option by default.
. Use NULLS FIRST and NULLS LAST options to explicitly specify the order of NULL with other non-null values.
*/

SELECT
	first_name,
	last_name
FROM
	customer
ORDER BY
	first_name ASC;
	

SELECT
	first_name,
	last_name
FROM
	customer
ORDER BY
	last_name DESC;
	   
	   
SELECT
	first_name,
	last_name
FROM
	customer
ORDER BY
	first_name ASC,
	last_name DESC;
	
/*
The LENGTH() function accepts a string and returns the length of that string.
*/

SELECT 
	first_name,
	LENGTH(first_name) len
FROM
	customer
ORDER BY 
	len DESC;
	
/* PostgreSQL ORDER BY clause and NULL */

-- create a new table
CREATE TABLE sort_demo(
	num INT
);

-- insert some data
INSERT INTO sort_demo(num)
VALUES(1),(2),(3),(null);

SELECT num
FROM sort_demo
ORDER BY num;

SELECT num
FROM sort_demo
ORDER BY num NULLS LAST;

SELECT num
FROM sort_demo
ORDER BY num NULLS FIRST;

SELECT num
FROM sort_demo
ORDER BY num DESC;

SELECT num
FROM sort_demo
ORDER BY num DESC NULLS LAST;

/* PostgreSQL SELECT DISTINCT */

CREATE TABLE distinct_demo (
	id serial NOT NULL PRIMARY KEY,
	bcolor VARCHAR,
	fcolor VARCHAR
);

INSERT INTO distinct_demo (bcolor, fcolor)
VALUES
	('red', 'red'),
	('red', 'red'),
	('red', NULL),
	(NULL, 'red'),
	('red', 'green'),
	('red', 'blue'),
	('green', 'red'),
	('green', 'blue'),
	('green', 'green'),
	('blue', 'red'),
	('blue', 'green'),
	('blue', 'blue');
	
SELECT
	id,
	bcolor,
	fcolor
FROM
	distinct_demo ;
	

SELECT
	DISTINCT bcolor
FROM
	distinct_demo
ORDER BY
	bcolor;
	
	
SELECT
	DISTINCT bcolor,
	fcolor
FROM
	distinct_demo
ORDER BY
	bcolor,
	fcolor;
	
/* distinct on */
/* respecte l'anterior exemple, amb DISTINCT ON, retorna la 1a fila de cada grup de duplicats */

SELECT
	DISTINCT ON (bcolor) bcolor,
	fcolor
FROM
	distinct_demo 
ORDER BY
	bcolor,
	fcolor;

/* where */
/*
SELECT select_list
FROM table_name
WHERE condition
ORDER BY sort_expression
*/
/*
Operator	Description
=			Equal
>			Greater than
<			Less than
>=			Greater than or equal
<=			Less than or equal
<> or !=	Not equal
AND			Logical operator AND
OR			Logical operator OR
IN			Return true if a value matches any value in a list
BETWEEN		Return true if a value is between a range of values
LIKE		Return true if a value matches a pattern
IS NULL		Return true if a value is NULL
NOT			Negate the result of other operators
*/

SELECT
	last_name,
	first_name
FROM
	customer
WHERE
	first_name = 'Jamie';
	

SELECT
	last_name,
	first_name
FROM
	customer
WHERE
	first_name = 'Jamie' AND 
    last_name = 'Rice';
	
	
SELECT
	first_name,
	last_name
FROM
	customer
WHERE
	last_name = 'Rodriguez' OR 
	first_name = 'Adam';
	
	
SELECT
	first_name,
	last_name
FROM
	customer
WHERE 
	first_name IN ('Ann','Anne','Annie');
	
-- pattern amb LIKE
-- % comodí
SELECT
	first_name,
	last_name
FROM
	customer
WHERE 
	first_name LIKE 'Ann%'
	
	
SELECT
	first_name,
	LENGTH(first_name) name_length
FROM
	customer
WHERE 
	first_name LIKE 'A%' AND
	LENGTH(first_name) BETWEEN 3 AND 5
ORDER BY
	name_length;
	

SELECT 
	first_name, 
	last_name
FROM 
	customer 
WHERE 
	first_name LIKE 'Bra%' AND 
	last_name <> 'Motley';
	
/* PostgreSQL LIMIT */
/*
SELECT select_list 
FROM table_name
ORDER BY sort_expression
LIMIT row_count
*/
/*
SELECT select_list
FROM table_name
LIMIT row_count OFFSET row_to_skip;
*/

SELECT
	film_id,
	title,
	release_year
FROM
	film
ORDER BY
	film_id
LIMIT 5;


SELECT
	film_id,
	title,
	release_year
FROM
	film
ORDER BY
	film_id
LIMIT 4 OFFSET 3;


SELECT
	film_id,
	title,
	rental_rate
FROM
	film
ORDER BY
	rental_rate DESC
LIMIT 10;

/* PostgreSQL FETCH */
/*
OFFSET start { ROW | ROWS }
FETCH { FIRST | NEXT } [ row_count ] { ROW | ROWS } ONLY
*/
/*
. ROW is the synonym for ROWS, FIRST is the synonym for NEXT . SO you can use them interchangeably
. The start is an integer that must be zero or positive. 
	By default, it is zero if the OFFSET clause is not specified. 
	In case the start is greater than the number of rows in the result set, no rows are returned;
. The row_count is 1 or greater. By default, the default value of row_count is 1 if you do not specify it explicitly.
*/
/*
FETCH vs. LIMIT
The FETCH clause is functionally equivalent to the LIMIT clause.
If you plan to make your application compatible with other database systems, you should use the FETCH clause 
because it follows the standard SQL.
*/

SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title 
FETCH FIRST ROW ONLY;

-- equivalent
SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title 
FETCH FIRST 1 ROW ONLY;


SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title 
FETCH FIRST 5 ROW ONLY;


SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title 
OFFSET 5 ROWS 
FETCH FIRST 5 ROW ONLY;


/* PostgreSQL IN */
/*
value IN (value1,value2,...)
value IN (SELECT column_name FROM table_name);
*/

SELECT customer_id,
	rental_id,
	return_date
FROM
	rental
WHERE
	customer_id IN (1, 2)
ORDER BY
	return_date DESC;
	
-- equivalent
SELECT
	rental_id,
	customer_id,
	return_date
FROM
	rental
WHERE
	customer_id = 1 OR customer_id = 2
ORDER BY
	return_date DESC;
	
/* PostgreSQL NOT IN operator */

SELECT
	customer_id,
	rental_id,
	return_date
FROM
	rental
WHERE
	customer_id NOT IN (1, 2)
ORDER BY
	customer_id;

-- equivalent
SELECT
	customer_id,
	rental_id,
	return_date
FROM
	rental
WHERE
	customer_id <> 1
AND customer_id <> 2;


-- PostgreSQL IN with a subquery
-- CAST és per conversió

--llista = subquery
SELECT customer_id
FROM rental
WHERE CAST (return_date AS DATE) = '2005-05-27'
ORDER BY customer_id;

--
SELECT
	customer_id,
	first_name,
	last_name
FROM
	customer
WHERE
	customer_id IN (
		SELECT customer_id
		FROM rental
		WHERE CAST (return_date AS DATE) = '2005-05-27'
	)
ORDER BY customer_id;

/* PostgreSQL BETWEEN */
/*
value BETWEEN low AND high;
value >= low and value <= high
value NOT BETWEEN low AND high;
value < low OR value > high
*/

SELECT
	customer_id,
	payment_id,
	amount
FROM
	payment
WHERE
	amount BETWEEN 8 AND 9;
	

SELECT
	customer_id,
	payment_id,
	amount
FROM
	payment
WHERE
	amount NOT BETWEEN 8 AND 9;
	
-- date in ISO 8601 format i.e., YYYY-MM-DD.
SELECT
	customer_id,
	payment_id,
	amount,
 payment_date
FROM
	payment
WHERE
	payment_date BETWEEN '2007-02-07' AND '2007-02-15';

/* PostgreSQL LIKE */
/*
You construct a pattern by combining literal values with wildcard characters and use the LIKE or NOT LIKE operator 
to find the matches. PostgreSQL provides you with two wildcards:

. Percent sign ( %) matches any sequence of zero or more characters.
. Underscore sign ( _)  matches any single character.
*/
/*
SELECT
	'foo' LIKE 'foo', -- true
	'foo' LIKE 'f%', -- true
	'foo' LIKE '_o_', -- true
	'bar' LIKE 'b_'; -- false
*/
/*
. The first expression returns true because the foo pattern does not contain any wildcard character
so the LIKE operator acts like the equal (=) operator.
. The second expression returns true because it matches any string that begins with the letter f 
and followed by any number of characters.
. The third expression returns true because the pattern ( _o_) matches any string that begins with any single character, 
followed by the letter o and ended with any single character.
. The fourth expression returns false because the pattern  b_ matches any string that begins with the letter  b 
and followed by any single character.
*/

SELECT
	first_name,
    last_name
FROM
	customer
WHERE
	first_name LIKE '%er%'
ORDER BY 
    first_name;
	
	
SELECT
	first_name,
	last_name
FROM
	customer
WHERE
	first_name LIKE '_her%'
ORDER BY 
        first_name;
		
-- not like
SELECT
	first_name,
	last_name
FROM
	customer
WHERE
	first_name NOT LIKE 'Jen%'
ORDER BY 
    first_name
	
	
-- ilike (case-insensitively)

SELECT
	first_name,
	last_name
FROM
	customer
WHERE
	first_name ILIKE 'BAR%';
	
/*
Operator	Equivalent
~~			LIKE
~~*			ILIKE
!~~			NOT LIKE
!~~*		NOT ILIKE
*/

/* PostgreSQL IS NULL */

CREATE TABLE contacts(
    id SERIAL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    PRIMARY KEY (id)
);

INSERT INTO contacts(first_name, last_name, email, phone)
VALUES ('John','Doe','john.doe@example.com',NULL),
    ('Lily','Bush','lily.bush@example.com','(408-234-2764)');

-- incorrecte = NULL
SELECT
    id,
    first_name,
    last_name,
    email,
    phone
FROM
    contacts
WHERE
    phone = NULL;

-- correcte IS NULL
SELECT
    id,
    first_name,
    last_name,
    email,
    phone
FROM
    contacts
WHERE
    phone IS NULL;
	
-- PostgreSQL IS NOT NULL operator

SELECT
    id,
    first_name,
    last_name,
    email,
    phone
FROM
    contacts
WHERE
    phone IS NOT NULL;
	
/* PostgreSQL Table Aliases */
/*
table_name AS alias_name;
table_name alias_name;
*/

/*
Practical applications of table aliases

1. Using table aliases for the long table name to make queries more readable

a_very_long_table_name.column_name
a_very_long_table_name AS alias
alias.column_name
*/

-- 2. Using table aliases in join clauses

SELECT
	c.customer_id,
	first_name,
	amount,
	payment_date
FROM
	customer c
INNER JOIN payment p 
    ON p.customer_id = c.customer_id
ORDER BY 
   payment_date DESC;

-- 3. Using table aliases in self-join

SELECT
    e.first_name employee,
    m .first_name manager
FROM
    employee e
INNER JOIN employee m 
    ON m.employee_id = e.manager_id
ORDER BY manager;

/* PostgreSQL Joins */

CREATE TABLE basket_a (
    a INT PRIMARY KEY,
    fruit_a VARCHAR (100) NOT NULL
);

CREATE TABLE basket_b (
    b INT PRIMARY KEY,
    fruit_b VARCHAR (100) NOT NULL
);

INSERT INTO basket_a (a, fruit_a)
VALUES
    (1, 'Apple'),
    (2, 'Orange'),
    (3, 'Banana'),
    (4, 'Cucumber');

INSERT INTO basket_b (b, fruit_b)
VALUES
    (1, 'Orange'),
    (2, 'Apple'),
    (3, 'Watermelon'),
    (4, 'Pear');
	
-- inner join
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
INNER JOIN basket_b
    ON fruit_a = fruit_b;

-- left (outer) join
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
LEFT JOIN basket_b 
   ON fruit_a = fruit_b;

-- left (outer) join, only rows from the left table
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
LEFT JOIN basket_b 
    ON fruit_a = fruit_b
WHERE b IS NULL;

-- right (outer) join
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
RIGHT JOIN basket_b ON fruit_a = fruit_b;

-- right (outer) join, only rows from right table
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
RIGHT JOIN basket_b 
   ON fruit_a = fruit_b
WHERE a IS NULL;


-- full outer join
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
FULL OUTER JOIN basket_b 
    ON fruit_a = fruit_b;

-- full outer join, only rows unique to both tables
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
FULL JOIN basket_b 
   ON fruit_a = fruit_b
WHERE a IS NULL OR b IS NULL;

/* PostgreSQL INNER JOIN */

-- 1) Using PostgreSQL INNER JOIN to join two tables
SELECT
	customer.customer_id,
	first_name,
	last_name,
	amount,
	payment_date
FROM
	customer
INNER JOIN payment 
    ON payment.customer_id = customer.customer_id
ORDER BY payment_date;

-- with alias
SELECT
	c.customer_id,
	first_name,
	last_name,
	email,
	amount,
	payment_date
FROM
	customer c
INNER JOIN payment p 
    ON p.customer_id = c.customer_id
WHERE
    c.customer_id = 2;

-- Since both tables have the same customer_id column, you can use the USING syntax
SELECT
	customer_id,
	first_name,
	last_name,
	amount,
	payment_date
FROM
	customer
INNER JOIN payment USING(customer_id)
ORDER BY payment_date;

-- 2) Using PostgreSQL INNER JOIN to join three tables
SELECT
	c.customer_id,
	c.first_name customer_first_name,
	c.last_name customer_last_name,
	s.first_name staff_first_name,
	s.last_name staff_last_name,
	amount,
	payment_date
FROM
	customer c
INNER JOIN payment p 
    ON p.customer_id = c.customer_id
INNER JOIN staff s 
    ON p.staff_id = s.staff_id
ORDER BY payment_date;

/* PostgreSQL LEFT JOIN */

SELECT
	film.film_id,
	title,
	inventory_id
FROM
	film
LEFT JOIN inventory 
    ON inventory.film_id = film.film_id
ORDER BY title;


SELECT
	film.film_id,
	film.title,
	inventory_id
FROM
	film
LEFT JOIN inventory 
   ON inventory.film_id = film.film_id
WHERE inventory.film_id IS NULL
ORDER BY title;

-- with alias
SELECT
	f.film_id,
	title,
	inventory_id
FROM
	film f
LEFT JOIN inventory i
   ON i.film_id = f.film_id
WHERE i.film_id IS NULL
ORDER BY title;

-- with USING
SELECT
	f.film_id,
	title,
	inventory_id
FROM
	film f
LEFT JOIN inventory i USING (film_id)
WHERE i.film_id IS NULL
ORDER BY title;

/* PostgreSQL Self-Join */
/*
A self-join is a regular join that joins a table to itself.
In practice, you typically use a self-join to query hierarchical data or to compare rows within the same table.
To form a self-join, you specify the same table twice with different table aliases 
and provide the join predicate after the ON keyword.
*/

/*
SELECT select_list
FROM table_name t1
INNER JOIN table_name t2 ON join_predicate;

SELECT select_list
FROM table_name t1
LEFT JOIN table_name t2 ON join_predicate;
*/

-- 1) Querying hierarchical data example
CREATE TABLE employee (
	employee_id INT PRIMARY KEY,
	first_name VARCHAR (255) NOT NULL,
	last_name VARCHAR (255) NOT NULL,
	manager_id INT,
	FOREIGN KEY (manager_id) 
	REFERENCES employee (employee_id) 
	ON DELETE CASCADE
);
INSERT INTO employee (
	employee_id,
	first_name,
	last_name,
	manager_id
)
VALUES
	(1, 'Windy', 'Hays', NULL),
	(2, 'Ava', 'Christensen', 1),
	(3, 'Hassan', 'Conner', 1),
	(4, 'Anna', 'Reeves', 2),
	(5, 'Sau', 'Norman', 2),
	(6, 'Kelsie', 'Hays', 3),
	(7, 'Tory', 'Goff', 3),
	(8, 'Salley', 'Lester', 3);

-- with inner join
SELECT
    e.first_name || ' ' || e.last_name employee,
    m .first_name || ' ' || m .last_name manager
FROM
    employee e
INNER JOIN employee m ON m .employee_id = e.manager_id
ORDER BY manager;

-- with left join
SELECT
    e.first_name || ' ' || e.last_name employee,
    m .first_name || ' ' || m .last_name manager
FROM
    employee e
LEFT JOIN employee m ON m .employee_id = e.manager_id
ORDER BY manager;

-- 2) Comparing the rows with the same table
SELECT
    f1.title,
    f2.title,
    f1.length
FROM
    film f1
INNER JOIN film f2 
    ON f1.film_id <> f2.film_id AND 
       f1.length = f2.length;

/* PostgreSQL Cross Join */
/*
A CROSS JOIN clause allows you to produce a Cartesian Product of rows in two or more tables.
Different from other join clauses such as LEFT JOIN  or INNER JOIN, the CROSS JOIN clause does not have a join predicate.

SELECT select_list
FROM T1
CROSS JOIN T2;

-- equivalent
SELECT select_list
FROM T1, T2;

-- equivalent
SELECT *
FROM T1
INNER JOIN T2 ON true;
*/

DROP TABLE IF EXISTS T1;
CREATE TABLE T1 (label CHAR(1) PRIMARY KEY);

DROP TABLE IF EXISTS T2;
CREATE TABLE T2 (score INT PRIMARY KEY);

INSERT INTO T1 (label)
VALUES
	('A'),
	('B');

INSERT INTO T2 (score)
VALUES
	(1),
	(2),
	(3);
	
SELECT *
FROM T1
CROSS JOIN T2;

/* PostgreSQL NATURAL JOIN*/
/*
A natural join is a join that creates an implicit join based on the same column names in the joined tables.

SELECT select_list
FROM T1
NATURAL [INNER, LEFT, RIGHT] JOIN T2;

. PostgreSQL will use the INNER JOIN by default.
. If you use the asterisk (*) in the select list, the result will contain the following columns:
	. All the common columns, which are the columns from both tables that have the same name.
	. Every column from both tables, which is not a common column.
*/

DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
	category_id serial PRIMARY KEY,
	category_name VARCHAR (255) NOT NULL
);

DROP TABLE IF EXISTS products;
CREATE TABLE products (
	product_id serial PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	category_id INT NOT NULL,
	FOREIGN KEY (category_id) REFERENCES categories (category_id)
);

INSERT INTO categories (category_name)
VALUES
	('Smart Phone'),
	('Laptop'),
	('Tablet');

INSERT INTO products (product_name, category_id)
VALUES
	('iPhone', 1),
	('Samsung Galaxy', 1),
	('HP Elite', 2),
	('Lenovo Thinkpad', 2),
	('iPad', 3),
	('Kindle Fire', 3);
	

-- natural join
SELECT * FROM products NATURAL JOIN categories;

-- equivalent
SELECT	* FROM products
INNER JOIN categories USING (category_id);

/* PostgreSQL GROUP BY */
/*
SELECT 
   column_1, 
   column_2,
   ...,
   aggregate_function(column_3)
FROM 
   table_name
GROUP BY 
   column_1,
   column_2,
   ...;
*/

-- 1) Using PostgreSQL GROUP BY without an aggregate function example
/*
In this case, the GROUP BY works like the DISTINCT clause that removes duplicate rows from the result set.
*/
SELECT
   customer_id
FROM
   payment
GROUP BY
   customer_id;
   
-- 2) Using PostgreSQL GROUP BY with SUM() function example
SELECT
	customer_id,
	SUM (amount)
FROM
	payment
GROUP BY
	customer_id;


SELECT
	customer_id,
	SUM (amount)
FROM
	payment
GROUP BY
	customer_id
ORDER BY
	SUM (amount) DESC;

-- 3) Using PostgreSQL GROUP BY clause with the JOIN clause
SELECT
	first_name || ' ' || last_name full_name,
	SUM (amount) amount
FROM
	payment
INNER JOIN customer USING (customer_id)    	
GROUP BY
	full_name
ORDER BY amount DESC;

-- 4) Using PostgreSQL GROUP BY with COUNT() function example
SELECT
	staff_id,
	COUNT (payment_id)
FROM
	payment
GROUP BY
	staff_id;

-- 5) Using PostgreSQL GROUP BY with multiple columns
SELECT 
	customer_id, 
	staff_id, 
	SUM(amount) 
FROM 
	payment
GROUP BY 
	staff_id, 
	customer_id
ORDER BY 
    customer_id;

-- 6) Using PostgreSQL GROUP BY clause with date column
/*
The payment_date is a timestamp column.
To group payments by dates, you use the DATE() function to convert timestamps to dates first 
and then group payments by the result date:
*/
SELECT 
	DATE(payment_date) paid_date, 
	SUM(amount) sum
FROM 
	payment
GROUP BY
	DATE(payment_date);
	
/* PostgreSQL UNION */
/*
The UNION operator combines result sets of two or more SELECT statements into a single result set.

SELECT select_list_1
FROM table_expresssion_1
UNION
SELECT select_list_2
FROM table_expression_2

To combine the result sets of two queries using the UNION operator, the queries must conform to the following rules:
. The number and the order of the columns in the select list of both queries must be the same.
. The data types must be compatible.

The UNION operator removes all duplicate rows from the combined data set. 
To retain the duplicate rows, you use the the UNION ALL instead.
*/

DROP TABLE IF EXISTS top_rated_films;
CREATE TABLE top_rated_films(
	title VARCHAR NOT NULL,
	release_year SMALLINT
);

DROP TABLE IF EXISTS most_popular_films;
CREATE TABLE most_popular_films(
	title VARCHAR NOT NULL,
	release_year SMALLINT
);

INSERT INTO 
   top_rated_films(title,release_year)
VALUES
   ('The Shawshank Redemption',1994),
   ('The Godfather',1972),
   ('12 Angry Men',1957);

INSERT INTO 
   most_popular_films(title,release_year)
VALUES
   ('An American Pickle',2020),
   ('The Godfather',1972),
   ('Greyhound',2020);
   
SELECT * FROM top_rated_films;
SELECT * FROM most_popular_films;
 
-- 1) Simple PostgreSQL UNION example
SELECT * FROM top_rated_films
UNION
SELECT * FROM most_popular_films;

-- 2) PostgreSQL UNION ALL example (with duplicate rows)
SELECT * FROM top_rated_films
UNION ALL
SELECT * FROM most_popular_films;

-- 3) PostgreSQL UNION ALL with ORDER BY clause example
SELECT * FROM top_rated_films
UNION ALL
SELECT * FROM most_popular_films
ORDER BY title;

/* PostgreSQL INTERSECT Operator */
/*
Like the UNION and EXCEPT operators, 
the PostgreSQL INTERSECT operator combines result sets of two or more SELECT statements into a single result set.
The INTERSECT operator returns any rows that are available in both result sets.

SELECT select_list
FROM A
INTERSECT
SELECT select_list
FROM B;

To use the INTERSECT operator, the columns that appear in the SELECT statements must follow the folowing rules:
. The number of columns and their order in the SELECT clauses must be the same.
. The data types of the columns must be compatible.
*/

SELECT *
FROM most_popular_films 
INTERSECT
SELECT *
FROM top_rated_films;

/* PostgreSQL HAVING */
/*
The HAVING clause specifies a search condition for a group or an aggregate.
The HAVING clause is often used with the GROUP BY clause to filter groups or aggregates based on a specified condition.

SELECT
	column1,
	aggregate_function (column2)
FROM
	table_name
GROUP BY
	column1
HAVING
	condition;
	
HAVING vs. WHERE
The WHERE clause allows you to filter rows based on a specified condition.
However, the HAVING clause allows you to filter groups of rows according to a specified condition.
In other words, the WHERE clause is applied to rows while the HAVING clause is applied to groups of rows.
*/

-- 1) Using PostgreSQL HAVING clause with SUM function example
SELECT
	customer_id,
	SUM (amount)
FROM
	payment
GROUP BY
	customer_id;

-- having
SELECT
	customer_id,
	SUM (amount)
FROM
	payment
GROUP BY
	customer_id
HAVING
	SUM (amount) > 200;
	
-- 2) PostgreSQL HAVING clause with COUNT example
SELECT
	store_id,
	COUNT (customer_id)
FROM
	customer
GROUP BY
	store_id
	
-- having
SELECT
	store_id,
	COUNT (customer_id)
FROM
	customer
GROUP BY
	store_id
HAVING
	COUNT (customer_id) > 300;

/* PostgreSQL GROUPING SETS */
/*
*/

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    brand VARCHAR NOT NULL,
    segment VARCHAR NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (brand, segment)
);

INSERT INTO sales (brand, segment, quantity)
VALUES
    ('ABC', 'Premium', 100),
    ('ABC', 'Basic', 200),
    ('XYZ', 'Premium', 100),
    ('XYZ', 'Basic', 300);

-- without grouping sets
SELECT
    brand,
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    brand,
    segment

UNION ALL

SELECT
    brand,
    NULL,
    SUM (quantity)
FROM
    sales
GROUP BY
    brand

UNION ALL

SELECT
    NULL,
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    segment

UNION ALL

SELECT
    NULL,
    NULL,
    SUM (quantity)
FROM
    sales;

/*
This query generated a single result set with the aggregates for all grouping sets.

Even though the above query works as you expected, it has two main problems.

. First, it is quite lengthy.
. Second, it has a performance issue because PostgreSQL has to scan the sales table separately for each query.

To make it more efficient, PostgreSQL provides the GROUPING SETS clause which is the subclause of the GROUP BY clause.
The GROUPING SETS allows you to define multiple grouping sets in the same query.

SELECT
    c1,
    c2,
    aggregate_function(c3)
FROM
    table_name
GROUP BY
    GROUPING SETS (
        (c1, c2),
        (c1),
        (c2),
        ()
);
*/

SELECT
    brand,
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    GROUPING SETS (
        (brand, segment),
        (brand),
        (segment),
        ()
    );

/* Grouping function */
/*
The GROUPING() function accepts an argument which can be a column name or an expression:

GROUPING( column_name | expression)

The column_name or expression must match with the one specified in the GROUP BY clause.
The GROUPING() function returns bit 0 if the argument is a member of the current grouping set and 1 otherwise.
*/

SELECT
	GROUPING(brand) grouping_brand,
	GROUPING(segment) grouping_segment,
	brand,
	segment,
	SUM (quantity)
FROM
	sales
GROUP BY
	GROUPING SETS (
		(brand),
		(segment),
		()
	)
ORDER BY
	brand,
	segment;
	
-- with having
SELECT
	GROUPING(brand) grouping_brand,
	GROUPING(segment) grouping_segment,
	brand,
	segment,
	SUM (quantity)
FROM
	sales
GROUP BY
	GROUPING SETS (
		(brand),
		(segment),
		()
	)
HAVING GROUPING(brand) = 0	
ORDER BY
	brand,
	segment;
	
/* PostgreSQL CUBE */
/*
PostgreSQL CUBE is a subclause of the GROUP BY clause.
The CUBE allows you to generate multiple grouping sets.

A grouping set is a set of columns to which you want to group. 

SELECT
    c1,
    c2,
    c3,
    aggregate (c4)
FROM
    table_name
GROUP BY
    CUBE (c1, c2, c3);

. First, specify the CUBE subclause in the the GROUP BY clause of the SELECT statement.
. Second, in the select list, specify the columns (dimensions or dimension columns) 
which you want to analyze and aggregation function expressions.
. Third, in the GROUP BY clause, specify the dimension columns within the parentheses of the CUBE subclause.

The query generates all possible grouping sets based on the dimension columns specified in CUBE. 
The CUBE subclause is a short way to define multiple grouping sets so the following are equivalent:

CUBE(c1,c2,c3) 

GROUPING SETS (
    (c1,c2,c3), 
    (c1,c2),
    (c1,c3),
    (c2,c3),
    (c1),
    (c2),
    (c3), 
    ()
 ) 

In general, if the number of columns specified in the CUBE is n, then you will have 2n combinations.

PostgreSQL allows you to perform a partial cube to reduce the number of aggregates calculated. 

SELECT
    c1,
    c2,
    c3,
    aggregate (c4)
FROM
    table_name
GROUP BY
    c1,
    CUBE (c1, c2);
*/

-- cube
SELECT
    brand,
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    CUBE (brand, segment)
ORDER BY
    brand,
    segment;

-- partial cube
SELECT
    brand,
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    brand,
    CUBE (segment)
ORDER BY
    brand,
    segment;
	
/* PostgreSQL ROLLUP */
/*
The PostgreSQL ROLLUP is a subclause of the GROUP BY clause that offers a shorthand for defining multiple grouping sets. 
A grouping set is a set of columns by which you group.

Different from the CUBE subclause, ROLLUP does not generate all possible grouping sets based on the specified columns. 
It just makes a subset of those.

The ROLLUP assumes a hierarchy among the input columns and generates all grouping sets that make sense considering the hierarchy.
This is the reason why ROLLUP is often used to generate the subtotals and the grand total for reports.

For example, the CUBE (c1,c2,c3) makes all eight possible grouping sets:

(c1, c2, c3)
(c1, c2)
(c2, c3)
(c1,c3)
(c1)
(c2)
(c3)
()

However, the ROLLUP(c1,c2,c3) generates only four grouping sets, assuming the hierarchy c1 > c2 > c3 as follows:

(c1, c2, c3)
(c1, c2)
(c1)
()

A common use of  ROLLUP is to calculate the aggregations of data by year, month, and date, 
considering the hierarchy year > month > date

SELECT
    c1,
    c2,
    c3,
    aggregate(c4)
FROM
    table_name
GROUP BY
    ROLLUP (c1, c2, c3);


It is also possible to do a partial roll up to reduce the number of subtotals generated.

SELECT
    c1,
    c2,
    c3,
    aggregate(c4)
FROM
    table_name
GROUP BY
    c1, 
    ROLLUP (c2, c3);
*/

SELECT
    brand,
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    ROLLUP (brand, segment)
ORDER BY
    brand,
    segment;
	
-- In this example, the hierarchy is brand > segment.
SELECT
    segment,
    brand,
    SUM (quantity)
FROM
    sales
GROUP BY
    ROLLUP (segment, brand)
ORDER BY
    segment,
    brand;

-- In this case, the hierarchy is the segment > brand
SELECT
    segment,
    brand,
    SUM (quantity)
FROM
    sales
GROUP BY
    ROLLUP (segment, brand)
ORDER BY
    segment,
    brand;

-- partial roll-up
SELECT
    segment,
    brand,
    SUM (quantity)
FROM
    sales
GROUP BY
    segment,
    ROLLUP (brand)
ORDER BY
    segment,
    brand;
	
-- with dates
SELECT
    EXTRACT (YEAR FROM rental_date) y,
    EXTRACT (MONTH FROM rental_date) M,
    EXTRACT (DAY FROM rental_date) d,
    COUNT (rental_id)
FROM
    rental
GROUP BY
    ROLLUP (
        EXTRACT (YEAR FROM rental_date),
        EXTRACT (MONTH FROM rental_date),
        EXTRACT (DAY FROM rental_date)
    );

/* PostgreSQL Subquery */
/* the PostgreSQL subquery that allows you to construct complex queries */

-- 1
SELECT
	AVG (rental_rate)
FROM
	film;

-- 2
SELECT
	film_id,
	title,
	rental_rate
FROM
	film
WHERE
	rental_rate > 2.98;

/*
The code is not so elegant, which requires two steps. 
We want a way to pass the result of the first query to the second query in one query. 
The solution is to use a subquery.

A subquery is a query nested inside another query such as SELECT, INSERT, DELETE and UPDATE. 

To construct a subquery, we put the second query in brackets and use it in the WHERE clause as an expression
*/

SELECT
	film_id,
	title,
	rental_rate
FROM
	film
WHERE
	rental_rate > (
		SELECT
			AVG (rental_rate)
		FROM
			film
	);

/*
The query inside the brackets is called a subquery or an inner query.
The query that contains the subquery is known as an outer query.

PostgreSQL executes the query that contains a subquery in the following sequence:
. First, executes the subquery.
. Second, gets the result and passes it to the outer query.
. Third, executes the outer query.
*/

-- PostgreSQL subquery with IN operator
/*
A subquery can return zero or more rows.
To use this subquery, you use the IN operator in the WHERE clause.
*/

-- subquery
SELECT
	inventory.film_id
FROM
	rental
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
WHERE
	return_date BETWEEN '2005-05-29'
AND '2005-05-30';

-- in
SELECT
	film_id,
	title
FROM
	film
WHERE
	film_id IN (
		SELECT
			inventory.film_id
		FROM
			rental
		INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
		WHERE
			return_date BETWEEN '2005-05-29'
		AND '2005-05-30'
	)
ORDER BY film_id;

-- PostgreSQL subquery with EXISTS operator
/*
EXISTS subquery

A subquery can be an input of the EXISTS operator. 
If the subquery returns any row, the EXISTS operator returns true. 
If the subquery returns no row, the result of EXISTS operator is false.

The EXISTS operator only cares about the number of rows returned from the subquery, 
not the content of the rows, therefore, the common coding convention of EXISTS operator is as follows:

EXISTS (SELECT 1 FROM tbl WHERE condition);
*/

SELECT
	first_name,
	last_name
FROM
	customer
WHERE
	EXISTS (
		SELECT
			1
		FROM
			payment
		WHERE
			payment.customer_id = customer.customer_id
	);

/* PostgreSQL ANY Operator */
/*
The PostgreSQL ANY operator compares a value to a set of values returned by a subquery. 

expresion operator ANY(subquery)

. The subquery must return exactly one column.
. The ANY operator must be preceded by one of the following comparison operator =, <=, >, <, > and <>
. The ANY operator returns true if any value of the subquery meets the condition, otherwise, it returns false.

Note that SOME is a synonym for ANY, meaning that you can substitute SOME for ANY in any SQL statement.
*/

SELECT
    MAX( length )
FROM
    film
INNER JOIN film_category
        USING(film_id)
GROUP BY
    category_id;

-- any
SELECT title
FROM film
WHERE length >= ANY(
    SELECT MAX( length )
    FROM film
    INNER JOIN film_category USING(film_id)
    GROUP BY  category_id );

/*
Para cada categoría de película, la subconsulta encuentra la duración máxima.
La consulta externa analiza todos estos valores y determina qué duración de la película es mayor o igual 
que la duración máxima de cualquier categoría de película.

Tenga en cuenta que si la subconsulta no devuelve ninguna fila, la consulta completa devuelve un conjunto de resultados vacío.
*/

/*
ANY vs. IN
The = ANY is equivalent to IN operator
*/

-- any
SELECT
    title,
    category_id
FROM
    film
INNER JOIN film_category
        USING(film_id)
WHERE
    category_id = ANY(
        SELECT
            category_id
        FROM
            category
        WHERE
            NAME = 'Action'
            OR NAME = 'Drama'
    );

-- in
SELECT
    title,
    category_id
FROM
    film
INNER JOIN film_category
        USING(film_id)
WHERE
    category_id IN(
        SELECT
            category_id
        FROM
            category
        WHERE
            NAME = 'Action'
            OR NAME = 'Drama'
    );
	
/* PostgreSQL ALL Operator */
/*
The PostgreSQL ALL operator allows you to query data by comparing a value with a list of values returned by a subquery.

comparison_operator ALL (subquery)

. The ALL operator must be preceded by a comparison operator such as equal (=), not equal (!=),
greater than (>), greater than or equal to (>=), less than (<), and less than or equal to (<=).
. The ALL operator must be followed by a subquery which also must be surrounded by the parentheses.

column_name > ALL (subquery) the expression evaluates to true if a value is greater than the biggest value returned by the subquery.
column_name >= ALL (subquery) the expression evaluates to true if a value is greater than or equal to the biggest value returned by the subquery.
column_name < ALL (subquery) the expression evaluates to true if a value is less than the smallest value returned by the subquery.
column_name <= ALL (subquery) the expression evaluates to true if a value is less than or equal to the smallest value returned by the subquery.
column_name = ALL (subquery) the expression evaluates to true if a value is equal to any value returned by the subquery.
column_name != ALL (subquery) the expression evaluates to true if a value is not equal to any value returned by the subquery.
In case the subquery returns no row, then the ALL operator always evaluates to true.
*/

-- subquery
SELECT
    ROUND(AVG(length), 2) avg_length
FROM
    film
GROUP BY
    rating
ORDER BY
    avg_length DESC;

-- all
SELECT
    film_id,
    title,
    length
FROM
    film
WHERE
    length > ALL (
            SELECT
                ROUND(AVG (length),2)
            FROM
                film
            GROUP BY
                rating
    )
ORDER BY
    length;

/* PostgreSQL EXISTS */
/*
The EXISTS operator is a boolean operator that tests for existence of rows in a subquery.

EXISTS (subquery)

The EXISTS accepts an argument which is a subquery.

If the subquery returns at least one row, the result of EXISTS is true. 
In case the subquery returns no row, the result is of EXISTS is false.

The EXISTS operator is often used with the correlated subquery.

The result of EXISTS operator depends on whether any row returned by the subquery, and not on the row contents. 
Therefore, columns that appear on the SELECT clause of the subquery are not important.

For this reason, the common coding convention is to write EXISTS in the following form:

SELECT 
    column1
FROM 
    table_1
WHERE 
    EXISTS( SELECT 
                1 
            FROM 
                table_2 
            WHERE 
                column_2 = table_1.column_1);
				
Note that if the subquery returns NULL, the result of EXISTS is true.
*/

-- A) Find customers who have at least one payment whose amount is greater than 11.
SELECT first_name,
       last_name
FROM customer c
WHERE EXISTS
    (SELECT 1
     FROM payment p
     WHERE p.customer_id = c.customer_id
       AND amount > 11 )
ORDER BY first_name,
         last_name;

-- B) NOT EXISTS example
/*
The NOT operator negates the result of the EXISTS operator.
The NOT EXISTS is opposite to EXISTS. 
It means that if the subquery returns no row, the NOT EXISTS returns true.
If the subquery returns one or more rows, the NOT EXISTS returns false.
*/

SELECT first_name,
       last_name
FROM customer c
WHERE NOT EXISTS
    (SELECT 1
     FROM payment p
     WHERE p.customer_id = c.customer_id
       AND amount > 11 )
ORDER BY first_name,
         last_name;
		 
-- C) EXISTS and NULL
/*
If the subquery returns NULL, EXISTS returns true.
*/

SELECT
	first_name,
	last_name
FROM
	customer
WHERE
	EXISTS( SELECT NULL )
ORDER BY
	first_name,
	last_name;

/* PostgreSQL INSERT */
/*
INSERT INTO table_name(column1, column2, …)
VALUES (value1, value2, …);

The INSERT statement returns a command tag with the following form:
INSERT oid count

OID is an object identifier.
PostgreSQL used the OID internally as a primary key for its system tables. 
Typically, the INSERT statement returns OID with value 0. 
The count is the number of rows that the INSERT statement inserted successfully.
*/

-- RETURNING clause
/*
The INSERT statement also has an optional RETURNING clause that returns the information of the inserted row.

If you want to return the entire inserted row, you use an asterisk (*) after the RETURNING keyword:

INSERT INTO table_name(column1, column2, …)
VALUES (value1, value2, …)
RETURNING *;

If you want to return just some information of the inserted row, 
you can specify one or more columns after the RETURNING clause.

For example, the following statement returns the id of the inserted row:

INSERT INTO table_name(column1, column2, …)
VALUES (value1, value2, …)
RETURNING id;

To rename the returned value, you use the AS keyword followed by the name of the output. For example:

INSERT INTO table_name(column1, column2, …)
VALUES (value1, value2, …)
RETURNING output_expression AS output_name;
*/

DROP TABLE IF EXISTS links;

CREATE TABLE links (
	id SERIAL PRIMARY KEY,
	url VARCHAR(255) NOT NULL,
	name VARCHAR(255) NOT NULL,
	description VARCHAR (255),
        last_update DATE
);

-- 1) PostgreSQL INSERT – Inserting a single row into a table

INSERT INTO links (url, name)
VALUES('https://www.postgresqltutorial.com','PostgreSQL Tutorial');

SELECT	* FROM links;

-- 2) PostgreSQL INSERT – Inserting character string that contains a single quote
/*
If you want to insert a string that contains a single quote (') such as O'Reilly Media,
you have to use an additional single quote (') to escape it. For example:
*/

INSERT INTO links (url, name)
VALUES('http://www.oreilly.com','O''Reilly Media');

-- 3) PostgreSQL INSERT – Inserting a date value
/*
To insert a date value into a column with the DATE type, you use the date in the format 'YYYY-MM-DD'.
*/

INSERT INTO links (url, name, last_update)
VALUES('https://www.google.com','Google','2013-06-01');

-- 4) PostgreSQL INSERT- Getting the last insert id

INSERT INTO links (url, name)
VALUES('http://www.postgresql.org','PostgreSQL') 
RETURNING id;

/* PostgreSQL INSERT Multiple Rows */
/*
INSERT INTO table_name (column_list)
VALUES
    (value_list_1),
    (value_list_2),
    ...
    (value_list_n)
RETURNING * | output_expression;
*/

INSERT INTO 
    links (url, name)
VALUES
    ('https://www.google.com','Google'),
    ('https://www.yahoo.com','Yahoo'),
    ('https://www.bing.com','Bing');
	
SELECT * FROM links;

-- returning rows
INSERT INTO 
    links(url,name, description)
VALUES
    ('https://duckduckgo.com/','DuckDuckGo','Privacy & Simplified Search Engine'),
    ('https://swisscows.com/','Swisscows','Privacy safe WEB-search')
RETURNING *;

-- returning id
INSERT INTO 
    links(url,name, description)
VALUES
    ('https://www.searchencrypt.com/','SearchEncrypt','Search Encrypt'),
    ('https://www.startpage.com/','Startpage','The world''s most private search engine')
RETURNING id;

/* PostgreSQL UPDATE */
/*
UPDATE table_name
SET column1 = value1,
    column2 = value2,
    ...
WHERE condition
RETURNING * | output_expression AS output_name;
*/

DROP TABLE IF EXISTS courses;

CREATE TABLE courses(
	course_id serial primary key,
	course_name VARCHAR(255) NOT NULL,
	description VARCHAR(500),
	published_date date
);

INSERT INTO 
	courses(course_name, description, published_date)
VALUES
	('PostgreSQL for Developers','A complete PostgreSQL for Developers','2020-07-13'),
	('PostgreSQL Admininstration','A PostgreSQL Guide for DBA',NULL),
	('PostgreSQL High Performance',NULL,NULL),
	('PostgreSQL Bootcamp','Learn PostgreSQL via Bootcamp','2013-07-11'),
	('Mastering PostgreSQL','Mastering PostgreSQL in 21 Days','2012-06-30');
	
SELECT * FROM courses;

-- 1) PostgreSQL UPDATE – updating one row

UPDATE courses
SET published_date = '2020-08-01' 
WHERE course_id = 3;

SELECT * FROM courses WHERE course_id = 3;

-- 2) PostgreSQL UPDATE – updating a row and returning the updated row

UPDATE courses
SET published_date = '2020-07-01'
WHERE course_id = 2
RETURNING *;

/* PostgreSQL UPDATE Join */
/*
Sometimes, you need to update data in a table based on values in another table. 
In this case, you can use the PostgreSQL UPDATE join syntax as follows:

UPDATE t1
SET t1.c1 = new_value
FROM t2
WHERE t1.c2 = t2.c2;
*/

CREATE TABLE product_segment (
    id SERIAL PRIMARY KEY,
    segment VARCHAR NOT NULL,
    discount NUMERIC (4, 2)
);

INSERT INTO 
    product_segment (segment, discount)
VALUES
    ('Grand Luxury', 0.05),
    ('Luxury', 0.06),
    ('Mass', 0.1);

CREATE TABLE product(
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    price NUMERIC(10,2),
    net_price NUMERIC(10,2),
    segment_id INT NOT NULL,
    FOREIGN KEY(segment_id) REFERENCES product_segment(id)
);

INSERT INTO 
    product (name, price, segment_id) 
VALUES 
    ('diam', 804.89, 1),
    ('vestibulum aliquet', 228.55, 3),
    ('lacinia erat', 366.45, 2),
    ('scelerisque quam turpis', 145.33, 3),
    ('justo lacinia', 551.77, 2),
    ('ultrices mattis odio', 261.58, 3),
    ('hendrerit', 519.62, 2),
    ('in hac habitasse', 843.31, 1),
    ('orci eget orci', 254.18, 3),
    ('pellentesque', 427.78, 2),
    ('sit amet nunc', 936.29, 1),
    ('sed vestibulum', 910.34, 1),
    ('turpis eget', 208.33, 3),
    ('cursus vestibulum', 985.45, 1),
    ('orci nullam', 841.26, 1),
    ('est quam pharetra', 896.38, 1),
    ('posuere', 575.74, 2),
    ('ligula', 530.64, 2),
    ('convallis', 892.43, 1),
    ('nulla elit ac', 161.71, 3);

-- update
UPDATE 
    product p
SET 
    net_price = price - price * discount
FROM 
    product_segment s
WHERE 
    p.segment_id = s.id;

SELECT * FROM product;

/* PostgreSQL DELETE */
/*
DELETE FROM table_name
WHERE condition
RETURNING (select_list | *)
*/

DROP TABLE IF EXISTS links;

CREATE TABLE links (
    id serial PRIMARY KEY,
    url varchar(255) NOT NULL,
    name varchar(255) NOT NULL,
    description varchar(255),
    rel varchar(10),
    last_update date DEFAULT now()
);

INSERT INTO  
   links 
VALUES 
   ('1', 'https://www.postgresqltutorial.com', 'PostgreSQL Tutorial', 'Learn PostgreSQL fast and easy', 'follow', '2013-06-02'),
   ('2', 'http://www.oreilly.com', 'O''Reilly Media', 'O''Reilly Media', 'nofollow', '2013-06-02'),
   ('3', 'http://www.google.com', 'Google', 'Google', 'nofollow', '2013-06-02'),
   ('4', 'http://www.yahoo.com', 'Yahoo', 'Yahoo', 'nofollow', '2013-06-02'),
   ('5', 'http://www.bing.com', 'Bing', 'Bing', 'nofollow', '2013-06-02'),
   ('6', 'http://www.facebook.com', 'Facebook', 'Facebook', 'nofollow', '2013-06-01'),
   ('7', 'https://www.tumblr.com/', 'Tumblr', 'Tumblr', 'nofollow', '2013-06-02'),
   ('8', 'http://www.postgresql.org', 'PostgreSQL', 'PostgreSQL', 'nofollow', '2013-06-02');

SELECT * FROM links;

-- 1) Using PostgreSQL DELETE to delete one row from the table

DELETE FROM links
WHERE id = 8;

DELETE FROM links
WHERE id = 10;

-- 2) Using PostgreSQL DELETE to delete a row and return the deleted row

DELETE FROM links
WHERE id = 7
RETURNING *;

-- 3) Using PostgreSQL DELETE to delete multiple rows from the table

DELETE FROM links
WHERE id IN (6,5)
RETURNING *;

-- 4) Using PostgreSQL DELETE to delete all rows from the table
DELETE FROM links;

/* PostgreSQL DELETE JOIN */
/*
PostgreSQL doesn’t support the DELETE JOIN statement. 
However, it does support the USING clause in the DELETE statement that provides similar functionality as the DELETE JOIN.

DELETE FROM table_name1
USING table_expression
WHERE condition
RETURNING returning_columns;

. First, specify the table expression after the USING keyword. It can be one or more tables.
. Then, use columns from the tables that appear in the USING clause in the WHERE clause for joining data.

DELETE FROM t1
USING t2
WHERE t1.id = t2.id
*/

DROP TABLE IF EXISTS contacts;
CREATE TABLE contacts(
   contact_id serial PRIMARY KEY,
   first_name varchar(50) NOT NULL,
   last_name varchar(50) NOT NULL,
   phone varchar(15) NOT NULL
);

DROP TABLE IF EXISTS blacklist;
CREATE TABLE blacklist(
    phone varchar(15) PRIMARY KEY
);

INSERT INTO contacts(first_name, last_name, phone)
VALUES ('John','Doe','(408)-523-9874'),
       ('Jane','Doe','(408)-511-9876'),
       ('Lily','Bush','(408)-124-9221');

INSERT INTO blacklist(phone)
VALUES ('(408)-523-9874'),
       ('(408)-511-9876');

-- delete with USING
DELETE FROM contacts 
USING blacklist
WHERE contacts.phone = blacklist.phone;

-- delete join using a subquery (sql standard)
DELETE FROM contacts
WHERE phone IN (SELECT phone FROM blacklist);

-- actualitzar fila si ja existeix
/* PostgreSQL Upsert Using INSERT ON CONFLICT statement */
/*
In relational databases, the term upsert is referred to as merge.
The idea is that when you insert a new row into the table, PostgreSQL will update the row if it already exists, 
otherwise, it will insert the new row. 
That is why we call the action is upsert (the combination of update or insert).

To use the upsert feature in PostgreSQL, you use the INSERT ON CONFLICT statement as follows:

INSERT INTO table_name(column_list) 
VALUES(value_list)
ON CONFLICT target action;

PostgreSQL added the ON CONFLICT target action clause to the INSERT statement to support the upsert feature.

In this statement, the target can be one of the following:
. (column_name) – a column name.
. ON CONSTRAINT constraint_name – where the constraint name could be the name of the UNIQUE constraint.
. WHERE predicate – a WHERE clause with a predicate.

The action can be one of the following:
. DO NOTHING – means do nothing if the row already exists in the table.
. DO UPDATE SET column_1 = value_1, .. WHERE condition – update some fields in the table.

Notice that the ON CONFLICT clause is only available from PostgreSQL 9.5. 
If you are using an earlier version, you will need a workaround to have the upsert feature.
If you are also working with MySQL, you will find that the upsert feature is similar to the insert on duplicate key update statement in MySQL.
*/

DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
	customer_id serial PRIMARY KEY,
	name VARCHAR UNIQUE,
	email VARCHAR NOT NULL,
	active bool NOT NULL DEFAULT TRUE
);

INSERT INTO 
    customers (name, email)
VALUES 
    ('IBM', 'contact@ibm.com'),
    ('Microsoft', 'contact@microsoft.com'),
    ('Intel', 'contact@intel.com');

SELECT * FROM customers;

/*
Suppose Microsoft changes the contact email from contact@microsoft.com to hotline@microft.com, 
we can update it using the UPDATE statement. 
However, to demonstrate the upsert feature, we use the following INSERT ON CONFLICT statement:
*/

INSERT INTO customers (NAME, email)
VALUES('Microsoft','hotline@microsoft.com') 
ON CONFLICT ON CONSTRAINT customers_name_key 
DO NOTHING;

-- equivalent
INSERT INTO customers (name, email)
VALUES('Microsoft','hotline@microsoft.com') 
ON CONFLICT (name) 
DO NOTHING;

-- concatenar email nou; email vell
INSERT INTO customers (name, email)
VALUES('Microsoft','hotline@microsoft.com') 
ON CONFLICT (name) 
DO 
   UPDATE SET email = EXCLUDED.email || ';' || customers.email;
  
-- actualitzar email
INSERT INTO customers (name, email)
VALUES('Microsoft','hotline@microsoft.com') 
ON CONFLICT (name) 
DO 
   UPDATE SET email = EXCLUDED.email
