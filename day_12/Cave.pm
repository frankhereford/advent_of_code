package Cave;
use strict;
use warnings;
use Data::Dumper;

sub new {
  my ($class,$args) = @_;
  my $self = bless { 
    name => $args->{'name'},
    is_large => uc($args->{'name'}) eq $args->{'name'} ? 1 : 0,
    connections => [],
  }, $class;

  return $self;
}

sub add_connection {
  my $self = shift;
  my $connectee = shift;
  #print Dumper $self->{'connections'};
  my $connections = $self->{'connections'};
  push @$connections, $connectee;
}

1;
