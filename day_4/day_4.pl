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


#mark_boards(\@boards, 7);
#mark_boards(\@boards, 5);
#mark_boards(\@boards, 20);
#mark_boards(\@boards, 19);
#mark_boards(\@boards, 4);

#mark_boards(\@boards, 2);
#mark_boards(\@boards, 0);
#mark_boards(\@boards, 12);
#mark_boards(\@boards, 3);

#mark_boards(\@boards, 14);
#mark_boards(\@boards, 16);
#mark_boards(\@boards, 23);
#mark_boards(\@boards, 6);
#mark_boards(\@boards, 7);

#mark_boards(\@boards, 2);
#mark_boards(\@boards, 11);
#mark_boards(\@boards, 23);
#mark_boards(\@boards, 9);
#mark_boards(\@boards, 4);

#print Dumper $boards[check_boards(\@boards)];
#print "Found: ", check_boards(\@boards), "\n";;

my $winner = undef;
my $last_call = undef;
foreach my $call (@bingo_calls) {
  print "Calling: ", $call, "\n";
  $last_call = $call;
  mark_boards(\@boards, $call);
  $winner = check_boards(\@boards); 
  print "Winner: ", $winner, "\n" if $winner;
  last if $winner;
}

#print Dumper $boards[$winner];

print "Score: ", score_board($boards[$winner], $last_call), "\n";

sub score_board {
  my $board = shift;
  my $call = shift;
  my $unfound_sum = 0;
  for (my $rank = 0; $rank < $board_ranks; $rank++) {
    for (my $file = 0; $file < $board_files; $file++) {
      $unfound_sum += $board->[$rank]->[$file]->{'value'} unless $board->[$rank]->[$file]->{'found'};
    }
  }
  return $unfound_sum * $call;
}

sub check_boards {
  my $boards = shift;
  my @boards = @$boards;

  #row search 
  for (my $board = 0; $board < scalar(@boards); $board++) {
    for (my $rank = 0; $rank < $board_ranks; $rank++) {
      # row search
      my $found = 0;
      for (my $file = 0; $file < $board_files; $file++) {
        $found++ if $boards->[$board]->[$rank]->[$file]->{'found'};
      }
      return $board if $found == $board_ranks;
    }

  #file search 
    for (my $file = 0; $file < $board_files; $file++) {
      # row search
      my $found = 0;
      for (my $rank = 0; $rank < $board_ranks; $rank++) {
        $found++ if $boards->[$board]->[$rank]->[$file]->{'found'};
      }
      return $board if $found == $board_ranks;
    }

    #return $board if (
      #$boards->[$board]->[0]->[0]->{'found'} &&
      #$boards->[$board]->[1]->[1]->{'found'} &&
      #$boards->[$board]->[2]->[2]->{'found'} &&
      #$boards->[$board]->[3]->[3]->{'found'} &&
      #$boards->[$board]->[4]->[4]->{'found'} 
    #);

    #return $board if (
      #$boards->[$board]->[4]->[0]->{'found'} &&
      #$boards->[$board]->[3]->[1]->{'found'} &&
      #$boards->[$board]->[2]->[2]->{'found'} &&
      #$boards->[$board]->[1]->[3]->{'found'} &&
      #$boards->[$board]->[0]->[4]->{'found'} 
    #);

  }
}

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