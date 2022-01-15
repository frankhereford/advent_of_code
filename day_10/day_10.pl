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

foreach my $line (@input) {
  print $line, "\n";
  my @chars = split(//, $line);
  my $illegal_char = find_first_illegal_char(\@chars);
}


sub find_first_illegal_char {
  my $line = shift;
  my @line = @$line;
  print Dumper \@line;
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