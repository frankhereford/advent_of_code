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
my $in_even_hole = 0;

my $last_guess = undef;
my $last_even_guess = undef;
my $last_odd_guess = undef;

while (1) {
  print "\n---- New Turn ------\n\n";

  # <algorithm>

  # the trick to this is going to be to track the evenness of the presumed location of the rabbit, 
  # because that value will toggle back and forth on every failed peek

  # expanding on the evenness idea: what if we track from one side of the holes on even guess
  # iteration counts and from the other side on odd guesses?
  # this is awkward for an even number of holes?  let's just go with an odd number of holes for now

  # under this system, you track from both sides on alternating turns; if both trackers get
  # to the other side of the holes, the initial assumption of rabbit hole evenness was wrong, 
  # toggle the assumption, and track again from both sides. This should find the rabbit for odd numbers of holes, and
  # if there are an even number of holes, then the rabbit is in the last hole.

  # observations on the fundemental flaws of this implementation:
  # * zero index everything, 5 holes is an *EVEN* number of holes.


  print "We currently believe the rabbit is in an ", $in_even_hole ? 'even' : 'odd', " hole.\n";

  my $guess = undef;

  if (!$number_of_peeks) { # initial guess
    # odd turn number, track from the right
    print "Initial odd turn\n";
    if ($number_of_holes % 2) { 
      # if the number of holes is odd ...
      print "We have an odd number of holes to consider\n";
      $guess = $number_of_holes - 2; # assuming we have an odd number of holes
    } else {
      print "We have an even number of holes to consider\n";
      $guess = $number_of_holes - 1; 
    }
    $last_odd_guess = $guess;
  } elsif ($number_of_peeks == 1) { 
    # initial even guess, track from the left
    print "Initial even turn\n";
    $guess = 0;
    $last_even_guess = $guess;
  } else { # not initial guess
    if ($number_of_peeks % 2) { # remember that turns are one indexed!
      print "Non-initial even turn\n";
      # we're on a non-initial, even turn iteration
      $guess = $last_even_guess + 2;
      $last_even_guess = $guess;
    } else { 
      print "Non-initial odd turn\n";
      # we're on an non-initial, odd turn iteration
      $guess = $last_odd_guess - 2;
      $last_odd_guess = $guess;
    }
  }

  # if non-initial odd turn and guess == -1 -- this happens first
  # if non-initial even turn and guess == number_of_holes + 1

  if ($number_of_peeks % 2 && $number_of_holes % 2) { # same tricky thing; i think it's clear that i made a mistake early on that i'm living with
    # odd number of holes
    if ($number_of_peeks && $guess == $number_of_holes + 1) {
      # we're done with the first pass, and if we got here, our assumption about the rabbit evenness is wrong
      print "Here is where we turn around\n";

      if ($in_even_hole) { $in_even_hole--; } # we're not really going to use this variable are we
      else { $in_even_hole++; }

      # these become the worst named variables ever at this point
      $last_even_guess = -1;
      $last_odd_guess = $number_of_holes + 1;
      next;
    }
  } else {
    # even number of holes
    if ($number_of_peeks && $guess == -1) {
      # we're done with the first pass, and if we got here, our assumption about the rabbit evenness is wrong
      print "Here is where we turn around\n";

      if ($in_even_hole) { $in_even_hole--; } # we're not really going to use this variable are we
      else { $in_even_hole++; }

      # these become the worst named variables ever at this point
      $last_even_guess = -1;
      $last_odd_guess = $number_of_holes + 1;
      next;
    }
  }

    

  if ($number_of_peeks >= $number_of_holes * 2) {
    print "We're past \$number_of_holes * 2 ...";
    <STDIN>;
  }

  $last_guess = $guess;

  if ($in_even_hole) { $in_even_hole--; }
  else { $in_even_hole++; }
  # </algorithm>






  print "Turn #", $number_of_peeks + 1, "; Let's peek in hole index ", $guess, "\n";
  #print Dumper $holes;
  $holes = peek($guess, $holes);
  print "\nHere's what the holes look like now after that peek:\n";
  print Dumper $holes;
  #<STDIN>;
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
  print "\n";

  return \@holes;
}


    #$guess = int($number_of_holes / 2);
    #unless ($guess % 2) { # guess is even
      #$guess--; # shift one to the right, make it odd
    #}
