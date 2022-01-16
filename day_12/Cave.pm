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
  my $connections = $self->{'connections'};
  push @$connections, $connectee;
}

sub is_ok_to_visit {
  my $self = shift;
  my $visited_nodes = shift; # these are just names, not objects
  my $cave_map = shift;
  return 1 if $self->{'is_large'};
  return 0 if $self->{'name'} eq 'start';

  my $been_visited = 0;
  
  my %found_little_ones = ();

  foreach my $past_node_name (@$visited_nodes) {
    #print "Past node name .. ", $past_node_name, "\n";
    $found_little_ones{$past_node_name}++ unless $cave_map->{$past_node_name}->{'is_large'};
  }

  #print "Here is my little cave history: \n";
  #print Dumper \%found_little_ones;

  my $have_visited_small_cave_twice_already = 0;
  foreach my $little_cave (keys(%found_little_ones)) {
    $have_visited_small_cave_twice_already = 1 if $found_little_ones{$little_cave} > 1;
  }

  #<>;

  foreach my $past_node (@$visited_nodes) {
    #print "Checking ", $past_node, " vs ", $self->{'name'}, " .. \n";
    $been_visited = 1 if $past_node eq $self->{'name'} and $have_visited_small_cave_twice_already;
  }

  #print "Has it been visited?\n";
  #print $been_visited, "\n";

  return 1 unless $been_visited;

  return 0;
}

sub get_valid_next_moves {
  my $self = shift;
  my $visited_nodes = shift;
  my $cave_map = shift;

  my @valid_next_moves = ();
  foreach my $neighbor (@{$self->{'connections'}}) {
    push @valid_next_moves, $neighbor 
      if $neighbor->is_ok_to_visit($visited_nodes, $cave_map);
  }

  return \@valid_next_moves;
}


1;
