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

my @paths = (); # global to hold paths upon end point finding

my $path = [];

explore($caves->{'start'}, $path, 0);

print Dumper \@paths;

sub explore {
  my $here = shift;
  my $path = shift;
  my $depth = shift;

  $depth++;
  my @path = @$path; # we're making a copy of this to hand on
  push @path, $here->{'name'};


  print "Depth: ", $depth, "; In: ", $here->{'name'}, "\n";

  print "Path so far:\n";
  print Dumper \@path;

  $here->{'been_visited'}++;

  my $valid_next_moves = $here->get_valid_next_moves(\@path);

  if (!scalar(@$valid_next_moves) or $here->{'name'} eq 'end') {
    print "End of path\n";
    return; # return something to inform recursion to run up the stack
  }
 
  foreach my $there (@{$valid_next_moves}) {
    #print "Exploring to: ", $here->{'name'}, "\n";
    explore($there, \@path, $depth); # look for the run up the stack result
  }

  return $path;
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