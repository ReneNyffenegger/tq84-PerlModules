#!/usr/bin/perl
use warnings;
use strict;

use lib '..';
use tq84_ftp;

my $ftp = new tq84_ftp('TQ84_RN');

unless ($ftp->isdir('/test')) {
  die "/test does not exist or is not a directory";
}

unless ($ftp->isdir('/test/tq84_ftp')) {
  print "/test/tq84_ftp does not exist, creating it\n";

  $ftp -> mkdir('/test/tq84_ftp') or die;
}

$ftp -> cwd('/test/tq84_ftp');


for my $i (1 .. 100) {
  open (my $f, '>', "/tmp/$i.txt") or die "could not open /tmp/$i.txt";

  for my $j (1 .. 100) {
    print $f "$i\n";
  }

  close $f;

  print "Trying to put $i.txt\n";
  $ftp -> put("/tmp/$i.txt") or die;

  unlink "/tmp/$i.txt" or die;
}

$ftp -> rmdir('/test/tq84_ftp', 1);
