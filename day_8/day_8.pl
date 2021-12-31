#!/usr/bin/perl

use strict;
use Data::Dumper;
use FindBin;
use lib $FindBin::Bin;
use Algorithm::Permute;

use SevenSegmentDisplay;

my @input = ();
#open (my $input, '<', 'test_input');
open (my $input, '<', 'input');
while (my $line = <$input>) { 
  chomp $line;
  #print $line, "\n";
  push @input, $line;
}
close $input;

my $appearences = 0;
my @output_digits = ();
my $permutations = get_permutations();

my $total_total = 0;

foreach my $entry (@input) {

  $entry =~ /(.*) \| (.*)/;
  my $digits = $1;
  my $outputs = $2;

  my @displays = ();
  my @digits = split(/\s/, $digits);
  for (my $x = 0; $x <= 9; $x++) {
    push @displays, SevenSegmentDisplay->new({
      input_code => $digits[$x],
    });
  }

  foreach my $permutation (@$permutations) {
    my $valids = 0;
    foreach my $display (@displays) {
      $display->parse_key($permutation);
      #print Dumper $display;
      #print Dumper $display->{'intended'};
      #print "Intended code: ", $display->_get_intended_code, "\n";
      my $is_valid = $display->is_intended_valid;
      #print "is valid?: ", $is_valid, "\n";
      $valids += $is_valid;
    }

    if ($valids == 10) {
      #print "Valids: ", $valids, "\n";
      print join('', @$permutation), "\n";

      my $number = '';
      my @answer_digits = split(/\s/, $outputs);
      foreach my $digit (@answer_digits) {
        my $ssd = SevenSegmentDisplay->new({
          input_code => $digit,
        });
        $ssd->parse_key($permutation);
        #print $ssd->get_indended_digit;
        $number = $number . $ssd->get_indended_digit;
      }
      my $int = int($number);
      print "Yes!: ", $int, "\n";
      $total_total += $int;
    }
  }
}

print $total_total, " is the big total.\n";

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

