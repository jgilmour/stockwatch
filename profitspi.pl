#!/usr/bin/perl
use strict;
use WWW::Mechanize;
use HTTP::Cookies;
use HTML::TreeBuilder;
use POSIX;

print ".";
#argv[0] = symbol
#argv[1] = postsToday
#argv[2] = followers


#dev localhost
#my $url = "http://localhost/" . $ARGV[0] . ".aspx";

#prod
my $url = "http://www.profitspi.com/stock-quote/" . $ARGV[0] . ".aspx";

#print "Logging into url: $url\n";
my $mech = WWW::Mechanize->new();
$mech->cookie_jar(HTTP::Cookies->new());
$mech->get($url);
my $output_page = $mech->content();

use HTML::TreeBuilder::XPath;
my $tree= HTML::TreeBuilder::XPath->new;
$tree->parse($output_page);   #from LWP content()
$tree->eof();
my @td = $tree->findnodes_as_strings('//td');


my $stockSymbol = $ARGV[0]; 
my $postsToday = $ARGV[1];
my $followers = $ARGV[2];
my $times5DayAvg;
my $times10DayAvg;
my $priceChange;
my $percentChange;
my $tenDayAvg;
my $todayVol;
my $fiveDayAvg;
my $lines = 0;
my @newarray;

foreach (@td) {
if (/\S/)
 {
   push(@newarray, $_);
 }
}

# debug will print each of the lines in the array, along with the line #
# if you enable this, make sure to set $lines back to 0 after this foreach statement
## or else it will double $lines

#foreach(@newarray) {
#  print "line $lines: " . $_ . ":\n";
#        $lines++;
#}

foreach (@newarray) { 
       if ($_ eq "High" && $lines != "24")
         {
 #          print "FOUND HIGH ON LINE #" . $lines . "\n";
#	   print "Change: " . $newarray[$lines-2] . "\n";
 #          print "%Change: " . $newarray[$lines-1] . "\n";
           
	   $priceChange = $newarray[$lines-2];
	   $percentChange = $newarray[$lines-1];

           $lines++;
	 }
	elsif ($_ eq "10 Day Average Volume" && $lines != "24")
	 {
#	   print "FOUND 10DAY ON LINE #" . $lines . "\n";
   #        print "10 Day Avg Vol: " . $newarray[$lines+1] . "\n";

	   $tenDayAvg = $newarray[$lines+1];

           $lines++;
         }

       elsif ($_ eq "Volume" && $lines != "24")
         {
  #         print "FOUND Vol ON LINE #" . $lines . "\n";
  #         print "TodayVol: " . $newarray[$lines+1] . "\n";

	   $todayVol = $newarray[$lines+1];
	
           $lines++;
         }

       elsif ($_ eq "5 Day Average Volume" && $lines != "24")
         {
 #          print "FOUND 5DAY ON LINE #" . $lines . "\n";
 #          print "5 Day Avg Vol: " . $newarray[$lines+1] . "\n";
	
	   $fiveDayAvg = $newarray[$lines+1];

           $lines++;
         }
       else { 
	$lines++; }
}


#print "-------\n";
#print "Here is the output: $priceChange - $percentChange - $tenDayAvg - $fiveDayAvg - $todayVol\n";

# Lets get rid of some of the commas, shall we? 
# needed for the math below to calulate the TodayVolxXDayAvgVol comparison
$fiveDayAvg =~ s/,//g;
$tenDayAvg =~s/,//g;
$todayVol =~s/,//g;

# find x of times x five day avg and trim to 3 characters
$times5DayAvg = (($todayVol / $fiveDayAvg));
$times5DayAvg = substr($times5DayAvg, 0, 3);
# find x of times x ten day avg and trim to 3 characters
$times10DayAvg = (($todayVol / $tenDayAvg));
$times10DayAvg = substr($times10DayAvg, 0, 3);


# print it all out (for debug)
##print "Symbol: " . $stockSymbol . "\n";
##print "Posts Today:" . $postsToday . "\n";
##print "Followers:" . $followers . "\n";
##print "Change: " . $priceChange . "\n";
##print "% Change: " . $percentChange . "\n";
##print "10DayAvgVol: " . $tenDayAvg . "\n";
##print "5DayAvgVol: " . $fiveDayAvg . "\n";
##print "TodayVol: " . $todayVol . "\n";
##print "$times5DayAvg x 5DayAvgVol\n";
##print "$times10DayAvg x 10DayAvgVol\n";
##print "--------------------------------\n";

# call the createcsv file (keeps going and going and going)... 
system("perl createcsv.pl $stockSymbol $postsToday $followers $priceChange $percentChange $tenDayAvg $fiveDayAvg $times5DayAvg $times10DayAvg $todayVol");
