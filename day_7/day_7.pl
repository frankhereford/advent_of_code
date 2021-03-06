#!/usr/bin/perl

use strict;
use Data::Dumper;

my @input = ();
#open (my $input, '<', 'test_input');
open (my $input, '<', 'input');
my $line = <$input>;
chomp $line;
close $input;

my @crabs = split(/,/, $line);

print join(",", @crabs), "\n";

my $smallest_crab = undef;
my $largest_crab = undef; 
foreach my $crab (@crabs) {
  #print "Crab: ", $crab, "\n";
  $smallest_crab = $crab if !defined($smallest_crab);
  $largest_crab = $crab if !defined($largest_crab);
  $smallest_crab = $crab if $crab < $smallest_crab;
  $largest_crab = $crab if $crab > $largest_crab;
  #print "SC: ", $smallest_crab, "\n";
  #print "\n";
}

print "Smallest Crab: ", $smallest_crab, "\n";
print "Largest Crab: ", $largest_crab, "\n";

print "\n";

my $results = {};
for (my $x = $smallest_crab; $x <= $largest_crab; $x++) {
  #print "Trying X: ", $x, "\n";
  my $fuel_used = 0;
  foreach my $crab (@crabs) {
    $fuel_used += calc_fuel($crab, $x);
  }
  print "For X = ", $x, ", Fuel Used: ", $fuel_used, "\n";
  $results->{$x} = $fuel_used;
}

sub calc_fuel {
  my $start = shift;
  my $end = shift;
  my $delta = abs($start - $end);
  my $total_fuel = 0;
  for (my $x = 1; $x <= $delta; $x++) {
    $total_fuel += $x;
  }
  return $total_fuel;
}

print "\n";

#print Dumper $results;

my %results = %{$results};

for my $key ( sort { $results{$b} <=> $results{$a} } keys %results) {
    print join( "\t", $key, $results{$key} ), "\n";
}