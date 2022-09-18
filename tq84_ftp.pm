package tq84_ftp;

use warnings;
use strict;

use parent 'Net::FTP';
use Net::FTP::File qw( );   # Adds methods to Net::FTP objects's parent 'Net::FTP';
use Net::Netrc;


sub new { # {{{

  my $class   = shift;
  my $ftp_env = shift;

  my $tq84_ftp_host = $ENV{"${ftp_env}_FTP_HOST"};
# die "tq84_ftp: ${ftp_env}_FTP_USER not defined" unless $ENV{"${ftp_env}_FTP_USER"};
# die "tq84_ftp: ${ftp_env}_FTP_PW not defined"   unless $ENV{"${ftp_env}_FTP_PW"};
# die "tq84_ftp: ${ftp_env}_FTP_HOST not defined" unless $ENV{"${ftp_env}_FTP_HOST"};
  die "tq84_ftp: ${ftp_env}_FTP_HOST not defined" unless $tq84_ftp_host;
  
  my ($tq84_ftp_user, $tq84_ftp_pw) = read_private($tq84_ftp_host);
 
# my $self = $class->SUPER::new($ENV{"${ftp_env}_FTP_HOST"},
  my $self = $class->SUPER::new($tq84_ftp_host,
    Debug   => 0,
  # Passive => 1 # 2017-01-19 Passive = 1 seems to be necessary in Eskimo.
  ) or die "Could not connect to $tq84_ftp_host";
  #q 
# $self -> login($ENV{"${ftp_env}_FTP_USER"}, $ENV{"${ftp_env}_FTP_PW"}) or die "Could not login";
  $self -> login($tq84_ftp_user, $tq84_ftp_pw) or die "Could not login";
  $self -> binary;

  return $self;

} # }}}

sub read_private { # {{{

  my $host = shift;
  my $mach = Net::Netrc->lookup($host);

  die "Net::Netrc->lookup failed" unless $mach;
# my $login = $mach->login;
  my ($login, $password, $account) = $mach->lpa;

  return ($login, $password);

} # }}}

1;
