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

my $floor = [];

foreach my $input_line (@input) {
  $input_line =~ /(\d+),(\d+) -> (\d+),(\d+)/;
  my $line = [$1, $2, $3, $4];
  next unless ($line->[0] == $line->[2] || $line->[1] == $line->[3]); # horizontal lines only
  print $input_line, "\n";
  #print Dumper $line;

  if ($line->[0] == $line->[2]) { # x value is the same
    my $small_y = $line->[1] < $line->[3] ? $line->[1] : $line->[3];
    my $big_y   = $line->[1] > $line->[3] ? $line->[1] : $line->[3];
    print "Small Y: ", $small_y, "; Big Y: ", $big_y, "\n";

    for (my $y = $small_y; $y <= $big_y; $y++) {
      $floor->[$line->[0]]->[$y]++;
    }
  }

  if ($line->[1] == $line->[3]) { # x value is the same
    my $small_x = $line->[0] < $line->[2] ? $line->[0] : $line->[2];
    my $big_x   = $line->[0] > $line->[2] ? $line->[0] : $line->[2];
    print "Small X: ", $small_x, "; Big X: ", $big_x, "\n";

    for (my $x = $small_x; $x <= $big_x; $x++) {
      $floor->[$x]->[$line->[1]]++;
    }
  }
}

print Dumper $floor, "\n";