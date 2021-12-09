#!/usr/bin/perl

use strict;
use Data::Dumper;

my @input = ();
open (my $input, '<', 'test_input');
while (my $line = <$input>) { 
  chomp $line;
  print $line, "\n";
  push @input, $line;
}

close $input;

my $bingo_calls = shift @input;
print $bingo_calls, "\n";
my @bingo_calls = split(/,/, $bingo_calls);
print Dumper \@bingo_calls;