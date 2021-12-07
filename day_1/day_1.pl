#!/usr/bin/perl

use strict;

open (my $input, '<', 'input');
my $previous_reading = undef;
my $increases = 0;
while (my $reading = <$input>) {
  chomp $reading;
  $increases++ if $previous_reading && $reading > $previous_reading;
  $previous_reading = $reading;
}

print $increases, "\n";