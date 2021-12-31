package SevenSegmentDisplay;
use strict;
use warnings;
use Data::Dumper;

sub new {
  my ($class,$args) = @_;
  my $self = bless { 
    input_code => $args->{input_code},
    illuminated => {
      a => 0,
      b => 0,
      c => 0,
      d => 0,
      e => 0,
      f => 0,
      g => 0,
    },
    code => {
      a => 0,
      b => 0,
      c => 0,
      d => 0,
      e => 0,
      f => 0,
      g => 0,
    },
    intended => {
      a => 0,
      b => 0,
      c => 0,
      d => 0,
      e => 0,
      f => 0,
      g => 0,
    },
  }, $class;

  exit unless $self->{'input_code'};

  $self->_parse_code($self->{'input_code'});

  return $self;
}

sub _parse_code {
  my $self = shift;
  my $input = shift;

  my @letters = split(//, $input);
  foreach my $letter (@letters) {
    $self->{'illuminated'}->{$letter} = 1;
  }
  return $self;
}

sub parse_key {
  my $self = shift;
  my $input = shift;
  #print Dumper $input;
  $self->{'code'}->{'a'} = $input->[0];
  $self->{'code'}->{'b'} = $input->[1];
  $self->{'code'}->{'c'} = $input->[2];
  $self->{'code'}->{'d'} = $input->[3];
  $self->{'code'}->{'e'} = $input->[4];
  $self->{'code'}->{'f'} = $input->[5];
  $self->{'code'}->{'g'} = $input->[6];
  $self->_calc_intended;
  return $self;
}

sub _calc_intended { 
  my $self = shift;

  $self->{'intended'} = {
      a => 0,
      b => 0,
      c => 0,
      d => 0,
      e => 0,
      f => 0,
      g => 0,
  };

  foreach my $letter (keys %{$self->{illuminated}}) {
    if ($self->{'illuminated'}->{$letter}) {
      #print "Letter: ", $letter, " is illuminated\n";
      # this letter is illuminated
      #print $letter, "\n";
      $self->{'intended'}->{$self->{'code'}->{$letter}} = 1;
    }
  }
  return $self;
}

sub _get_intended_code {
  my $self = shift;
  my @intended_segments = ();

  foreach my $letter (keys %{$self->{intended}}) {
    if ($self->{'intended'}->{$letter} > 0) {
      push @intended_segments, $letter;
    }
  } 
  return join ('', sort(@intended_segments));
}

sub is_intended_valid {
  my $self = shift;
  my $intended_code = $self->_get_intended_code;
  return 1 if $intended_code eq 'abcefg'; # 0
  return 1 if $intended_code eq 'cf'; # 1
  return 1 if $intended_code eq 'acdeg'; # 2
  return 1 if $intended_code eq 'acdfg'; # 3
  return 1 if $intended_code eq 'bcdf'; # 4
  return 1 if $intended_code eq 'abdfg'; # 5
  return 1 if $intended_code eq 'abdefg'; # 6
  return 1 if $intended_code eq 'acf'; # 7
  return 1 if $intended_code eq 'abcdefg'; # 8
  return 1 if $intended_code eq 'abcdfg'; # 9
  return 0;
}

sub get_indended_digit {
  my $self = shift;
  my $intended_code = $self->_get_intended_code;
  return 0 if $intended_code eq 'abcefg'; # 0
  return 1 if $intended_code eq 'cf'; # 1
  return 2 if $intended_code eq 'acdeg'; # 2
  return 3 if $intended_code eq 'acdfg'; # 3
  return 4 if $intended_code eq 'bcdf'; # 4
  return 5 if $intended_code eq 'abdfg'; # 5
  return 6 if $intended_code eq 'abdefg'; # 6
  return 7 if $intended_code eq 'acf'; # 7
  return 8 if $intended_code eq 'abcdefg'; # 8
  return 9 if $intended_code eq 'abcdfg'; # 9
  exit;
}



=cut

0: 6
1: 2*
2: 5
3: 5
4: 4*
5: 5
6: 6
7: 3*
8: 7*
9: 6

=cut

1;