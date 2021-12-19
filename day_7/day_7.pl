#!/usr/bin/perl

use strict;
use Data::Dumper;

my @input = ();
open (my $input, '<', 'test_input');
#open (my $input, '<', 'input');
my $line = <$input>;
chomp $line;
close $input;

my @crabs = split(/,/, $line);

print join(",", @crabs), "\n";

my $smallest_crab = undef;
my $largest_crab = undef; 
foreach my $crab (@crabs) {
  $smallest_crab = $crab if $smallest_crab == undef;
  $largest_crab = $crab if $largest_crab == undef;
  $smallest_crab = $crab if $crab < $smallest_crab;
  $largest_crab = $crab if $crab > $largest_crab;
}

print "Smallest Crab: ", $smallest_crab, "\n";
print "Largest Crab: ", $largest_crab, "\n";