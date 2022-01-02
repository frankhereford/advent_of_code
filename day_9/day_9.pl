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

check_cell($board, 4, 9);

sub check_cell {
  my $board = shift;
  my $x = shift;
  my $y = shift;

  my @neighbors = ();
  push @neighbors, [$x, $y - 1] if $y > 0; # up
  push @neighbors, [$x, $y + 1] if $y < scalar(@{$board->[0]}) - 1; # down
  push @neighbors, [$x - 1, $y] if $x > 0; # left
  push @neighbors, [$x + 1, $y] if $x < scalar(@{$board}) - 1; # right

  print Dumper \@neighbors;
}
