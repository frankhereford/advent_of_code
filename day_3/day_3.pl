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


#printf("%01b\n", get_bit($value, $bit));


sub get_bit() {
  my $value = shift;
  my $bit = shift; # decimal digit's place
  my $mask = 2**$bit;
  return ($mask & $value) >> $bit;
}
