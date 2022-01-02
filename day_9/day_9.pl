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

#print Dumper $board;
my $low_score = 0;

#check_cell($board, 4, 9);

for (my $x = 0; $x < scalar(@{$board}); $x++) {
  for (my $y = 0; $y < scalar(@{$board->[$x]}); $y++) {
    my $is_lowest = check_cell($board, $x, $y);
    print "$x $y: " . $is_lowest . "\n";
    $low_score += 1 + $board->[$x]->[$y] if $is_lowest;
  }
}

print "Low score: ", $low_score, "\n";


sub check_cell {
  my $board = shift;
  my $x = shift;
  my $y = shift;

  my @neighbors = ();
  push @neighbors, [$x, $y - 1] if $y > 0; # up
  push @neighbors, [$x, $y + 1] if $y < scalar(@{$board->[0]}) - 1; # down
  push @neighbors, [$x - 1, $y] if $x > 0; # left
  push @neighbors, [$x + 1, $y] if $x < scalar(@{$board}) - 1; # right

  #print Dumper \@neighbors;

  # is here lowest?
  my $is_lowest = 1;

  foreach my $neighbor (@neighbors) {
    # set here_is_lowest false if neighbor is lower
    $is_lowest = 0 if ($board->[$x]->[$y] > $board->[$neighbor->[0]]->[$neighbor->[1]]);
  }
  return $is_lowest;
}
