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
my $header = "SYMBL\tPOSTS\tFOLLOWS\tCHG\t%CHG\tVol\t10DAvg\t5DAvg\txX5DAvg\txX10DAvg\n"; 

$readfile="./csv/$stockSymbol.csv";
if ( (-e $readfile) && (-r $readfile) ) {}
else {
	open FILE, ">./csv/$stockSymbol.csv";
	print FILE $header;
	close FILE;
}

open FILE, ">>./csv/$stockSymbol.csv";
 print FILE $stockSymbol . "\t";
 print FILE $postsToday . "\t";
 print FILE $followers . "\t";
 print FILE $priceChange . "\t";
 print FILE $percentChange . "\t";
 print FILE $todayVol . "\t";
 print FILE $tenDayAvg . "\t";
 print FILE $fiveDayAvg . "\t";
 print FILE $times5DayAvg . "\t";
 print FILE $times10DayAvg . "\t\n";
close FILE;
