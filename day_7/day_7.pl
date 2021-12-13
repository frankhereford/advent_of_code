#!/usr/bin/perl

use strict;
use Data::Dumper;

my @input = ();
open (my $input, '<', 'test_input');
#open (my $input, '<', 'input');
my $line = <$input>;
chomp $line;
close $input;

my @crabs = split(/,/, $line);

print join(",", @crabs), "\n";
