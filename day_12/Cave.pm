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

sub is_ok_to_visit {
  my $self = shift;
  my $visited_nodes = shift;
  return 1 if $self->{'is_large'};

  my $been_visited = 0;
  foreach my $past_node (@$visited_nodes) {
    #print "Checking ", $past_node, " vs ", $self->{'name'}, " .. \n";
    $been_visited = 1 if $past_node eq $self->{'name'};
  }

  #print "Has it been visited?\n";
  #print $been_visited, "\n";

  return 1 unless $been_visited;

  return 0;
}

sub get_valid_next_moves {
  my $self = shift;
  my $visited_nodes = shift;

  my @valid_next_moves = ();
  foreach my $neighbor (@{$self->{'connections'}}) {
    push @valid_next_moves, $neighbor 
      if $neighbor->is_ok_to_visit($visited_nodes);
  }

  return \@valid_next_moves;
}


1;
