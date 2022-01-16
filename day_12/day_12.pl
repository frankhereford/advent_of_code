#!/usr/bin/perl

use strict;
use FindBin;
use lib $FindBin::Bin;
use Term::ANSIColor;
use Data::Dumper;

my @input = ();
open (my $input, '<', 'micro_test_input');
while (my $line = <$input>) { 
  chomp $line;
  #print $line, "\n";
  push @input, $line;
}
close $input;

my $caves = {};

foreach my $input (@input) {
  $input =~ /(\w+)-(\w+)/;
  my $left_cave_name = $1;
  my $right_cave_name = $2;

  print $left_cave_name, "\n";

  my $left_cave = create_and_or_return_cave($left_cave_name);
  my $right_cave = create_and_or_return_cave($right_cave_name);

}

print Dumper $caves;

sub link_two_caves {

}


sub create_and_or_return_cave {
  my $cave_name = shift;
  return $caves->{$cave_name} if defined $caves->{$cave_name};
  $caves->{$cave_name} = {
    'is_large' => uc($cave_name) eq $cave_name ? 1 : 0,
    'connections' => [],
  };
  return $caves->{$cave_name};
}