#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part1.pl filename" unless scalar @ARGV == 1;

my @input = read_file($ARGV[0]);

my $numValid = 0;
for my $line (@input) {
    chomp $line;
    my @sides = $line =~ m/\s*(\d+)\s+(\d+)\s+(\d+)/;

    $numValid++ if (
        $sides[0] < ($sides[1] + $sides[2]) &&
        $sides[1] < ($sides[0] + $sides[2]) &&
        $sides[2] < ($sides[0] + $sides[1])
    );
}

print "Valid: $numValid\n";


__END__

http://adventofcode.com/2016/day/3
