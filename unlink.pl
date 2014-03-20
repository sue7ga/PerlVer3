use strict;
use warnings;

my @tarfiles = glob("*.tar.gz");

foreach my $file(@tarfiles){
 unlink $file;
}


