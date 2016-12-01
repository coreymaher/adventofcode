#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part1.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
my @lights = ();
for (split(/\n/, $input)) {
    my ($action, $startX, $startY, $endX, $endY) = m/^(.*?) (\d+)\,(\d+) through (\d+)\,(\d+)$/;

    for (my $x = $startX; $x <= $endX; $x++) {
        for (my $y = $startY; $y <= $endY; $y++) {
            $lights[$x][$y] = 1 if $action eq 'turn on';
            $lights[$x][$y] = 0 if $action eq 'turn off';
            $lights[$x][$y] = !$lights[$x][$y] if $action eq 'toggle';
        }
    }
}

my $lightsOn = 0;
for (my $x = 0; $x < 1000; $x++) {
    for (my $y = 0; $y < 1000; $y++) {
        $lightsOn++ if $lights[$x][$y];
    }
}

print "Total: $lightsOn\n";

__END__

Lights in your grid are numbered from 0 to 999 in each direction; the lights at each corner are at 0,0, 0,999, 999,999, and 999,0.
The instructions include whether to turn on, turn off, or toggle various inclusive ranges given as coordinate pairs.
Each coordinate pair represents opposite corners of a rectangle, inclusive; a coordinate pair like 0,0 through 2,2 therefore refers to 9 lights in a 3x3 square.
The lights all start turned off.

After following the instructions, how many lights are lit?
