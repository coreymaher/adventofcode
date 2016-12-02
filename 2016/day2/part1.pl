#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part1.pl filename" unless scalar @ARGV == 1;

my @input = read_file($ARGV[0]);
my $x = 1;
my $y = 1;
my $keypad = [
    [ 1, 2, 3 ],
    [ 4, 5, 6 ],
    [ 7, 8, 9 ],
];
my $code = '';

for my $line (@input) {
    chomp $line;
    for (split//, $line) {
        $y-- if ($_ eq 'U' && $y > 0);
        $y++ if ($_ eq 'D' && $y < 2);
        $x-- if ($_ eq 'L' && $x > 0);
        $x++ if ($_ eq 'R' && $x < 2);
    }

    print "$line ($x,$y): " . $keypad->[$y]->[$x] . "\n";
    $code .= $keypad->[$y]->[$x];
}

print "Code: $code\n";

__END__

http://adventofcode.com/2016/day/2
