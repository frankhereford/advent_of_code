
  if (!$number_of_peeks) { # initial guess
    # odd turn number, track from the right
    print "Initial odd turn\n";
    if ($number_of_holes % 2) { 
      # if the number of holes is odd ...
      print "We have an odd number of holes to consider\n";
      $guess = $number_of_holes - 2; # assuming we have an odd number of holes
    } else {
      print "We have an even number of holes to consider\n";
      $guess = $number_of_holes - 1; 
    }
    $last_odd_guess = $guess;
  } elsif ($number_of_peeks == 1) { 
    # initial even guess, track from the left
    print "Initial even turn\n";
    $guess = 0;
    $last_even_guess = $guess;
  } else { # not initial guess
    if ($number_of_peeks % 2) { # remember that turns are one indexed!
      print "Non-initial even turn\n";
      # we're on a non-initial, even turn iteration
      $guess = $last_even_guess + 2;
      $last_even_guess = $guess;
    } else { 
      print "Non-initial odd turn\n";
      # we're on an non-initial, odd turn iteration
      $guess = $last_odd_guess - 2;
      $last_odd_guess = $guess;
    }
  }

  # if non-initial odd turn and guess == -1 -- this happens first
  # if non-initial even turn and guess == number_of_holes + 1

  if ($number_of_peeks % 2 && $number_of_holes % 2) { # same tricky thing; i think it's clear that i made a mistake early on that i'm living with
    # odd number of holes
    if ($number_of_peeks && $guess == $number_of_holes + 1) {
      # we're done with the first pass, and if we got here, our assumption about the rabbit evenness is wrong
      print "Here is where we turn around\n";

      if ($in_even_hole) { $in_even_hole--; } # we're not really going to use this variable are we
      else { $in_even_hole++; }

      # these become the worst named variables ever at this point
      $last_even_guess = -1;
      $last_odd_guess = $number_of_holes + 1;
      next;
    }
  } else {
    # even number of holes
    if ($number_of_peeks && $guess == -1) {
      # we're done with the first pass, and if we got here, our assumption about the rabbit evenness is wrong
      print "Here is where we turn around\n";

      if ($in_even_hole) { $in_even_hole--; } # we're not really going to use this variable are we
      else { $in_even_hole++; }

      # these become the worst named variables ever at this point
      $last_even_guess = -1;
      $last_odd_guess = $number_of_holes + 1;
      next;
    }
  }





    #$guess = int($number_of_holes / 2);
    #unless ($guess % 2) { # guess is even
      #$guess--; # shift one to the right, make it odd
    #}
