Checkers
========

Command-line checkers program. Run it with

    ruby game.rb
    
It expects moves to be three comma-separated numbers. From the starting board

    5,0,9
    
Is an input for a valid move.

There's a couple test files of lists of moves. I wrote a TestPlayer class that pulls moves from a file and tries them. It's currently used by initializing the game with testplayers instead of players. If I was writing this today, I'd be using rspec instead.
