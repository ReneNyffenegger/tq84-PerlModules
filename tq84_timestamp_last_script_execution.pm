package tq84_timestamp_last_script_execution;

use Exporter;
use File::Touch;

our @ISA = 'Exporter';
our @EXPORT = qw(is_file_modified_since_last_script_execution);

my $file_timestamp_last_script_execution;

BEGIN {

  $file_timestamp_last_script_execution = 'tq84_timestamp_last_script_execution';

  unless (-f $file_timestamp_last_script_execution) {
    print "touching $file_timestamp_last_script_execution because it does not exist\n";
    touch $file_timestamp_last_script_execution;
  }

};

sub is_file_modified_since_last_script_execution {
  my $file = shift;
  die unless -f $file;

# printf "is_file_modified_since_last_script_execution $file %f %f\n", -M $file_timestamp_last_script_execution, -M $file;

  return -M $file < -M $file_timestamp_last_script_execution; 
}

END {

  print "touching $file_timestamp_last_script_execution in END handler\n";
  touch($file_timestamp_last_script_execution);

}


1;
