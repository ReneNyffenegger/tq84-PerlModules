package tq84_ftp;

use warnings;
use strict;

use parent 'Net::FTP';
use Net::FTP::File qw( );   # Adds methods to Net::FTP objects's parent 'Net::FTP';


sub new { # {{{

  my $class   = shift;
  my $ftp_env = shift;

  die "tq84_ftp: ${ftp_env}_FTP_USER not defined" unless $ENV{"${ftp_env}_FTP_USER"};
  die "tq84_ftp: ${ftp_env}_FTP_PW not defined"   unless $ENV{"${ftp_env}_FTP_PW"};
  die "tq84_ftp: ${ftp_env}_FTP_HOST not defined" unless $ENV{"${ftp_env}_FTP_HOST"};

  my $self = $class->SUPER::new($ENV{"${ftp_env}_FTP_HOST"},
    Debug   => 0,
    Passive => 1 # 2017-01-19 Passive = 1 seems to be necessary in Eskimo.
  ) or die "Could not connect to " . $ENV{"${ftp_env}_FTP_HOST"};

  $self -> login($ENV{"${ftp_env}_FTP_USER"}, $ENV{"${ftp_env}_FTP_PW"}) or die "Could not login";
  $self -> binary;

  return $self;

} # }}}


1;
