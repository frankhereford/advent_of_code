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

# the trick to this is going to be to track the even-ness of the presumed location of the rabbit, 
# because that value will toggle back and forth on every failed peek

my $holes = setup_holes(3);
print Dumper $holes;

sub setup_holes {
  my $number_of_holes = shift;

  print "Solving for ", $number_of_holes, " holes.\n";

  my @holes = ();
  for (my $x = 0; $x < $number_of_holes; $x++) {
    $holes[$x] = 0;
  }

  my $hole_with_rabbit = int(rand($number_of_holes));
  $holes[$hole_with_rabbit] = 1;

  return \@holes;
}