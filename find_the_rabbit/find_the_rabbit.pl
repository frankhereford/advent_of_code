#!/usr/bin/perl

use strict;
use Data::Dumper;
use Term::ANSIColor;

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
  print color('green');
  print "\n---- New Turn ----\n\n";
  print color('reset');

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


  if ($in_even_hole) { print color('yellow'); } else { print color('magenta'); }
  print "We currently believe the rabbit is in an ", $in_even_hole ? 'even' : 'odd', " hole.\n";
  print color('reset');

  my $guess = 41;

  if (!$number_of_peeks) { # initial guess
    print color('yellow');
    print "Initial even turn, track from the left\n";
    print color('reset');
  } elsif ($number_of_peeks == 1) { 
    print color('magenta');
    print "Initial odd turn, track from the right\n";
    print color('reset');
  } else { # not initial guess
    if ($number_of_peeks % 2) { 
      print color('magenta');
      print "Non-initial odd turn\n";
      print color('reset');
    } else { 
      print color('yellow');
      print "Non-initial even turn\n";
      print color('reset');
    }
  }



  if ($number_of_peeks >= $number_of_holes * 2) {
    print color('red');
    print "We're past \$number_of_holes * 2 ...";
    print color('reset');
    <STDIN>;
  }

  $last_guess = $guess;

  if ($in_even_hole) { $in_even_hole--; }
  else { $in_even_hole++; }
  # </algorithm>






  if ($number_of_peeks) { print color('magenta'); } else { print color('yellow'); }
  print "Turn #", $number_of_peeks, "\n";
  print color('reset');

  if ($guess % 2) { print color('magenta'); } else { print color('yellow'); }
  print "Lets peek in hole index ", $guess, ".\n";
  #print Dumper $holes;
  $holes = peek($guess, $holes);
  print color('cyan');
  print "\nHere's what the holes look like now after that peek:\n";
  print Dumper $holes;
  print color('reset');
  <STDIN>;
}


sub peek {
  my $guess = shift;
  my $holes = shift;
  $number_of_peeks++;
  if ($holes->[$guess]) {
    print color('green');
    print "You found the rabbit in hole index number ", $guess, " in ", $number_of_peeks, " peeks.\n";
    print color('reset');
    exit;
  }
  for (my $x = 0; $x < $number_of_holes; $x++) {
    if ($holes->[$x]) {
      if ($x % 2) { print color('magenta'); } else { print color('yellow'); }
      print "The rabbit was in hole index ", $x, ".\n";
      print color('reset');
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

  if ($number_of_holes) { print color('yellow'); } else { print color('magenta'); }
  print "Solving for ", $number_of_holes - 1, " holes, zero indexed.\n";
  print color('reset');

  my @holes = ();
  for (my $x = 0; $x < $number_of_holes; $x++) {
    $holes[$x] = 0;
  }

  my $hole_with_rabbit = int(rand($number_of_holes));
  $holes[$hole_with_rabbit] = 1;
  
  print color('cyan');
  print "Initial state of holes:\n";
  print Dumper \@holes;
  print "\n";
  print color('reset');

  return \@holes;
}


    #$guess = int($number_of_holes / 2);
    #unless ($guess % 2) { # guess is even
      #$guess--; # shift one to the right, make it odd
    #}
