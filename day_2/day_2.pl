#!/usr/bin/perl

use strict;
use Data::Dumper;

open (my $input, '<', 'input');

my $horizontal_position = 0;
my $depth = 0;

while (my $command = <$input>) { 
  chomp $command;
  last unless $command =~ /(\w+) (\d+)/;

  my $direction = $1;
  my $scalar = $2;

  print $direction, ": ", $scalar, "\n";

  if ($direction =~ /^(up|down)$/) {
    $depth -= $scalar if ($direction eq 'up');
    $depth += $scalar if ($direction eq 'down');
  }

  $horizontal_position += $scalar if $direction eq 'forward';

  print "Horizontal Position: ", $horizontal_position, "\n";
  print "Depth: ", $depth, "\n";
  print "\n";
}

print "Answer: ", $horizontal_position * $depth, "\n";
 