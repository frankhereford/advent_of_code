#!/usr/bin/perl

use strict;

my @search_lengths = ();

for (my $x = 0; $x < 10000; $x++) {
  open (my $finder, "-|", "./find_the_rabbit.pl --holes 100");
    while (my $line = <$finder>) {
      #print "'$line'\n";
      next unless ($line =~ /\d/i);
      chomp $line;
      $line =~ /(\d+) peeks/;
      my $search_length = $1;
      print $search_length, "\n";
      #chomp $search_length;
      #push @search_lengths, $1;
    }
    close $finder;
  }

#print Dumper \@search_lengths;
