-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

-- Drop all existing tables
DROP TABLE players CASCADE;
DROP TABLE matches CASCADE;


-- Table of players. One row per player.
CREATE TABLE players (
       id SERIAL PRIMARY KEY,
       name TEXT);

-- table of matches, one row per match
CREATE TABLE matches (
       id SERIAL PRIMARY KEY,
       loser SERIAL REFERENCES players(id),
       winner SERIAL REFERENCES players(id));


-- Views
-- Numner of wins for each player
CREATE OR REPLACE VIEW playerWins AS
       SELECT name, players.id, COUNT(winner) AS numWins
       FROM players LEFT JOIN matches
       ON players.id = matches.winner
       GROUP BY players.id;

-- Number of losses for each player
CREATE OR REPLACE VIEW playerLosses AS
       SELECT name, players.id, COUNT(loser) AS numLosses
       FROM players LEFT JOIN matches
       ON players.id = matches.loser
       GROUP BY players.id;

-- Number of matches by player - sum of wins and losses
CREATE OR REPLACE VIEW playerMatches AS
       SELECT wins.id, numLosses + numWins AS numMatches
       FROM playerWins AS wins INNER JOIN playerLosses AS losses
       ON wins.id = losses.id;

-- Player standings. Need ID and name (players), number of wins (playerWins) and
-- number of matches (playerMatches)
CREATE OR REPLACE VIEW playerStandings AS
       SELECT playerWins.id, players.name, numWins AS wins,
              numMatches AS matches
       FROM players INNER JOIN playerWins
       ON players.id = playerWins.id
       INNER JOIN playerMatches
       ON playerWins.id = playerMatches.id
       ORDER BY wins DESC;
