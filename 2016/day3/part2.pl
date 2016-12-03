#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part2.pl filename" unless scalar @ARGV == 1;

my @input = read_file($ARGV[0]);

my $columns = [
    [],
    [],
    [],
];

my $numValid = 0;
for my $line (@input) {
    chomp $line;
    my @sides = $line =~ m/\s*(\d+)\s+(\d+)\s+(\d+)/;

    push @$columns[0], $sides[0];
    push @$columns[1], $sides[1];
    push @$columns[2], $sides[2];
}

for my $column (@$columns) {
    while (@$column) {
        my @sides = (shift @$column, shift @$column, shift @$column);

        $numValid++ if (
            $sides[0] < ($sides[1] + $sides[2]) &&
            $sides[1] < ($sides[0] + $sides[2]) &&
            $sides[2] < ($sides[0] + $sides[1])
        );
    }
}

print "Valid: $numValid\n";


__END__

http://adventofcode.com/2016/day/3
