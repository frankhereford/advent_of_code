#!/usr/bin/perl

use strict;
use Data::Dumper;

open (my $input, '<', 'input');

while (my $reading = <$input>) { 
  chomp $reading;
  print $reading, "\n";

  my $value = oct('0b' . $reading);
  print $value, "\n";

  my $inspect_bit = 0b1;
  for (my $bit = 0; $bit < 12; $bit++) {
    #printf("%012b\n", $inspect_bit);
    #$inspect_bit = $inspect_bit << 1;
    printf("%01b\n", get_bit($value, $bit));
  }

  exit;
  }

sub get_bit() {
  my $value = shift;
  my $bit = shift; # decimal digit's place
  my $mask = 2**$bit;
  return ($mask & $value) >> $bit;
}
