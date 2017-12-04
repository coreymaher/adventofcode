#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part1.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
chomp $input;
my $total = 0;
my @digits = split(//, $input);
my $totalDigits = scalar @digits;

for (my $i = 0; $i < scalar @digits; $i++) {
    my $next = ($i+1) % $totalDigits;
    if ($digits[$i] == $digits[$next]) {
        $total += $digits[$i];
    }
}

print "Total: $total\n";

__END__

http://adventofcode.com/2017/day/1
