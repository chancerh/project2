#!/usr/bin/env python
#
# tournament.py -- implementation of a Swiss-system tournament
#

import psycopg2


def connect():
    """Connect to the PostgreSQL database.  Returns a database connection."""
    db = psycopg2.connect("dbname=tournament")
    cursor = db.cursor()
    return db, cursor


def dbUpdate(command, *args):
    """
    Opens the database, executes an SQL command, commits the changes and closes
    the database.

    Args:
        command: an SQL command
        *args: an arbitrary number of paramaters to pass to the SQL query passed
              via the "command" argument.
    """
    db, cursor = connect()
    cursor.execute(command, args)
    db.commit()
    db.close()


def deleteMatches():
    """Remove all the match records from the database."""
    dbUpdate("DELETE FROM matches")


def deletePlayers():
    """Remove all the player records from the database."""
    dbUpdate("DELETE FROM players")


def countPlayers():
    """Returns the number of players currently registered."""
    db, cursor = connect()
    # Count the number of IDs in the players table
    cursor.execute("SELECT COUNT(id) FROM players")
    count = cursor.fetchone()[0]
    db.close()
    return count


def registerPlayer(name):
    """Adds a player to the tournament database.

    The database assigns a unique serial id number for the player.  (This
    should be handled by your SQL database schema, not in your Python code.)

    Args:
      name: the player's full name (need not be unique).
    """
    # Insert name into players table - ID automatically created by DB
    # Because name is text, make sure that it is "clean"
    dbUpdate("INSERT INTO players (name) VALUES (%s);", name)


def playerStandings():
    """Returns a list of the players and their win records, sorted by wins.

    The first entry in the list should be the player in first place, or a player
    tied for first place if there is currently a tie.

    Returns:
      A list of tuples, each of which contains (id, name, wins, matches):
        id: the player's unique id (assigned by the database)
        name: the player's full name (as registered)
        wins: the number of matches the player has won
        matches: the number of matches the player has played
    """
    db, cursor = connect()
    # Read the playerStandings table and format the output
    cursor.execute("SELECT * FROM playerStandings")
    # standings = [(int(row[0]), str(row[1]), int(row[2]), int(row[3]))
    # for row in cursor.fetchall()]
    standings = [row for row in cursor.fetchall()]
    db.close()
    return standings


def reportMatch(winner, loser):
    """Records the outcome of a single match between two players.

    Args:
      winner:  the id number of the player who won
      loser:  the id number of the player who lost
    """
    dbUpdate("INSERT INTO matches (winner, loser) VALUES (%s, %s);", winner,
             loser)


def swissPairings():
    """Returns a list of pairs of players for the next round of a match.

    Assuming that there are an even number of players registered, each player
    appears exactly once in the pairings.  Each player is paired with another
    player with an equal or nearly-equal win record, that is, a player adjacent
    to him or her in the standings.

    Returns:
      A list of tuples, each of which contains (id1, name1, id2, name2)
        id1: the first player's unique id
        name1: the first player's name
        id2: the second player's unique id
        name2: the second player's name
    """
    # Get the player standings
    standings = playerStandings()

    # Standings is ordered by number of wins, so just need to pair adjacent
    # players. Create a list that goes from 0 to the number of players by 2.
    # Each element of that list represents the index of player one. Pair each
    # with (index of player 1) + 1
    indexBy2 = range(0, countPlayers(), 2)
    pairings = map(lambda x: (standings[x][0:2] + standings[x + 1][0:2]),
                   indexBy2)
    return pairings
