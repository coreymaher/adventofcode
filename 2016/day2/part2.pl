#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part2.pl filename" unless scalar @ARGV == 1;

my @input = read_file($ARGV[0]);
my $x = 0;
my $y = 2;
my $keypad = [
    [ qw/- - 1 - -/ ],
    [ qw/- 2 3 4 -/ ],
    [ qw/5 6 7 8 9/ ],
    [ qw/- A B C -/ ],
    [ qw/- - D - -/ ],
];
my $code = '';

for my $line (@input) {
    chomp $line;
    for (split//, $line) {
        my $tryX = $x;
        my $tryY = $y;

        $tryY-- if ($_ eq 'U' && $y > 0);
        $tryY++ if ($_ eq 'D' && $y < 4);
        $tryX-- if ($_ eq 'L' && $x > 0);
        $tryX++ if ($_ eq 'R' && $x < 4);

        if ($keypad->[$tryY]->[$tryX] ne '-') {
            $x = $tryX;
            $y = $tryY;
        }
    }

    print "$line ($x,$y): " . $keypad->[$y]->[$x] . "\n";
    $code .= $keypad->[$y]->[$x];
}

print "Code: $code\n";

__END__

http://adventofcode.com/2016/day/2
