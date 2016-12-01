#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part2.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
my $total = 0;
for (split(/\n/, $input)) {
    my @d = m/(\d+)x(\d+)x(\d+)/;

    @d = sort { $a <=> $b } @d;

    $total += (($d[0] + $d[0] + $d[1] + $d[1]) + ($d[0] * $d[1] * $d[2]));
}
print "Total: $total\n";

__END__

The ribbon required to wrap a present is the shortest distance around its sides, or the smallest perimeter of any one face.
Each present also requires a bow made out of ribbon as well; the feet of ribbon required for the perfect bow is equal to the cubic feet of volume of the present.

How many total feet of ribbon should they order?
