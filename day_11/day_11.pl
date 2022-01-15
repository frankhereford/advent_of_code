#!/usr/bin/perl

use strict;
use FindBin;
use lib $FindBin::Bin;
use Data::Dumper;

my @input = ();
open (my $input, '<', 'test_input');
while (my $line = <$input>) { 
  chomp $line;
  #print $line, "\n";
  push @input, $line;
}
close $input;

my @board = ();

foreach my $rank (@input) {
  my @rank = split(//, $rank);
  push @board, \@rank;
}

print Dumper \@board;