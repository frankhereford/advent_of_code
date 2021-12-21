#!/usr/bin/perl

use strict;

=cut
https://youtu.be/XEt09iK8IXs?t=1266

* There are 100 holes in a line, and there is a rabbit in one of the holes
* You can only look in one hole at a time, and every time you look, the rabbit jumps to an adjacent hole
* Better solutions does the task with the best O. 
* Bonus points for discovering the worst case senario in terms of hole-peeks for 100 holes.
=cut

sub find_the_rabbit {
  my $number_of_holes = shift;
  # the trick to this is going to be to track the even-ness of the presumed location of the rabbit, 
  # because that value will toggle back and forth on every failed peek


}