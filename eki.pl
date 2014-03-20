use strict;
use warnings;

use constant BASEURL => 'http://www.ekidata.jp/api/p/';

use JSON;

sub new{
 my($class,%opt) = @_;
 my $self = {
  prefnumber => $opt{prefnumber},
 }
 bless $self,$class;
 $self;
}


