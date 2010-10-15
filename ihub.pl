#!/usr/bin/perl

# iHub.pl 
# Reads from Boards.cfg
# First script thats run, pulls info from iHub (Symbol, Followers, Posts Today)
# Calls GoogleSpreadsheet() and updates row with info
# Sends Symbol to profitspi.pl to do lookup 

use strict;
use WWW::Mechanize;
use HTTP::Cookies;
use HTML::TreeBuilder;
use POSIX;
print ".";

#dev localhost
#my $url = "http://localhost/board" . $ARGV[0] . ".aspx";

#prod
my $url = "http://investorshub.advfn.com/boards/board.aspx?board_id=" . $ARGV[0];

#print "[DEBUG] Logging into url: $url\n";
my $mech = WWW::Mechanize->new();
$mech->cookie_jar(HTTP::Cookies->new());
$mech->get($url);
my $output_page = $mech->content();

# set nodes_as_strings seperated by td's in html
use HTML::TreeBuilder::XPath;
my $tree= HTML::TreeBuilder::XPath->new;
$tree->parse($output_page);   #from LWP content()
$tree->eof();
my @td = $tree->findnodes_as_strings('//td');

# setup global vars
my $stockSymbol;
my $stockDesc;
my $postsToday;
my $followers;
my @newarray;
my $lines = 0;
my @extract;

# push push push
foreach (@td) {
if (/\S/)
 {
   push(@newarray, $_);
 }
}

#foreach(@newarray) {
#  print "[DEBUG] line $lines: " . $_ . ":\n";
#        $lines++;
#}

foreach (@newarray) { 
 # Iterate through @newarray and perform if statements on each of the line to find data needed

       if ($_ =~ /Followers:/) {
	# Check array to see if 'Followers:' is in the line
	# If so, extract only the number and assign to $followers
	# Then, increment $lines

	   ($followers) = $newarray[$lines] =~ /(\d+)/g;
           $lines++;
       }
      
       elsif ($_ =~ /Posts Today:/) { 
	# Check array to see if 'Posts Today:' is in the line
	# If so, extract only the number and assign to $postsToday
	# Then, increment $lines

	   ($postsToday) = $newarray[$lines] =~ /(\d+)/g;
	   $lines++;
       }
 
       elsif ($_ =~ /Home > Boards/) {
	# Check array to see if 'Home > Boards' is in the line
	# The usual output is like the following:
	# Home > Boards > Category > Category > Stock Name. (SYMBL)
	# Exmaple:  Home > Boards > Small Cap > Internet - Information/Portals >Scientigo, Inc. (SCNG):
	# We split the string using '(' or ')' which gives the stock symbol in '1' for the extract array
	# Then, increment $lines

	   $stockDesc = $newarray[$lines];
	   @extract = split('\(|\)', $stockDesc);
	   $stockSymbol = $extract[1]; 
	   $lines++;
       }

       else {
	# All else fails? Increment $lines

	$lines++;
       }
}

#print "Symbol: ". $stockSymbol . "\n" . "Posts Today: ". $postsToday . "\n" . "Followers: ". $followers . "\n";

# Attempt to run next perl script
system("perl profitspi.pl $stockSymbol $postsToday $followers");
