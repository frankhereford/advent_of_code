#!/usr/bin/perl

use strict;
use FindBin;
use lib $FindBin::Bin;
use Data::Dumper;


my @input = ();
open (my $input, '<', 'test_input');
#open (my $input, '<', 'input');
while (my $line = <$input>) { 
  chomp $line;
  #print $line, "\n";
  push @input, $line;
}
close $input;


=cut
{([(<{}[<>[]}>{[]{[(<()>
{([(<[<>[]}>{[]{[(<()>
{([(<[[]}>{[]{[(<()>
{([(<[}>{[]{[(<()>
{([(<[}>{{[(<()>
{([(<[}>{{[(<>
{([(<[}>{{[(
      *
=cut 




exit;

foreach my $line (@input) {
  my $fail_char = parse_line($line);
  print $line, "\n";
  print "Fail char: ", $fail_char, "\n";
  print "\n";
}


sub parse_line {
  my $line = shift;

  print $line, "\n";

  my %seen = {};

  my @chars = split(//, $line);
  foreach my $char (@chars) {
    print $char, "\n";

    $seen{'()'}++ if $char eq '(';
    $seen{'[]'}++ if $char eq '[';
    $seen{'{}'}++ if $char eq '{';
    $seen{'<>'}++ if $char eq '<';

    $seen{'()'}-- if $char eq ')';
    $seen{'[]'}-- if $char eq ']';
    $seen{'{}'}-- if $char eq '}';
    $seen{'<>'}-- if $char eq '>';

    return '()' if $seen{'()'} < 0;
    return '[]' if $seen{'[]'} < 0;
    return '{}' if $seen{'{}'} < 0;
    return '<>' if $seen{'<>'} < 0;

    print Dumper \%seen;
    <>;
  }

  return \%seen;
}