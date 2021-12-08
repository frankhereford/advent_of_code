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
    printf("%012b\n", $inspect_bit);
    $inspect_bit = $inspect_bit << 1;
  }

  exit;
  }