#!/usr/bin/perl

use strict;
use Data::Dumper;

open (my $input, '<', 'input');
my $increases = 0;

my @previous_window = ();
my @sliding_window = ();

while (my $reading = <$input>) {
  chomp $reading;
  last unless $reading > 0;
  push @sliding_window, $reading;
  shift @sliding_window if scalar(@sliding_window) > 3;
  next unless scalar(@sliding_window) == 3;
  unless (scalar(@previous_window) == 0) {
    $increases++ if sum_of_array(\@sliding_window) > sum_of_array(\@previous_window);

    print "Current sliding window: ", Dumper \@sliding_window;
    print "Sum of current window: ", sum_of_array(\@sliding_window), "\n";
    print "Increases: ", $increases, "\n";
  }

  @previous_window = @sliding_window;
  print "\n";
}

print $increases, "\n";

sub sum_of_array() {
  my $input = shift;
  return $input->[0] + $input->[1] + $input->[2];
}