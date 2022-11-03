# PostgreSQL Python: Connect To PostgreSQL Database Server

https://www.postgresqltutorial.com/postgresql-python/connect/

Connect to the PostgreSQL database server in the Python program using the **psycopg** database adapter.

## psycopg
```
mkdir psycopg_test
cd psycopg_test
python -m pip install --upgrade pip
pip install psycopg2
```

## postgres
```
.crear database
postgres=# CREATE DATABASE test;

.llistar databases
\l o \l+

.crear usuari per la base de dades
postgres=# CREATE USER usertest WITH PASSWORD 'test1234';
CREATE ROLE
postgres=# GRANT ALL PRIVILEGES ON DATABASE test to usertest;
GRANT
```

## Sample
```
Load PostgreSQL Sample Database
https://www.postgresqltutorial.com/postgresql-getting-started/load-postgresql-sample-database/

. download sample
https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/

psql -U postgres
CREATE DATABASE dvdrental;
exit;

cd C:\Program Files\PostgreSQL\15\bin
pg_restore -U postgres -d dvdrental C:\REIXAPPGO\sampledb\dvdrental.tar

psql -U postgres
\connect dvdrental
```

### PostgreSQL Python

https://www.postgresqltutorial.com/postgresql-python/

All steps:

1. [PostgreSQL Python](step-0-postgresql-python.md)

### PostgreSQL Fundamentals

https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-select/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-column-alias/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-order-by/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-select-distinct/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-where/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-limit/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-fetch/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-in/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-between/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-like/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-is-null/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-alias/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-joins/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-inner-join/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-left-join/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-right-join/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-self-join/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-full-outer-join/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-cross-join/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-natural-join/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-group-by/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-union/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-intersect/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-having/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-grouping-sets/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-cube/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-rollup/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-subquery/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-any/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-all/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-exists/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-insert/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-insert-multiple-rows/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-update/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-update-join/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-delete/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-delete-join/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-upsert/

### PostgreSQL Managing Tables

https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-data-types/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-create-table/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-select-into/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-create-table-as/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-serial/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-sequences/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-identity-column/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-alter-table/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-rename-table/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-add-column/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-drop-column/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-change-column-type/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-rename-column/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-drop-table/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-temporary-table/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-truncate-table/

### PostgreSQL Database Constraints

https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-primary-key/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-foreign-key/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-check-constraint/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-unique-constraint/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-not-null-constraint/

### PostgreSQL Data Types

https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-boolean/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-char-varchar-text/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-numeric/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-integer/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-serial/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-date/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-timestamp/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-interval/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-time/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-uuid/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-json/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-hstore/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-array/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-user-defined-data-types/

### PostgreSQL Conditional Expressions & Operators

https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-case/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-coalesce/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-nullif/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-cast/