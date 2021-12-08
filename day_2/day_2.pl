#!/usr/bin/perl

use strict;
use Data::Dumper;

open (my $input, '<', 'input');

my $horizontal_position = 0;
my $depth = 0;
my $aim = 0;

while (my $command = <$input>) { 
  chomp $command;
  last unless $command =~ /(\w+) (\d+)/;

  my $direction = $1;
  my $scalar = $2;

  print "Command: ",  $direction, "→", $scalar, "\n";

  $aim += $scalar if $direction eq 'down';
  $aim -= $scalar if $direction eq 'up';

  if ($direction eq 'forward') {
    $horizontal_position += $scalar;
    $depth += $aim * $scalar;
    }

  print "Aim: ", $aim, "\n";
  print "Horizontal Position: ", $horizontal_position, "\n";
  print "Depth: ", $depth, "\n";
  print "\n";
}

print "Answer: ", $horizontal_position * $depth, "\n";
 