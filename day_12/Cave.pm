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
    been_visited => 0,
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

sub is_ok_to_visit {
  my $self = shift;
  return 1 if $self->{'is_large'};
  return 1 unless $self->{'been_visited'};
  return 0;
}

sub get_valid_next_moves {
  my $self = shift;
  my $visited_nodes = shift;

  my @valid_next_moves = ();
  foreach my $neighbor (@{$self->{'connections'}}) {
    push @valid_next_moves, $neighbor if $neighbor->is_ok_to_visit;
  }
  return \@valid_next_moves;
}


1;
