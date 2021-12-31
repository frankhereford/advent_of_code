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
}

1;