CREATE TABLE persons (
  id SERIAL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  dob DATE,
  email VARCHAR(255),
  PRIMARY KEY (id)
);

-- persons.csv

COPY persons(first_name, last_name, dob, email)
FROM 'C:\APP\psycopg_test\csv\persons.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM persons;