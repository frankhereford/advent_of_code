#!/usr/bin/perl

use strict;
use Data::Dumper;

my @input = ();
open (my $input, '<', 'test_input');
while (my $line = <$input>) { 
  chomp $line;
  push @input, $line;
}
close $input;

