#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part1.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
my $total = 0;
for (split(/\n/, $input)) {
    my @d = m/(\d+)x(\d+)x(\d+)/;

    my @areas = (
        (2 * $d[0] * $d[1]),
        (2 * $d[1] * $d[2]),
        (2 * $d[2] * $d[0]),
    );

    @areas = sort { $a <=> $b } @areas;

    $total += ($areas[0] + $areas[1] + $areas[2] + ($areas[0]/2));
}
print "Total: $total\n";

__END__

Surface area of the box, which is 2*l*w + 2*w*h + 2*h*l. The elves also need a little extra paper for each present: the area of the smallest side.

How many total square feet of wrapping paper should they order?
