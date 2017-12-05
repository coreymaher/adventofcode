#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part1.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
chomp $input;

my $counter = 0;
my $steps = 0;
my @lines = split(/\n/, $input);
my $size = scalar @lines;
while (1) {
    my $nextCounter = $counter + $lines[$counter];
    $lines[$counter]++;

    $steps++;
    last if ($nextCounter < 0 || $nextCounter >= $size);
    $counter = $nextCounter;
}

print "steps: $steps\n";

__END__

http://adventofcode.com/2017/day/5
