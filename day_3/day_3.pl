#!/usr/bin/perl

use strict;
use Data::Dumper;

my @values = ();
my $number_digits = 0;
open (my $input, '<', 'test_input');
while (my $reading = <$input>) { 
  chomp $reading;
  $number_digits = length($reading);
  my $value = oct('0b' . $reading);
  push @values, $value;
}
close $input;

$number_digits--; # zero indexed binary little endian values

print "Number of digits: ", $number_digits, "\n";

my @selected_values = ();






exit;

my $gamma = 0;
my $epsilon = 0;
for (my $bit = 4; $bit > -1; $bit--) { # zero indexed bit little endian
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
