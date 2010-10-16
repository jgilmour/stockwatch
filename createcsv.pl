#!/usr/bin/perl

print ".";
my $stockSymbol = $ARGV[0];
my $postsToday = $ARGV[1];
my $followers = $ARGV[2];
my $priceChange = $ARGV[3];
my $percentChange = $ARGV[4];
my $tenDayAvg = $ARGV[5];
my $fiveDayAvg = $ARGV[6];
my $times5DayAvg = $ARGV[7];
my $times10DayAvg = $ARGV[8];
my $todayVol = $ARGV[9];
my $header = "SYMBL,POSTS,FOLLOWERS,CHANGE,%CHANGE,Vol,10DAvgVol,5DAvgVol,TodayVS5DAvgVol,TodayVS10DAvgVol\n"; 

$readfile="./csv/$stockSymbol.csv";
if ( (-e $readfile) && (-r $readfile) ) {}
else {
	open FILE, ">./csv/$stockSymbol.csv";
	print FILE $header;
	close FILE;
}

open FILE, ">>./csv/$stockSymbol.csv";
 print FILE $stockSymbol . ",";
 print FILE $postsToday . ",";
 print FILE $followers . ",";
 print FILE $priceChange . ",";
 print FILE $percentChange . ",";
 print FILE $todayVol . ",";
 print FILE $tenDayAvg . ",";
 print FILE $fiveDayAvg . ",";
 print FILE $times5DayAvg . ",";
 print FILE $times10DayAvg . ",\n";
close FILE;
