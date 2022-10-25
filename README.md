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

## tutorial pg
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

https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-select/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-column-alias/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-order-by/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-select-distinct/
https://www.geekytidbits.com/postgres-distinct-on/
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