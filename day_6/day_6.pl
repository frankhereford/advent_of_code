#!/usr/bin/perl

use strict;
use Data::Dumper;
use Storable qw(dclone);

my @input = ();
#open (my $input, '<', 'test_input');
open (my $input, '<', 'input');
my $line = <$input>;
chomp $line;
close $input;

my @fish = split(/,/, $line);

my @school = ();
foreach my $fish (@fish) {
  #print $fish, "\n";
  $school[$fish]++;
}

#print Dumper \@school;

my $day = 0;
while (1) {
  $day++;
  print "Day ", $day, "\n";
  my @new_school = ();
  for (my $ttl = 0; $ttl <= 8; $ttl++) { 
    if ($ttl == 0) {
      $new_school[6] += $school[$ttl] ? $school[$ttl] : 0;
      $new_school[8] += $school[$ttl] ? $school[$ttl] : 0;
    } else {
      $new_school[$ttl - 1] += $school[$ttl] ? $school[$ttl] : 0;
    }
  }

  @school = @{ dclone(\@new_school) };
  #@school = @new_school;


  my $day_sum = 0;
  foreach my $population_slice (@school) {
    $day_sum += $population_slice;
  }
  print "\n";
  print Dumper \@school;
  print "Day Sum: ", $day_sum, "\n";
  if ($day == 256) { <>; }
  print "\n\n";
  #<>;
}



exit;

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
  #print join(",", @fish), "\n";
  print scalar(@fish), "\n";
  print "\n";

  #if ($day == 18 || $day == 80) { <>; }
  if ($day == 256) { <>; }
}