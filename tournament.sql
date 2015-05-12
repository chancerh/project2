-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

-- Drop it all


DROP TABLE players CASCADE;
DROP TABLE matches CASCADE;
-- DROP VIEW playerStanding;
-- DROP VIEW playerWins;
-- DROP TABLE matches;
-- DROP TABLE players;

-- Table of players. One row per player.
CREATE TABLE players (
       id SERIAL PRIMARY KEY,
       name TEXT
);

-- table of matches.
CREATE TABLE matches (
       id SERIAL PRIMARY KEY,
       loser SERIAL REFERENCES players(id),
       winner SERIAL REFERENCES players(id)
);

-- Views for the following:
-- * Number of matches each player has played
-- * The number of wins for each player
-- * The player standings.

-- Numner of wins
CREATE OR REPLACE VIEW playerWins AS
       SELECT name, players.id, COUNT(winner) AS numWins
       FROM players LEFT JOIN matches
       ON players.id = matches.winner
       GROUP BY players.id
;

CREATE OR REPLACE VIEW playerLosses AS
       SELECT name, players.id, COUNT(loser) AS numLosses
       FROM players LEFT JOIN matches
       ON players.id = matches.loser
       GROUP BY players.id
;


-- Number of matches by player.
CREATE OR REPLACE VIEW playerMatches AS
       SELECT wins.id, numLosses + numWins AS numMatches
       FROM playerWins AS wins INNER JOIN playerLosses AS losses
       ON wins.id = losses.id
;

-- Player standings
CREATE OR REPLACE VIEW playerStandings AS
       SELECT playerWins.id, players.name, numWins AS wins,
              numMatches AS matches
       FROM players INNER JOIN playerWins
       ON players.id = playerWins.id
       INNER JOIN playerMatches
       ON playerWins.id = playerMatches.id
       ORDER BY wins DESC
;

-- CREATE OR REPLACE VIEW playerMatches AS
--        SELECT players.name, players.id, count(*) AS numMatches
--        FROM players LEFT JOIN matches a
--        ON players.id = a.winner
--        LEFT JOIN matches b
--        ON players.id = b.loser
--        GROUP BY players.id
-- ;

-- CREATE OR REPLACE VIEW playerMatches AS
--        SELECT players.name, players.id, count(*) AS numMatches
--        FROM players LEFT JOIN matches

-- * The number of wins for each player



-- Player standings needs
-- CREATE OR REPLACE VIEW playerStanding AS
--        SELECT id, name, numWins, numMatches FROM
--        playerWins INNER JOIN playerMatches

--        ORDER BY numWins
-- ;
