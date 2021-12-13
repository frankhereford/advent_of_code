#!/usr/bin/perl

use strict;
use Data::Dumper;

my @input = ();
open (my $input, '<', 'input');
while (my $line = <$input>) { 
  chomp $line;
  #print $line, "\n";
  push @input, $line;
}
close $input;
