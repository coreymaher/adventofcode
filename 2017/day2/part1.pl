#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;
use List::Util qw/min max/;

die "usage part1.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
chomp $input;
my $checksum = 0;

for my $line (split(/\n/, $input)) {
    my @columns = split(/\s/, $line);
    my $min = min(@columns);
    my $max = max(@columns);

    $checksum += ($max - $min);
}

print "Checksum: $checksum\n";

__END__

http://adventofcode.com/2017/day/2
