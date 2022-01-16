#!/usr/bin/perl

use strict;
use FindBin;
use lib $FindBin::Bin;
use Term::ANSIColor;
use Data::Dumper;
use Cave;

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
  my $left_cave = create_and_or_return_cave($left_cave_name);
  my $right_cave = create_and_or_return_cave($right_cave_name);
  link_two_caves($left_cave, $right_cave);
}


#foreach my $connection (@{$caves->{'start'}->{'connections'}}) {
  #print $connection->{'name'}, "\n";
#}
#print "\n";

my @paths = [];

$paths = explore($caves->{'start'}, $paths);

print Dumper $paths;

sub explore {
  my $start = shift;
}

sub link_two_caves {
  my $first_cave = shift;
  my $second_cave = shift;

  $first_cave->add_connection($second_cave);
  $second_cave->add_connection($first_cave);

}

sub create_and_or_return_cave {
  my $cave_name = shift;
  return $caves->{$cave_name} if defined $caves->{$cave_name};
  $caves->{$cave_name} = Cave->new({ name => $cave_name });
  return $caves->{$cave_name};
}