-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


-- Table of players. One row per player.
CREATE TABLE players (
       id SERIAL PRIMARY KEY,
       name TEXT
);

-- table of matches. 
CREATE TABLE matches (
       match SERIAL PRIMARY KEY,
       player1 REFERENCES players(id),
       player2 REFERENCES players(id),
       winner REFERENCES players(id)
);     
       
-- Views for the following:
-- * Number of matches each player has played
-- * The number of wins for each player
-- * The player standings.

-- Number of matches. In Swiss style tournaments, doesn't everybody play in every round?

-- * The number of wins for each player
CREATE OR REPLACE VIEW playerWins AS
       SELECT name, id, COUNT(winner) as numWins
       FROM players LEFT JOIN matches
       ON plyers.id = matches.winner
       GROUP BY players.id
;


CREATE OR REPLACE VIEW playerStanding AS
       SELECT * from playerWins
       ORDER BY numWins
;
       
       
