#!/usr/bin/perl

use strict;
use Data::Dumper;

=cut
https://youtu.be/XEt09iK8IXs?t=1266

* There are 100 holes in a line, and there is a rabbit in one of the holes
* You can only look in one hole at a time, and every time you look, the rabbit jumps to an adjacent hole
* Better solutions does the task with the best O. 
* Bonus points for discovering the worst case senario in terms of hole-peeks for 100 holes.
=cut


# parameters
my $number_of_holes = $ARGV[0];

# state of the problem
my $number_of_peeks = 0;
my $holes = setup_holes($number_of_holes);

# state of the algorithm
my $is_not_initial_guess = 0;
my $in_even_hole = 0;

while (1) {
  # <algorithm>

  # the trick to this is going to be to track the even-ness of the presumed location of the rabbit, 
  # because that value will toggle back and forth on every failed peek
  my $guess = undef;
  if ($is_not_initial_guess) { 
    $is_not_initial_guess++;
    $guess = int($number_of_holes / 2);
    unless ($guess % 2) { # guess is even
      $guess--;
    }
  } else {
    $guess = 0;
  }

  # </algorithm>






  print "Turn #", $number_of_peeks + 1, "; Let's peek in hole index ", $guess, "\n";
  #print Dumper $holes;
  $holes = peek($guess, $holes);
  print "\nHere's what the holes look like now after that peek:\n";
  print Dumper $holes;
  print "\n---- New Turn ------\n\n";
  #<>;
}


sub peek {
  my $guess = shift;
  my $holes = shift;
  $number_of_peeks++;
  if ($holes->[$guess]) {
    print "You found the rabbit in hole index number ", $guess, " in ", $number_of_peeks, " peeks.\n";
    exit;
  }
  for (my $x = 0; $x < $number_of_holes; $x++) {
    if ($holes->[$x]) {
      print "The rabbit was in hole index ", $x, ".\n";
      if ($x == 0) { # the rabbit can only move right
        $holes->[$x] = 0;
        $holes->[$x+1] = 1;
      } elsif ($x == ($number_of_holes - 1)) { # the rabbit can only move left
        $holes->[$number_of_holes - 1] = 0;
        $holes->[$number_of_holes - 2] = 1;
      }
      else {
        $holes->[$x] = 0;
        if (rand() > .5) {
          $holes->[$x + 1] = 1;
        } else {
          $holes->[$x - 1] = 1;
        }
      }
      return $holes;
    }
  }
}

sub setup_holes {
  my $number_of_holes = shift;

  print "Solving for ", $number_of_holes, " holes.\n";

  my @holes = ();
  for (my $x = 0; $x < $number_of_holes; $x++) {
    $holes[$x] = 0;
  }

  my $hole_with_rabbit = int(rand($number_of_holes));
  $holes[$hole_with_rabbit] = 1;
  
  print "Initial state of holes:\n";
  print Dumper \@holes;

  return \@holes;
}