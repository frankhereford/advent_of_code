#!/usr/bin/perl

use strict;
use FindBin;
use lib $FindBin::Bin;
use Data::Dumper;


my @input = ();
open (my $input, '<', 'test_input');
#open (my $input, '<', 'input');
while (my $line = <$input>) { 
  chomp $line;
  #print $line, "\n";
  push @input, $line;
}
close $input;

for (my $x = 0; $x < scalar(@input); $x++) {
  my @heights = split(//, $input[$x]);
  for (my $y = 0; $y < scalar(@heights); $y++) {
    #print $x, ' x ', $y, "\n";
  }
}