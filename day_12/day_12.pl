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

  print "\n\n";

  print "Left cave name: ", $left_cave_name, "\n";
  print "Right cave name: ", $right_cave_name, "\n";

  print "\n";
  print "Pre-add state of caves:\n";
  print Dumper $caves;
  print "\n";

  #print "Adding: \n";

  my $left_cave = create_and_or_return_cave($left_cave_name);
  my $right_cave = create_and_or_return_cave($right_cave_name);

  print "Here's left cave: \n";
  print Dumper $left_cave;

  print "Here's right cave: \n";
  print Dumper $right_cave;

  link_two_caves($left_cave, $right_cave);

  print Dumper $caves;
  print "\n";

<>;
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