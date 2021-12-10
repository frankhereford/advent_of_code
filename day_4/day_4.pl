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

shift @input;

my @boards = ();

while (1) {
  my $board = &pop_board_off_input(\@input);
  last unless $board;
  for (my $rank = 0; $rank <= $board_ranks; $rank++) { shift @input; } # fast forward one board
  push @boards, $board;
}


mark_boards(\@boards, 7);
mark_boards(\@boards, 22);
print Dumper \@boards;

sub mark_boards {
  my $boards = shift;
  my $call = shift;
  my @boards = @$boards;
  for (my $board = 0; $board < scalar(@boards); $board++) {
    for (my $rank = 0; $rank < $board_ranks; $rank++) {
      for (my $file = 0; $file < $board_files; $file++) {
        my $value = $boards->[$board]->[$rank]->[$file]->{'value'};
        $boards->[$board]->[$rank]->[$file]->{'found'}++ if $value == $call;
      }
    }
  }
  return \@boards;
}

sub pop_board_off_input {
  my $input = shift;
  my @input = @$input;
  my $board = [[], [], [], [], []];
  for (my $rank = 0; $rank < $board_ranks; $rank++) {
    my $rank_values = shift(@input);
    $rank_values =~ s/^\s+(\d)/$1/;
    my @rank_values = split(/\s+/, $rank_values);
    for (my $file = 0; $file < $board_files; $file++) {
      $board->[$rank]->[$file] = {
        value => int($rank_values[$file]),
        found => 0,
      };
    }
  }

  my $board_ok = 1;
  my $zero_count = 0;
  for (my $rank = 0; $rank < $board_ranks; $rank++) {
    for (my $file = 0; $file < $board_files; $file++) {
      my $value = $board->[$rank]->[$file]->{'value'};
      $zero_count++ unless $value;
      $board_ok = 0 unless $value =~ /\d+/;
    }
  }

  return undef if $zero_count == $board_ranks * $board_files;
  return $board if $board_ok;
  return undef;
}