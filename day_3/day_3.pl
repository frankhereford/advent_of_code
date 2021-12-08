#!/usr/bin/perl

use strict;
use Data::Dumper;

my @values = ();
open (my $input, '<', 'input');
while (my $reading = <$input>) { 
  chomp $reading;
  my $value = oct('0b' . $reading);
  push @values, $value;
}
close $input;

my $gamma = 0;
my $epsilon = 0;
for (my $bit = 0; $bit < 12; $bit++) {
  my $zeros = 0;
  my $ones = 0;
  foreach my $value (@values) {
    #printf("%01b\n", get_bit($value, $bit));
    $zeros++ unless get_bit($value, $bit);
    $ones++ if get_bit($value, $bit);
  }
  print "Bit:   ", $bit, "\n";
  print "Zeros: ", $zeros, "\n";
  print "Ones:  ", $ones, "\n";
  print "\n";

  $gamma = ($gamma << 1) + ($ones > $zeros ? 1 : 0);
  $epsilon = ($epsilon << 1) + ($ones < $zeros ? 1 : 0);
}

print "Gamma: ", $gamma, "\n"; # Decimal
print "Epsilon: ", $epsilon, "\n"; # Decimal

print "Answer: ", $gamma * $epsilon, "\n";


sub get_bit() {
  my $value = shift;
  my $bit = shift; # decimal digit's place
  my $mask = 2**$bit;
  return ($mask & $value) >> $bit;
}
