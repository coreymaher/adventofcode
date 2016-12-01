#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part2.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
my $x = 0;
my $y = 0;
my $dir = 0; # 0 = N, 1 = E, 2 = S, 3 = W
my %location;
$location{0}{0} = 1;
my $found = 0;
for (split(/,\s+/, $input)) {
    chomp;
    (my $turn, my $distance) = m/(.)(\d+)/;

    $dir += (($turn eq 'R') ? 1 : -1);
    $dir = $dir % 4;

    for (my $i = 0; $i < $distance; $i++) {
        if ($dir == 0) {
            $y++;
        } elsif ($dir == 1) {
            $x++;
        } elsif ($dir == 2) {
            $y--;
        } elsif ($dir == 3) {
            $x--;
        }

        if ($location{$x}{$y}) {
            $found = 1;
            last;
        }
        $location{$x}{$y} = 1;
    }

    print "$turn$distance ($x,$y)\n";

    last if ($found);
}

print "($x,$y)\n";

my $total = abs($x) + abs($y);

print "Total: $total\n";

__END__

http://adventofcode.com/2016/day/1
