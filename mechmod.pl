use strict;
use encoding 'shiftjis';
binmode(STDERR,':raw :encoding(shiftjis)');
$|++;

use File::Basename;
use WWW::Mechanize 0.48;

my $mech  = WWW::Mechanize->new();

$mech->get("http://search.cpan.org");
$mech->success or die $mech->response->status_line;

$mech->form_number(1);
$mech->field(query => "Lester");
$mech->field(mode => "author");
$mech->submit();

$mech->success or die "post に失敗しました:",$mech->response->status_line;

$mech->follow_link(text_regex => qr/Andy/);
$mech->success or die "postに失敗しました:",$mech->response->status_line;

my @links = $mech->find_all_links(url_regex => qr/\.tar\.gz$/);

use Data::Dumper;

my @urls = map{$_->[0]}@links;
my @test_urls = grep{$_ =~ /Test/}map{$_->[0]}@links;
my @not_test_urls = grep{$_ !~ /Test/}map{ $_->[0] }@links;

print "test files",scalar @test_urls,"\n";
print "not test files",scalar @not_test_urls,"\n";
print "exists Donwload",scalar @urls,"tall ball","\n";

print "fooooo!" unless scalar @urls == scalar @test_urls + scalar @not_test_urls;

foreach my $url(@urls){
  my $filename = basename($url);
  print "$filename-->";
  #$mech->get($url,':content_file'=>$filename);
  print -s $filename,"bytes","\n";
}
