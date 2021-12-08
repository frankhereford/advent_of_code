#!/usr/bin/perl

use strict;
use Data::Dumper;

open (my $input, '<', 'input');

while (my $reading = <$input>) { 
  chomp $reading;
  print $reading, "\n";
  }