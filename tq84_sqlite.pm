package tq84_sqlite;

use warnings;
use strict;

use DBI;

sub new { #_{

  my $class     = shift;
  my $db_path   = shift;
  my $create_db = shift;

  if (-f $db_path) {
    unlink $db_path;
  }

  my $self = {};

  bless $self, $class;

  $self->{dbh} = DBI->connect("dbi:SQLite:dbname=$db_path") or die "Could not open/create $db_path";

  $self->sql('PRAGMA synchronous=OFF');
  $self->sql('PRAGMA cache_size=4000000');
  $self->sql('PRAGMA journal_mode=memory');

  $self->{dbh}->{AutoCommit} = 0;

  return $self;

} #_}

sub sql { #_{

  my $self     = shift;
  my $sql_text = shift;

  $self->{dbh}->do($sql_text) or die "Could not execute
    $sql_text
  ";

} #_}

1;
