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

my $board = [];

for (my $x = 0; $x < 10; $x++) {
  for (my $y = 0; $y < 10; $y++) {
    $board->[$x]->[$y] = { 
      level => substr($input[$y], $x, 1),
      has_flashed_this_turn => 0,

  }
}

print Dumper $board;
