Stockwatch
========

Analyze a set list of stocks for the following information:

* Posts Today (The # of posts on InvestorsHub for the Stock's message board)
* Followers (The # of followers on InvestorsHub for the Stock's message board)
* Change (The change in price for the stock from profitspi)
* %Change (The % change in price for the stock from profitspi)
* 5 Day Avg Volume (The 5 Day Average volume from profitspi)
* 10 Day Avg Volume (The 10 Day Average volume from profitspi)
* Todays Volume (Todays Volume from profitspi)
* Todays Volume x 5 Day Avg Volume (Comparison of todays volume x 5 day avg)
* Todays Volume x 10 Day Avg Volume (Comparison of todays volume x 10day avg)

The output is sent to a seperate .csv for each stock symbol.

This would be used in conjunction with a cron job, to run multiple times during the day and analyze the results. 

The hope would be if the 'Posts Today', 'Followers', 'Todays Volume' and 'Todays Volume compared to 5/10 Day Avg Vol' are all increasing, it may be a good time to purchase some shares.


Requirements
------------
The following is needed:

  - Linux (or cygwin)
  - Perl
  - Perl Modules:
   - WWW-Mechanize
   - HTTP-Cookies
   - HTML-TreeBuilder

Installation
------------

Get the code from GitHub

    git clone git@github.com:jgilmour/stockwatch.git

Get the board_id numbers from investorshub boards for the stock symbols you would like, examples below:

  - MSFT - http://investorshub.advfn.com/boards/board.aspx?board_id=**204**
   - Board ID: **204**
  - AAPL - http://investorshub.advfn.com/boards/board.aspx?board_id=**64**
   - Board ID: **64**
  - GOOG - http://investorshub.advfn.com/boards/board.aspx?board_id=**2518**
   - Board ID: **2518**

Edit the **boardlist** file and put the board_id's into the file

    cat boardlist
    204
    64
    2518

All set for installation! 

Usage
------------

After you have a list of Board ID's within your 'boardlist' file, you must then run the **runme.sh** file. This file will start analyzing the stocks you have in your boardlist file. It will look like the following:

` ./runme.sh`  
` Starting stock analysis..........Done!`

A folder will have been created called **csv**, when you look in this folder you will see multiple .csv files with the stock name. For example, using the  symbols above in my boardlist file, I have the following output.

`ls ./csv/*.csv`  
`./csv/AAPL.csv  ./csv/GOOG.csv  ./csv/MSFT.csv`

If we look through the files, we see the following:

cat ./csv/AAPL.csv  
SYMBL   POSTS   FOLLOWS CHG     %CHG    Vol     10DAvg  5DAvg   xX5DAvg xX10DAvg  
AAPL    4       261     8.18    2.71%   23002074        18447800        19299181        1.1     1.2

`cat ./csv/GOOG.csv`  
`SYMBL   POSTS   FOLLOWS CHG     %CHG    Vol     10DAvg  5DAvg   xX5DAvg xX10DAvg`  
`GOOG    5       78      58.93   10.89%  11924003        3177278 3786843 3.1     3.7`

`cat ./csv/MSFT.csv`  
`SYMBL   POSTS   FOLLOWS CHG     %CHG    Vol     10DAvg  5DAvg   xX5DAvg xX10DAvg`  
`MSFT    0       78      0.21    0.83%   48200376        58575783        49244190        0.9     0.8`

As you can see if this script is setup in a cron job, and run multiple times during the day, you may be able to see when a stock is getting more and more popular, and possibly the right time to buy in. 

Todo
----

  - Make CSV use commas instead of tabs 
   - It was originally done this way, because volume data has comma's in it already, which was later removed
  - Have ability to export
   - Google Spreadsheet
   - XLS Format
   - HTML Table format
  - Add in Time/Date fields for rows

ScreenShots
-----------

This is a screenshot of a fully working run of Stockwatch. I am analyzing the following stocks:

![stockwatch](http://sphotos.ak.fbcdn.net/hphotos-ak-ash2/hs445.ash2/71862_546038622480_41900271_31886622_1574651_n.jpg "Stockwatch")
