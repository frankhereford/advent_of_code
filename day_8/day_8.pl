#!/usr/bin/perl

use strict;
use Data::Dumper;
use FindBin;
use lib $FindBin::Bin;
use Algorithm::Permute;

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
my $permutations = get_permutations();

foreach my $entry (@input) {

  $entry =~ /(.*) \| (.*)/;
  my $digits = $1;
  my $outputs = $2;

  my @displays = ();
  my @digits = split(/\s/, $digits);
  for (my $x = 0; $x < 9; $x++) {
    push @displays, SevenSegmentDisplay->new({
      input_code => $digits[$x],
    });
  }

  foreach my $permutation (@$permutations) {
    foreach my $display (@displays) {
      print join('', @$permutation), "\n";
      $display->parse_key($permutation);
      print Dumper $display;
      <>;
    }
  #last;
  }

  #print Dumper \@displays;

  exit;

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

sub get_permutations {
  my @segments = ('a', 'b', 'c', 'd', 'e', 'f', 'g');
  #print @segments, "\n";
  my $p = Algorithm::Permute->new(\@segments);
  my @permutations = ();
  while (my @res = $p->next) {
    #print join(", ", @res), "\n";
    push @permutations, \@res;
  }
return \@permutations;
}

