#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

use Digest::MD5 qw/md5_hex/;

my $input = 'iwrupvqb';
my $num = 1;
while (1) {
    my $hash = md5_hex($input . $num);

    if ($hash =~ m/^0{5}/) {
        print "Num: $num\n";
        last;
    }
    $num++;
}


__END__

Find MD5 hashes which, in hexadecimal, start with at least five zeroes.
The input to the MD5 hash is some secret key (your puzzle input, given below) followed by a number in decimal.
To mine AdventCoins, you must find Santa the lowest positive number (no leading zeroes: 1, 2, 3, ...) that produces such a hash.
