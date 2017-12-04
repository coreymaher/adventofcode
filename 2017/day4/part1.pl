#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part1.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
chomp $input;

my $valid = 0;
for my $line (split(/\n/, $input)) {
    my $passphrases = {};

    for (split(/\s/, $line)) {
        $passphrases->{$_}++;
    }

    my $isValid = 1;
    for (keys %$passphrases) {
        if ($passphrases->{$_} > 1) {
            $isValid = 0;
            last;
        }
    }

    $valid++ if ($isValid);
}


print "Valid passphrases: $valid\n";

__END__

http://adventofcode.com/2017/day/4
