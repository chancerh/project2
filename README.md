# Tournament Database

## What is it?



This package contains the following files:
     - tournament.sql
     - tournament.py
     - This README

To use this program, setup the database by running psql -f tournament.sql from 
the command line. NOTE: This will delete any existing tables named players and 
matches as well as any objects that depend on these tables. Once the database is
setup, you can import the functions from tournament.py to interact with the 
tournament database. 
