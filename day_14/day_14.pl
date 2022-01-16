#!/usr/bin/perl

use strict;
use FindBin;
use lib $FindBin::Bin;
use Term::ANSIColor;
use Data::Dumper;

my @input = ();
open (my $input, '<', 'test_input');
while (my $line = <$input>) { 
  chomp $line;
  #print $line, "\n";
  push @input, $line;
}
close $input;

my $polymer = shift(@input);
shift(@input);

print $polymer, "\n\n";

foreach my $operation (@input) {
  #print $operation, "\n";
  $operation =~ /(\w)(\w) -> (\w)/;
  my $start = $1;
  my $end = $2;
  my $addition = $3;
  
  print "Start: ", $start, "\n";
  print "End: ", $end, "\n";
  print "Addition: ", $addition, "\n";
  print "\n";

  my $match_pattern = $start . $end;
  my $match_regex = qr/$match_pattern/;
  my $replace_pattern = $start . $addition . $end;

  $polymer =~ s/$start . $end/$start . $addition . $end/g;
  print $polymer, "\n";
  <>;
}
