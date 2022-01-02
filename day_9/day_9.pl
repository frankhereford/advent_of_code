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

# make check cell recursive and return the ultimate lowest cell

# categorize cells by result of check cell



#print Dumper $board;

check_cell($board, 4, 9);

my %basins;

for (my $x = 0; $x < scalar(@{$board}); $x++) {
  for (my $y = 0; $y < scalar(@{$board->[$x]}); $y++) {
    my $low_spot = check_cell($board, $x, $y), "\n";
    $basins{$low_spot}++;
  }
  print "\n";
}

delete $basins{'nine'};

print Dumper \%basins;

my @keys = sort { $basins{$b} <=> $basins{$a} } keys %basins;

foreach my $key ( @keys ) {
    printf "%-20s %6d\n", $key, $basins{$key};
}

print $basins{$keys[0]} * $basins{$keys[1]} * $basins{$keys[2]}, "\n";

sub check_cell {
  my $board = shift;
  my $x = shift;
  my $y = shift;

  return 'nine' if $board->[$x]->[$y] == 9;


  my @neighbors = ();
  push @neighbors, [$x, $y - 1] if $y > 0; # up
  push @neighbors, [$x, $y + 1] if $y < scalar(@{$board->[0]}) - 1; # down
  push @neighbors, [$x - 1, $y] if $x > 0; # left
  push @neighbors, [$x + 1, $y] if $x < scalar(@{$board}) - 1; # right

  #print Dumper \@neighbors;

  foreach my $neighbor (@neighbors) {
    #print $neighbor, "\n";
    if ($board->[$neighbor->[0]]->[$neighbor->[1]] < $board->[$x]->[$y]) {
      return check_cell($board, $neighbor->[0], $neighbor->[1]);
    }
  }

  return $x . 'x' . $y;

}
