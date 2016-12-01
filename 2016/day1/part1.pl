#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part1.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
my $x = 0;
my $y = 0;
my $dir = 0; # 0 = North, 1 = East, 2 = South, 3 = West
for (split(/,\s+/, $input)) {
    chomp;
    (my $turn, my $distance) = m/(.)(\d+)/;

    $dir += (($turn eq 'R') ? 1 : -1);
    $dir = $dir % 4;

    if ($dir == 0) {
        $y += $distance;
    } elsif ($dir == 1) {
        $x += $distance;
    } elsif ($dir == 2) {
        $y -= $distance;
    } elsif ($dir == 3) {
        $x -= $distance;
    }

    print "$_ ($x,$y)\n";
}

my $total = abs($x) + abs($y);

print "Total: $total\n";

__END__

http://adventofcode.com/2016/day/1
