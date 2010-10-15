======
StockWatch
======

Analyze a set list of stocks for the following information:
- Posts Today (The # of posts on InvestorsHub for the Stock's message board)
- Followers (The # of followers on InvestorsHub for the Stock's message board)
- Change (The change in price for the stock from profitspi)
- %Change (The % change in price for the stock from profitspi)
- 5 Day Avg Volume (The 5 Day Average volume from profitspi)
- 10 Day Avg Volume (The 10 Day Average volume from profitspi)
- Todays Volume (Todays Volume from profitspi) 
- Todays Volume x 5 Day Avg Volume (Comparison of todays volume x 5 day avg)
- Todays Volume x 10 Day Avg Volume (Comparison of todays volume x 10day avg)

The output is sent to a seperate .csv for each stock symbol.

This would be used in conjunction with a cron job, to run multiple times during the day and analyze the results. The hope would be if the 'Posts Today', 'Followers', 'Todays Volume' and 'Todays Volume compared to 5/10 Day Avg Vol' are all increasing, it may be a good time to purchase some shares. 

Requirements
============

* Perl
* Perl Modules:
** WWW::Mechanize
** HTTP::Cookies
** HTML::TreeBuilder

Installation
============

Get the code
------------

::
    git clone git@github.com:jgilmour/stockwatch.git

Find list of board id's from investorshub.advfn.com
---------------------------------------------------

MSFT - http://investorshub.advfn.com/boards/board.aspx?board_id=204
-- Board ID: 204
AAPL - http://investorshub.advfn.com/boards/board.aspx?board_id=64
-- Board ID: 64
GOOG - http://investorshub.advfn.com/boards/board.aspx?board_id=2518
-- Board ID: 2518

Edit boardlist and add the list of Board IDs
::
	cat boardlist
	204
	64
	2518

Usage
=====

First Run
---------

After you have setup boardlist, run the file runme.sh (./runme.sh)
The output will look like the following:
::    
     ./runme.sh
::    
     Starting stock analysis.........Done!

After it's done check the .csv/ folder

:: 
    csv/*
::
    csv/AAPL.csv  csv/GOOG.csv  csv/MSFT.csv

The output should look like the following:

:: 
    cat csv/*.csv
::
    SYMBL   POSTS   FOLLOWS CHG     %CHG    Vol     10DAvg  5DAvg   xX5DAvg xX10DAvg
::
    AAPL    4       261     8.18    2.71%   23002074        18447800        19299181        1.1     1.2
::
    SYMBL   POSTS   FOLLOWS CHG     %CHG    Vol     10DAvg  5DAvg   xX5DAvg xX10DAvg
::
    GOOG    5       78      58.93   10.89%  11924003        3177278 3786843 3.1     3.7
::
    SYMBL   POSTS   FOLLOWS CHG     %CHG    Vol     10DAvg  5DAvg   xX5DAvg xX10DAvg
::
    MSFT    0       78      0.21    0.83%   48200376        58575783        49244190        0.9     0.8

Todo
=====

* Make CSV use commas instead of tabs
* Export to Google Spreadsheet/xls/html tables
