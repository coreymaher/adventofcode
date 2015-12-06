#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part2.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
my @lights = ();
for (split(/\n/, $input)) {
    my ($action, $startX, $startY, $endX, $endY) = m/^(.*?) (\d+)\,(\d+) through (\d+)\,(\d+)$/;

    for (my $x = $startX; $x <= $endX; $x++) {
        for (my $y = $startY; $y <= $endY; $y++) {
            $lights[$x][$y]++ if $action eq 'turn on';
            $lights[$x][$y]-- if $action eq 'turn off';
            $lights[$x][$y] += 2 if $action eq 'toggle';

            $lights[$x][$y] = 0 if $lights[$x][$y] < 0;
        }
    }
}

my $brightness = 0;
for (my $x = 0; $x < 1000; $x++) {
    for (my $y = 0; $y < 1000; $y++) {
        $brightness += ($lights[$x][$y] // 0);
    }
}

print "Brightness: $brightness\n";

__END__

The light grid you bought actually has individual brightness controls; each light can have a brightness of zero or more.
The lights all start at zero.

The phrase turn on actually means that you should increase the brightness of those lights by 1.
The phrase turn off actually means that you should decrease the brightness of those lights by 1, to a minimum of zero.
The phrase toggle actually means that you should increase the brightness of those lights by 2.

What is the total brightness of all lights combined after following Santa's instructions?
