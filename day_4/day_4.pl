#!/usr/bin/perl


use strict;
use Data::Dumper;
use Storable 'dclone';


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


my $winner = undef;
my $last_call = undef;
my $last_results = undef;
my $final_winning_board = undef;
foreach my $call (@bingo_calls) {
  print "Calling: ", $call, "\n";
  mark_boards(\@boards, $call);
  $winner = check_boards(\@boards); 
  #print Dumper $winner, "\n";

  my $winner_copy = dclone $winner;

  foreach my $key (keys(%{$winner})) {
    #print "Key: ", $key, "\n";
    delete $winner->{$key} if $last_results->{$key};
  }
  if (scalar(keys(%{$winner}))) {
    print "This rounds first time winner: ", keys(%{$winner}), "\n";
    $final_winning_board = keys(%{$winner});
    $last_call = $call;
    print "Score: ", score_board($boards[$final_winning_board], $call), "\n";
  }
  $last_results = $winner_copy;
}

print "Final Winning Board: ", $final_winning_board, "\n";
#print Dumper $boards[$final_winning_board], "\n";
#print "Score: ", score_board($boards[$final_winning_board], $last_call), "\n";

#print Dumper $boards[$winner];

#print "Score: ", score_board($boards[$winner], $last_call), "\n";

sub score_board {
  my $board = shift;
  #print Dumper $board, "\n";
  my $call = shift;
  print $call, "\n";
  my $unfound_sum = 0;
  for (my $rank = 0; $rank < $board_ranks; $rank++) {
    for (my $file = 0; $file < $board_files; $file++) {
      #print "Found: ", $board->[$rank]->[$file]->{'found'}, "\n";
      $unfound_sum += $board->[$rank]->[$file]->{'value'} unless $board->[$rank]->[$file]->{'found'};
    }
  }
  #print "Unfound sum: ", $unfound_sum, "\n";
  return $unfound_sum * $call;
}

sub check_boards {
  my $boards = shift;
  my @boards = @$boards;
  my $winners = {};

  #row search 
  for (my $board = 0; $board < scalar(@boards); $board++) {
    for (my $rank = 0; $rank < $board_ranks; $rank++) {
      # row search
      my $found = 0;
      for (my $file = 0; $file < $board_files; $file++) {
        $found++ if $boards->[$board]->[$rank]->[$file]->{'found'};
      }
      #push(@winners, $board) if $found == $board_ranks;
      $winners->{$board}++ if $found == $board_ranks;
    }

  #file search 
    for (my $file = 0; $file < $board_files; $file++) {
      # row search
      my $found = 0;
      for (my $rank = 0; $rank < $board_ranks; $rank++) {
        $found++ if $boards->[$board]->[$rank]->[$file]->{'found'};
      }
      #push(@winners, $board) if $found == $board_files;
      $winners->{$board}++ if $found == $board_files;
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
  return $winners;
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