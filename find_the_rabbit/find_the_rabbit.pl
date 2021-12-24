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
my $recent_lookback_length = 3; # I'm not sure this can be changed without working more on the state printing routine

# state of the problem
my $number_of_peeks = 0;
my $holes = setup_holes($number_of_holes);
my @recent_even_guesses = (undef) x $recent_lookback_length;
my @recent_odd_guesses = (undef) x $recent_lookback_length;

#display_hole_state($holes);

# state of the algorithm
my $in_even_hole = 1;

my $last_guess = undef;
my $last_even_guess = undef;
my $last_odd_guess = undef;

while (1) {
  print color('green');
  print "\n---- New Turn ----\n";
  print color('reset');

  if ($number_of_peeks % 2) { print color('magenta'); } else { print color('yellow'); }
  print "Turn #", $number_of_peeks, "\n";
  print color('reset');

  display_hole_state($holes);
  print "\n";

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

  # observations on the fundemental flaws of the previous implementation:
  # * zero index everything, 5 holes is an *EVEN* number of holes.

  my $guess = undef;

  if ($number_of_peeks % 2) { 
      print color('magenta');
      print "Odd turn\n";
      print color('reset');
  } else {
      print color('yellow');
      print "Even turn\n";
      print color('reset');
  }

  if (! defined $last_guess) {
    $guess = 0;
  } else {
    $guess = $last_guess + 1;
  }


 

  if ($in_even_hole) { print color('yellow'); } else { print color('magenta'); }
  print "We currently believe the rabbit is in an ", $in_even_hole ? 'even' : 'odd', " hole.\n";
  print color('reset');


  if ($number_of_peeks >= $number_of_holes * 2) {
    print color('red');
    print "We're past \$number_of_holes * 2 ...";
    print color('reset');
    <STDIN>;
  }


  if ($guess == $number_of_holes) {
    print color('red');
    print "\nTurn around!\n";
    print "Take a random, pot-shot guess to toggle rabbit parity.\n";
    print color('reset');

    my $pot_shot_guess = int(rand($number_of_holes));

    if ($pot_shot_guess % 2) { print color('magenta'); } else { print color('yellow'); }
    print "Lets randomly peek in hole index ", $pot_shot_guess, ".\n";
    print color('reset');

    $holes = peek($pot_shot_guess, $holes);


    print color('red');
    print "Reset guess to index 0.\n\n";
    print color('reset');

    display_hole_state($holes);

    $guess = 0;
  }

  $last_guess = $guess;

  if ($in_even_hole) { $in_even_hole--; }
  else { $in_even_hole++; }
  # </algorithm>


  if ($guess % 2) { print color('magenta'); } else { print color('yellow'); }
  print "Lets peek in hole index ", $guess, ".\n";
  print color('reset');
  $holes = peek($guess, $holes);
  <STDIN>;
}

sub peek {
  my $guess = shift;
  my $holes = shift;

  if ($guess % 2) { 
    # odd peek_number
    unshift @recent_odd_guesses, $guess;
    pop @recent_odd_guesses;
  } else {
    # even peek number
    unshift @recent_even_guesses, $guess;
    pop @recent_even_guesses;
  }

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
      print "The rabbit was in hole index ", $x, ". It now moves.\n";
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

sub display_hole_state {
  my $holes = shift;
  print color('cyan');
  print "\nHere's the state of the holes:\n";
  print color('reset');
  for (my $x; $x < scalar(@$holes); $x++) {
    if ($holes->[$x]) {
      print '🐰';
    }
    else {
      print '🕳️ ';
    }
    print ' ';
  }
  print "\n";
  for (my $x = 0; $x < $number_of_holes; $x++) {
    printf "%02d ", $x;
  }
  print "\n";
  my @recent_guesses = ('  ') x $number_of_holes;
  #for (my $x; $x < scalar(@recent_even_guesses); $x++) {
  for (my $x = scalar(@recent_even_guesses) - 1; $x >= 0; $x--) {
    next unless defined($recent_even_guesses[$x]);
    if ($x == 0) {
      @recent_guesses[$recent_even_guesses[$x]] = color('yellow') . 'E ' . color('reset');
    } elsif ($x == 1) {
      @recent_guesses[$recent_even_guesses[$x]] = color('yellow') . 'e ' . color('reset');
    } else {
      @recent_guesses[$recent_even_guesses[$x]] = color('yellow') . '. ' . color('reset');
    }
  }
  #for (my $x; $x < scalar(@recent_odd_guesses); $x++) {
  for (my $x = scalar(@recent_odd_guesses) - 1; $x >= 0; $x--) {
    next unless defined($recent_odd_guesses[$x]);
    if ($x == 0) {
      @recent_guesses[$recent_odd_guesses[$x]] = color('magenta') . 'O ' . color('reset');
    } elsif ($x == 1) {
      @recent_guesses[$recent_odd_guesses[$x]] = color('magenta') . 'o ' . color('reset');
    } else {
      @recent_guesses[$recent_odd_guesses[$x]] = color('magenta') . '. ' . color('reset');
    }
  }
  print join(' ', @recent_guesses), "\n";
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
  
  return \@holes;
}
