#!/usr/bin/perl

use strict;
use FindBin;
use lib $FindBin::Bin;
use Term::ANSIColor;
use Data::Dumper;

my @input = ();
open (my $input, '<', 'test_input');
while (my $line = <$input>) { 
  chomp $line;
  #print $line, "\n";
  push @input, $line;
}
close $input;

my $board = [];

for (my $x = 0; $x < 10; $x++) {
  for (my $y = 0; $y < 10; $y++) {
    $board->[$y]->[$x] = { 
      level => substr($input[$y], $x, 1),
      has_flashed_this_turn => 0,
    }
  }
}

print_board($board);

my $flashes = 0;
for (my $iteration = 0; $iteration < 10000; $iteration++) {
  print "\nTurn ", $iteration + 1, "!\n\n";

  print "Incrementing everyone by one\n";
  $board = increment_board_by_one($board);
  print_board($board);

  while (has_potential_flashes($board)) {
    print "About to flash cells\n";
    $board = flash_board($board);
    print_board($board);
  }

  print "About to reset flashed cells\n";
  if (count_flashed_this_turn($board) == 100) {
    print "Dang we got this one for free!\n";
    print "\n100 flashes on turn ", $iteration + 1, ".\n";
    <>;
  }
  $flashes += count_flashed_this_turn($board);
  print "This turn had ", $flashes, " flashes.\n";
  $board = reset_flashed_cells($board);
  print_board($board);
  print "\nTurn ", $iteration + 1, " - Total Flashes so far: ", $flashes, "\n";

}

sub count_flashed_this_turn {
  my $board = shift;
  my $flashes = 0;
  for (my $x = 0; $x < 10; $x++) {
    for (my $y = 0; $y < 10; $y++) {
      $flashes++ if $board->[$x]->[$y]->{'has_flashed_this_turn'};
    }
  }
  return $flashes;
}

sub reset_flashed_cells {
  my $board = shift;

  for (my $x = 0; $x < 10; $x++) {
    for (my $y = 0; $y < 10; $y++) {
      if ($board->[$x]->[$y]->{'has_flashed_this_turn'}) {
        $board->[$x]->[$y]->{'level'} = 0;
        $board->[$x]->[$y]->{'has_flashed_this_turn'} = 0;
      }
    }
  }

  return $board;
}

sub has_potential_flashes {
  my $board = shift;
  for (my $x = 0; $x < 10; $x++) {
    for (my $y = 0; $y < 10; $y++) {
      return 1 if $board->[$x]->[$y]->{'level'} > 9;
    }
  }
  print "Returning no flashes upcoming.\n";
  return 0;
}


sub flash_board {
  my $board = shift;
  for (my $x = 0; $x < 10; $x++) {
    for (my $y = 0; $y < 10; $y++) {
      if (!$board->[$x]->[$y]->{'has_flashed_this_turn'} && $board->[$x]->[$y]->{'level'} > 9) {
        $board->[$x]->[$y]->{'has_flashed_this_turn'} = 1;
        $board->[$x]->[$y]->{'level'} = '*';
        my $cords = get_near_cords($x, $y);
        my @neighbors = @$cords;
        foreach my $neighbor (@neighbors) {
          $board->[$neighbor->[0]]->[$neighbor->[1]]->{'level'}++ 
            if (!$board->[$neighbor->[0]]->[$neighbor->[1]]->{'has_flashed_this_turn'});
        }
      }
    }
  }
  return $board;
}

sub get_near_cords {
  my $x = shift;
  my $y = shift;

  my @cords = (
    [$x - 1, $y - 1],
    [$x, $y - 1],
    [$x + 1, $y - 1],
    [$x - 1, $y],
    [$x + 1, $y],
    [$x - 1, $y + 1], 
    [$x, $y + 1],
    [$x + 1, $y + 1]
  );

  for (my $index = 0; $index < scalar(@cords); $index++) {
    if (
      $cords[$index]->[0] < 0 or 
      $cords[$index]->[0] > 9 or 
      $cords[$index]->[1] < 0 or 
      $cords[$index]->[1] > 9
    ) {
      splice(@cords, $index, 1);
      $index--;
    }
  }

  return \@cords;
}

sub increment_board_by_one {
  my $board = shift;

  for (my $x = 0; $x < 10; $x++) {
    for (my $y = 0; $y < 10; $y++) {
      $board->[$x]->[$y]->{'level'} += 1 unless $board->[$x]->[$y]->{'level'} eq '*';
    }
  }

  return $board;
}

#print Dumper $board;

sub print_board {
  my $board = shift;
  for (my $x = 0; $x < 10; $x++) {
    for (my $y = 0; $y < 10; $y++) {
      if ($board->[$x]->[$y]->{'has_flashed_this_turn'}) {
        print color('red');
      }
      print $board->[$x]->[$y]->{'level'};
      if ($board->[$x]->[$y]->{'has_flashed_this_turn'}) {
        print color('reset');
      }
    }
  print "\n";
  }
  print "\n";
}
