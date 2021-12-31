#!/usr/bin/perl

use strict;
use Data::Dumper;
use FindBin;
use lib $FindBin::Bin;

use SevenSegmentDisplay;

my @input = ();
open (my $input, '<', 'test_input');
#open (my $input, '<', 'input');
my $line = <$input>;
chomp $line;
close $input;

