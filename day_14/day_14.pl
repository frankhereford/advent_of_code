#!/usr/bin/perl

use strict;
use FindBin;
use lib $FindBin::Bin;
use Term::ANSIColor;
use Data::Dumper;

my @input = ();
open (my $input, '<', 'test_input');
while (my $line = <$input>) { 
  chomp $line;
  #print $line, "\n";
  push @input, $line;
}
close $input;

my $polymer = shift(@input);
shift(@input);

my %pairs = ();

for (my $x = 0; $x < length($polymer) - 1; $x++) {
  my $operating_pair = substr($polymer, $x, 2);
  #print $operating_pair, "\n";
  $pairs{$operating_pair}++;
  }

for (my $step = 0; $step < 40; $step++) {
  my %created_pairs = ();

  foreach my $operation (@input) {
    $operation =~ /(\w\w) -> (\w)/;
    my $pair = $1;
    my $addition = $2;

    my $left = substr($pair, 0, 1);
    my $right = substr($pair, 1, 1);

    if ($pairs{$pair}) {
      $created_pairs{$left . $addition} += $pairs{$pair};
      $created_pairs{$addition . $right} += $pairs{$pair};
    }
    delete $pairs{$pair};
  }


  foreach my $pair (keys(%created_pairs)) {
    $pairs{$pair} = $created_pairs{$pair};
  }

  print Dumper \%pairs;
  #print Dumper \%created_pairs;

  #<>;
}

#print 
#$pairs{'BB'} +
#$pairs{'BN'} +
#$pairs{'BH'} +
#$pairs{'BC'} , "\n";

my %letters = ();

foreach my $pair (keys(%pairs)) {
  my $letter = substr($pair, 0, 1);
  $letters{$letter} += $pairs{$pair};
}

my $most_common_scalar = 0;
my $least_common_scalar = 999999999999999;
my $most_common_letter = '';
my $least_common_letter = '';

foreach my $letter (keys(%letters)) {
  if ($most_common_scalar < $letters{$letter}) {
    $most_common_scalar = $letters{$letter};
    $most_common_letter = $letter;
  }
  if ($least_common_scalar > $letters{$letter}) {
    $least_common_scalar = $letters{$letter};
    $least_common_letter = $letter;
  }
}

print Dumper \%letters;

my $answer = $most_common_scalar - $least_common_scalar;
print $answer, "\n";
exit;

for (my $step = 0; $step < 40; $step++) {
  for (my $x = 0; $x < length($polymer) - 1; $x++) {
    my $operating_pair = substr($polymer, $x, 2);
    #print $operating_pair, "\n";
    foreach my $operation (@input) {
      $operation =~ /(\w\w) -> (\w)/;
      my $pair = $1;
      my $addition = $2;
      if ($pair eq $operating_pair) {
        #print "Match!\n";
        substr($polymer, $x + 1, 0, $addition) if $pair eq $operating_pair;
        $x++;
        last;
      }
    }
  }
  #print "Step #", $step, ": ", $polymer, "\n";
  print "Step #", $step, ": ", length($polymer), "\n";
}

my @letters = split(//, $polymer);
my %letters = ();
foreach my $letter (@letters) {
  $letters{$letter}++;
}

print Dumper \%letters;
my $most_common_scalar = 0;
my $least_common_scalar = 999999999999999;
my $most_common_letter = '';
my $least_common_letter = '';

foreach my $letter (keys(%letters)) {
  if ($most_common_scalar < $letters{$letter}) {
    $most_common_scalar = $letters{$letter};
    $most_common_letter = $letter;
  }
  if ($least_common_scalar > $letters{$letter}) {
    $least_common_scalar = $letters{$letter};
    $least_common_letter = $letter;
  }
}

my $answer = $most_common_scalar - $least_common_scalar;
print $answer, "\n";