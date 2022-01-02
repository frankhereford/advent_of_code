#!/usr/bin/perl

use strict;
use FindBin;
use lib $FindBin::Bin;
use Data::Dumper;


my @input = ();
open (my $input, '<', 'test_input');
#open (my $input, '<', 'input');
while (my $line = <$input>) { 
  chomp $line;
  #print $line, "\n";
  push @input, $line;
}
close $input;

my $board= [];

for (my $x = 0; $x < scalar(@input); $x++) {
  $board->[$x] = [];
  my @heights = split(//, $input[$x]);
  for (my $y = 0; $y < scalar(@heights); $y++) {
    $board->[$x]->[$y] = $heights[$y];
  }
}

print Dumper $board;