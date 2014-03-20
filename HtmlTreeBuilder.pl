use strict;
use LWP::Simple;
use HTML::TreeBuilder;
use Encode;
use encoding 'utf8';
binmode(STDERR,':raw :encoding(utf8)');

my $url = 'http://www.oreilly.co.jp/catalog/';

my $page = get($url) or die $!;
$page = decode('utf8',$page);

my $p = HTML::TreeBuilder->new_from_content($page);

my @links = $p->look_down(
  _tag => 'a',
  href => qr{^ \Qhttp://www.oreilly.co.jp/BOOK/\E \w+ / $}x
);

my @rows = map{$_->parent->parent}@links;

use Data::Dumper;
print Dumper @rows;
