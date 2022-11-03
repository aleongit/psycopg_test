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

#### All steps:

**1.** [PostgreSQL Python](step-0-postgresql-python.md)


### PostgreSQL Fundamentals

* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-select/">Select</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-column-alias/">Column Aliases</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-order-by/">Order By</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-select-distinct/">Select distinct</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-where/">Where</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-limit/">Limit</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-fetch/">Fetch</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-in/">In</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-between/">Between</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-like/">Like</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-is-null/">Is Null</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-alias/">Table Aliases</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-joins/">Joins</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-inner-join/">Inner Join</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-left-join/">Left Join</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-right-join/">Right Join</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-self-join/">Self Join</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-full-outer-join/">Full Outer Join</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-cross-join/">Cross Join</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-natural-join/">Natural Join</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-group-by/">Group By</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-union/">Union</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-intersect/">Intersect</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-having/">Having</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-grouping-sets/">Grouping Sets</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-cube/">Cube</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-rollup/">Rollup</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-subquery/">Subquery</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-any/">Any</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-all/">All</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-exists/">Exists</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-insert/">Insert</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-insert-multiple-rows/">Insert Multiple Rows</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-update/">Update</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-update-join/">Update Join</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-delete/">Delete</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-delete-join/">Delete Join</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-upsert/">Upsert</a>


### PostgreSQL Managing Tables

* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-data-types/">Data Types</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-create-table/">Create Table</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-select-into/">Select Into</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-create-table-as/">Create Table As</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-serial/">Serial</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-sequences/">Sequences</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-identity-column/">Identity Column</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-alter-table/">Alter Table</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-rename-table/">Rename Table</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-add-column/">Add Column</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-drop-column/">Drop Column</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-change-column-type/">Change Column's Data Type</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-rename-column/">Rename Column</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-drop-table/">Drop Table</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-temporary-table/">Temporary Table</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-truncate-table/">Truncate Table</a>


### PostgreSQL Database Constraints

* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-primary-key/">Primary Key</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-foreign-key/">Foreign Key</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-check-constraint/">Check Constraint</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-unique-constraint/">Unique Constraint</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-not-null-constraint/">Not Null Constraint</a>


### PostgreSQL Data Types

* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-boolean/">Boolean</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-char-varchar-text/">Char, Varchar & Text</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-numeric/">Numeric</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-integer/">Integer</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-serial/">Serial</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-date/">Date</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-timestamp/">Timestamp</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-interval/">Interval</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-time/">Time</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-uuid/">Uuid</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-json/">Json</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-hstore/">Hstore</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-array/">Array</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-user-defined-data-types/">User Defined Data Types</a>


### PostgreSQL Conditional Expressions & Operators

* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-case/">Case</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-coalesce/">Coalesce</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-nullif/">Nullif</a>
* <a href="https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-cast/">Cast</a>
