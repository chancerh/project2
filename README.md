# Tournament Database

## Purpose
This application provides a Python module to keep track of players,
matches, and game outcomes in a PostgreSQL database. It also pairs
players using the Swiss system.

## Files Included
* tournament.sql: Contains code to setup a database called
  "tournament" and a schema for a database to store game players, matches
  and results.
* tournament.py: a python module that provides functions to interact
  with the database and pair up players in Swiss pairing tournament matches.
* tournament_test.py: Unit tests that populate the database and test
  that the Python module works properly.


## Requirements
This program requires Python and PostgreSQL. It was developed and
tested with Python version 2.7.6 and PostgreSQL version 9.3.6 running
on Ubuntu 14.04.2

Python can be obtained at https://www.python.org/download/

Postgresql can be obtained at the following address:
http://www.postgresql.org/download/

Ubuntu is available at http://www.ubuntu.com/download


## Description
This package contains two components: tournament.sql, a database schema,  and
tournament.py, a python module. The schema sets up a database to store game
players, matches and results. The python module provides functions to interact
with the database and pair up players in tournament matches.

## Database setup
To setup the database, run the following command:
```
psql -f tournament.sql
```
This command will create a new database called "tournament", load the
schema, and create the views. Note: Any existing database named
"tournament" will be deleted.

## Using the Python module
The tournament.py module can be imported like any normal Python
module:

```
from tournament import *
```

The code below registers four players in a tournament:

```
from tournament import registerPlayer
players = ["Werner Herzog", "Fritz Lang", "Tom Tykwer", "Rainer Fassbinder"]
for player in players:
    registerPlayer(player)
```

For full descriptions of the functions in the tournament module, run
the following commands from the python prompt:

```
import tournament
help(tournament)
```
