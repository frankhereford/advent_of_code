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

my $largest_x = 0;
my $largest_y = 0;
foreach my $line (@input) {
  next if $line =~ /fold/i;
  $line =~ /(\d+),(\d+)/;
  my $x = $1;
  my $y = $2;
  $largest_x = $x if $x > $largest_x;
  $largest_y = $y if $y > $largest_y;
}

print "Largest X: ", $largest_x, "\n";
print "Largest Y: ", $largest_y, "\n";

my $board = [];

for (my $y = 0; $y < $largest_y; $y++) {
  for (my $x = 0; $x < $largest_x; $x++) {
    $board->[$x]->[$y] = { 
      dots => 0,
    }
  }
}

foreach my $line (@input) {
  next if $line =~ /fold/i;
  $line =~ /(\d+),(\d+)/;
  my $x = $1;
  my $y = $2;
  #print $x, ", ", $y, "\n";
  $board->[$y]->[$x]->{'dots'}++;
}

print_board($board);

foreach my $line (@input) {
  next unless $line =~ /fold/;
  print $line, "\n";
  $line =~ /([xy])=(\d+)$/;
  my $direction = $1;
  my $location = $2;
  $board = fold($board, $direction, $location);
  last;
}

print_board($board);

sub fold {
  my $board = shift;
  my $direction = shift;
  my $location = shift;

  if ($direction eq 'y') {

    for (my $y = $location + 1; $y <= $largest_y; $y++) {
      for (my $x = 0; $x <= $largest_x; $x++) {
        # here we can build cords that need to be reflected up
        my $new_y = $location - ($y - $location);
        print $x, ", ", $y, " becomes ", $x, ", ", $new_y, "\n";
        $board->[$new_y]->[$x]->{'dots'} += $board->[$y]->[$x]->{'dots'};
        #<>;
      }
    }

  } else { # x

  }

  return $board;
}

#print Dumper $board;

sub print_board {
  my $board = shift;
  #x and y are flipped in meaning here; this is messy
  for (my $x = 0; $x <= $largest_y; $x++) {
    for (my $y = 0; $y <= $largest_x; $y++) {
      if ($board->[$x]->[$y]->{'has_flashed_this_turn'}) {
        print color('red');
      }
      print $board->[$x]->[$y]->{'dots'} ? '#' : '.';
      if ($board->[$x]->[$y]->{'has_flashed_this_turn'}) {
        print color('reset');
      }
    }
  print "\n";
  }
  print "\n";
}
