#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

use Digest::MD5 qw/md5_hex/;

die "usage part1.pl" unless scalar @ARGV == 0;

my $input = 'cxdnnyjw';
my $test = 'abc';

my $code = "";
my $i = 0;
while(length $code != 8) {
    my $hash = md5_hex($input . $i);

    if ($hash =~ m/^0{5}/) {
        $code .= substr $hash, 5, 1;
    }
    $i++;
}

print "Code: $code\n";

__END__

http://adventofcode.com/2016/day/5
