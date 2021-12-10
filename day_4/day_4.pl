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

my $got_board = 1;
while (1) {
  my $board = &pop_board_off_input(\@input);
  for (my $rank = 0; $rank <= $board_ranks; $rank++) { shift @input; } # fast forward one board
  last unless $board;
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
      print Dumper \@rank_values;
      #print $rank_values[$file], "!\n";
      $board->[$rank]->[$file] = $rank_values[$file];
    }
  }

  #print Dumper \@boards;

  my $board_ok = 1;
  for (my $rank = 0; $rank < $board_ranks; $rank++) {
    for (my $file = 0; $file < $board_files; $file++) {
      my $value = $board->[$rank]->[$file];
      $board_ok = 0 unless $value =~ /\d+/;
    }
    return $board if $board_ok;
    return undef;
  }

}