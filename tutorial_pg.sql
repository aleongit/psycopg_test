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
