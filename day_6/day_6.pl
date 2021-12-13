#!/usr/bin/perl

use strict;
use Data::Dumper;

my @input = ();
#open (my $input, '<', 'test_input');
open (my $input, '<', 'input');
my $line = <$input>;
chomp $line;
close $input;

my @fish = split(/,/, $line);

#print Dumper \@fish;
my $day = 0;
while (1) {
  $day++;
  my @new_fish = ();
  for (my $index = 0; $index < scalar(@fish); $index++) {
    #print $fish[$index], "\n";
    if (!$fish[$index]) {
      push(@new_fish, 8);
      $fish[$index] = 6;
    }
    else {
      $fish[$index]--;
    }
  }

  push(@fish, @new_fish);

  print "Day ", $day, "\n";
  #for (my $index = 0; $index < scalar(@fish); $index++) { print $index, ": ", $fish[$index], "\n"; }
  print join(",", @fish), "\n";
  print scalar(@fish), "\n";
  print "\n";

  if ($day == 18 || $day == 80) { <>; }
}