#!/usr/bin/perl

use strict;
use Data::Dumper;
use FindBin;
use lib $FindBin::Bin;
#use Algorithm::Permute;

use SevenSegmentDisplay;

my @input = ();
open (my $input, '<', 'test_input');
#open (my $input, '<', 'input');
while (my $line = <$input>) { 
  chomp $line;
  #print $line, "\n";
  push @input, $line;
}
close $input;

my $appearences = 0;

my @output_digits = ();

foreach my $entry (@input) {
  $entry =~ /(.*) \| (.*)/;
  my $digits = $1;
  my $outputs = $2;
  my @outputs = split(/\s/, $outputs);
  foreach my $output_digit (@outputs) {
    #print $output_digit, "\n";

    push @output_digits, SevenSegmentDisplay->new({
      input_code => $output_digit,
    });

    my $length = length($output_digit);
    if      ($length == 2) { # digit 1
      $appearences++;
    } elsif ($length == 4) { # digit 4
      $appearences++;
    } elsif ($length == 3) { # digit 7
      $appearences++;
    } elsif ($length == 7) { # digit 8
      $appearences++;
    }
  }
}

my @configuration = ('a', 'b', 'c', 'd', 'e', 'f', 'g');
my @permutations = ();
