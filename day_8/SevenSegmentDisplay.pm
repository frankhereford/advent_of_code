package SevenSegmentDisplay;
use strict;
use warnings;

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