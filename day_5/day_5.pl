#!/usr/bin/perl

use strict;
use Data::Dumper;

my @input = ();
#open (my $input, '<', 'test_input');
open (my $input, '<', 'input');
while (my $line = <$input>) { 
  chomp $line;
  #print $line, "\n";
  push @input, $line;
}
close $input;

my $floor = [];

my $largest_x = 0;
my $largest_y = 0;

foreach my $input_line (@input) {
  $input_line =~ /(\d+),(\d+) -> (\d+),(\d+)/;
  my $line = [$1, $2, $3, $4];
  #next unless ($line->[0] == $line->[2] || $line->[1] == $line->[3]); # horizontal or vertical lines only
  #print $input_line, "\n";
  #print Dumper $line;

  if ($line->[0] == $line->[2]) { # x value is the same
    my $small_y = $line->[1] < $line->[3] ? $line->[1] : $line->[3];
    my $big_y   = $line->[1] > $line->[3] ? $line->[1] : $line->[3];
    #print "Small Y: ", $small_y, "; Big Y: ", $big_y, "\n";
    $largest_x = $line->[0] if $line->[0] > $largest_x;
    $largest_y = $big_y if $big_y > $largest_y;

    for (my $y = $small_y; $y <= $big_y; $y++) {
      $floor->[$line->[0]]->[$y]++;
    }
  } elsif ($line->[1] == $line->[3]) { # y value is the same
    my $small_x = $line->[0] < $line->[2] ? $line->[0] : $line->[2];
    my $big_x   = $line->[0] > $line->[2] ? $line->[0] : $line->[2];
    #print "Small X: ", $small_x, "; Big X: ", $big_x, "\n";
    $largest_x = $big_x if ($big_x > $largest_x);
    $largest_y = $line->[1] if $line->[1] > $largest_y;

    for (my $x = $small_x; $x <= $big_x; $x++) {
      $floor->[$x]->[$line->[1]]++;
    }
  } else {
    my $slope = ($line->[3] - $line->[1]) / ($line->[2] - $line->[0]);
    print "Slope: ", $slope, "\n";
    print $line->[0], ", ", $line->[1], " => ", $line->[2], ", ", $line->[3], "\n";

    my $small_x = 0;
    my $big_x = 0;
    my $initial_y = 0;
    if ($line->[0] < $line->[2]) {
      $small_x = $line->[0];
      $big_x = $line->[2];
      $initial_y = $line->[1];
    } else {
      $small_x = $line->[2];
      $big_x = $line->[0];
      $initial_y = $line->[3];
    }
    print "Small X: ", $small_x, "\n";
    print "Big X: ", $big_x, "\n";
    if ($slope == 1) { # lines that look like this: / 
      for (my $x = $small_x; $x <= $big_x; $x++) {
        print "Point: ", $x, ", ", $initial_y, "\n";
        $floor->[$x]->[$initial_y]++;
        $initial_y++;
      }
    } else { # lines that look like this: \
      for (my $x = $small_x; $x <= $big_x; $x++) {
        print "Point: ", $x, ", ", $initial_y, "\n";
        $floor->[$x]->[$initial_y]++;
        $initial_y--;
      }
    }
  }
  print "\n";
}

print "Largest X: ", $largest_x, "; Largest Y: ", $largest_y, "\n";

my $scary_vents = 0;
for (my $x = 0; $x <= $largest_x; $x++) {
  for (my $y = 0; $y <= $largest_y; $y++) {
    $scary_vents++ if $floor->[$x]->[$y] >= 2;
  }
}

#print Dumper $floor, "\n";

print "Scary Vents: ", $scary_vents, "\n";
