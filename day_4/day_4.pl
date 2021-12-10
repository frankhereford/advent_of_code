#!/usr/bin/perl

use strict;
use Data::Dumper;

my $board_ranks = 5;
my $board_files = 5;

my @input = ();
open (my $input, '<', 'test_input');
while (my $line = <$input>) { 
  chomp $line;
  #print $line, "\n";
  push @input, $line;
}

close $input;

my $bingo_calls = shift @input;
my @bingo_calls = split(/,/, $bingo_calls);
#print Dumper \@bingo_calls;

#print Dumper \@input;

shift @input;

my @boards = (&pop_board_off_input(\@input));

for (my $rank = 0; $rank <= $board_ranks; $rank++) { shift @input; } # fast forward one board

while (1) {
  my $board = &pop_board_off_input(\@input);
  last unless $board;
  for (my $rank = 0; $rank <= $board_ranks; $rank++) { shift @input; } # fast forward one board
  #print Dumper $board;
  push @boards, $board;
}

print Dumper \@boards;

sub pop_board_off_input {
  my $input = shift;
  my @input = @$input;
  my $board = [[], [], [], [], []];
  for (my $rank = 0; $rank < $board_ranks; $rank++) {
    my $rank_values = shift(@input);
    $rank_values =~ s/^\s+(\d)/$1/;
    my @rank_values = split(/\s+/, $rank_values);
    #print Dumper \@rank_values;
    for (my $file = 0; $file < $board_files; $file++) {
      #next unless $rank_values[$file];
      #print int($rank_values[$file]), "!\n";
      $board->[$rank]->[$file] = {
        value => int($rank_values[$file]),
        found => 0,
      };
    }
  }

#print Dumper $board;

  my $board_ok = 1;
  my $zero_count = 0;
  for (my $rank = 0; $rank < $board_ranks; $rank++) {
    for (my $file = 0; $file < $board_files; $file++) {
      my $value = $board->[$rank]->[$file]->{'value'};
      $zero_count++ unless $value;
      $board_ok = 0 unless $value =~ /\d+/;
    }
  }

  #print "\n";
  #print "Zero count: ", $zero_count, "\n";
  #print $board_ranks * $board_files, "\n";
  return undef if $zero_count == $board_ranks * $board_files;
  return $board if $board_ok;
  return undef;

}