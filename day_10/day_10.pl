#!/usr/bin/perl

use strict;
use FindBin;
use lib $FindBin::Bin;
use Data::Dumper;


my @input = ();
open (my $input, '<', 'micro_test_input');
#open (my $input, '<', 'input');
while (my $line = <$input>) { 
  chomp $line;
  #print $line, "\n";
  push @input, $line;
}
close $input;

foreach my $line (@input) {
  #print $line, "\n";
  my @chars = split(//, $line);
  my $illegal_char = find_first_illegal_char(\@chars);
  print "Illegal char: ", $illegal_char, "\n";
  print "\n\n";
}

sub find_first_illegal_char {
  my $line = shift;
  my @line = @$line;

  print join('', @line), "\n";

  for (my $x = 0; $x < scalar(@line); $x++) {
    #print "X: ", $x, "\n";
    if (is_matching_pair($line[$x], $line[$x + 1])) {
      #print "Found one!\n";
      splice(@line, $x, 2);
      print join('', @line), "\n";
      $x = 0; # resetting the fore loop!
    }
  }

  if (join('', @line) =~ /[\)\]}>]/) { # that is an ugly regex!
    #print "Currupt!\n";
    return find_first_closing_tag(\@line);
  } else {
    #print "Incomplete!\n";
    return undef;
  }

}

sub find_first_closing_tag {
  my $line = shift;
  my @line = @$line;
  for (my $x = 0; $x < scalar(@line); $x++) {
    return $line[$x] if $line[$x] =~ /[\)\]}>]/;
  }
}

sub is_matching_pair {
  my $alpha = shift;
  my $beta = shift;
  #print "alpha: ", $alpha, "\n";
  #print "beta: ", $beta, "\n";
  return 1 if $alpha eq '(' and $beta eq ')';
  return 1 if $alpha eq '[' and $beta eq ']';
  return 1 if $alpha eq '{' and $beta eq '}';
  return 1 if $alpha eq '<' and $beta eq '>';
  return 0;
}

# working left to right, eliminate adjacent open-close pairs
# if you have to get to a close tag that isn't part of an adjacent open-close pair,
# then you have found a currupted pair.

# incomplete ones boil down to just open tags

# complete ones boil down to nothing

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

=cut
[[<[([]))<([[{}[[()]]]
[[<[())<([[{}[[()]]]
[[<[)<([[{}[[()]]]
[[<[)<([[{}[[()]]]
    *
=cut

=cut
[{[{({}]{}}([{[{{{}}([]
[{[{(]{}}([{[{{{}}([]
     *
=cut

=cut
[<(<(<(<{}))><([]([]()
[<(<(<(<))><([]([]()
=cut

#<{([([[(<>()){}]>(<<{{
#<{([([[(()){}]>(<<{{
#<{([([[(){}]>(<<{{
#<{([([[{}]>(<<{{
#<{([([[]>(<<{{
#<{([([>(<<{{
#<{([([>(<<{{


=cut
# incomplete one

[({(<(())[]>[[{[]{<()<>>
[({(<()[]>[[{[]{<()<>>
[({(<[]>[[{[]{<()<>>
[({(<>[[{[]{<()<>>
[({([[{[]{<()<>>
[({([[{{<()<>>
[({([[{{<<>>
[({([[{{<>
[({([[{{

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