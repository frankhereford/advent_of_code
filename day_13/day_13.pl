#!/usr/bin/perl

use strict;
use FindBin;
use lib $FindBin::Bin;
use Term::ANSIColor;
use Data::Dumper;

my @input = ();
open (my $input, '<', 'input');
while (my $line = <$input>) { 
  chomp $line;
  #print $line, "\n";
  push @input, $line;
}
close $input;

my $largest_x = 0;
my $largest_y = 0;
foreach my $line (@input) {

}

my $board = [];

for (my $x = 0; $x < 10; $x++) {
  for (my $y = 0; $y < 10; $y++) {
    $board->[$y]->[$x] = { 
      level => substr($input[$y], $x, 1),
      has_flashed_this_turn => 0,
    }
  }
}

print_board($board);



#print Dumper $board;

sub print_board {
  my $board = shift;
  for (my $x = 0; $x < 10; $x++) {
    for (my $y = 0; $y < 10; $y++) {
      if ($board->[$x]->[$y]->{'has_flashed_this_turn'}) {
        print color('red');
      }
      print $board->[$x]->[$y]->{'level'};
      if ($board->[$x]->[$y]->{'has_flashed_this_turn'}) {
        print color('reset');
      }
    }
  print "\n";
  }
  print "\n";
}
