#!/usr/bin/perl

use strict;
use Data::Dumper;

my @input = ();
open (my $input, '<', 'test_input');
while (my $line = <$input>) { 
  chomp $line;
  #print $line, "\n";
  push @input, $line;
}
close $input;

foreach my $input_line (@input) {
  $input_line =~ /(\d+),(\d+) -> (\d+),(\d+)/;
  my $line = [$1, $2, $3, $4];
  next unless ($line->[0] == $line->[2] || $line->[1] == $line->[3]);
  print $input_line, "\n";
  #print Dumper $line;
}
