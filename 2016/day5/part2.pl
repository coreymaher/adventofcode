#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

use Digest::MD5 qw/md5_hex/;

die "usage part2.pl" unless scalar @ARGV == 0;

my $input = 'cxdnnyjw';
my $test = 'abc';

my $charsFound = 0;
my $code = [];
my $i = 0;
while($charsFound != 8) {
    my $hash = md5_hex($input . $i);

    if ($hash =~ m/^0{5}/) {
        my ($pos, $char) = $hash =~ m/^0{5}([0-7])(.)/;
        if (defined $pos && defined $char && !defined $code->[$pos]) {
            $code->[$pos] = $char;
            $charsFound++;
        }
    }
    $i++;
}

print "Code: " . join('', @$code) . "\n";

__END__

http://adventofcode.com/2016/day/5
