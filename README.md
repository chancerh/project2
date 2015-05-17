# Tournament Database

## Description
This package contains two components: tournament.sql, a database schema,  and
tournament.py, a python module. The schema sets up a database to store game
players, matches and results. The python module provides functions to interact
with the database and pair up players in tournament matches.

## Database setup
To setup the database, create a new database called "tournament" from the
command line with the createdb command:
```
createdb tournament
```
Load the schema using the psql command:
```
psql -d tournament -f tournament.sql
```

Note: This will delete any existing tables named players or matches as well as
any objects that depend on these tables. If these tables do not exist, the
psql output will contain error messages stating that these tables do not exist.
These messages can be ignored.

## Using the Python module
The tournament.py module can be imported like any normal Python module.
