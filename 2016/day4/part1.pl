#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part1.pl filename" unless scalar @ARGV == 1;

my @input = read_file($ARGV[0]);

my $total = 0;
for my $line (@input) {
    chomp $line;
    print "$line ";
    (my $name, my $number, my $checksum) = $line =~ m/^([a-z-]+)-(\d+)\[(\w+)\]$/;

    my $letters = {};
    for (split//, $name) {
        $letters->{$_}++ unless $_ eq '-';
    }

    my @correctChecksum = sort { $letters->{$b} <=> $letters->{$a} or $a cmp $b } keys $letters;

    if ($checksum eq join('', @correctChecksum[0 .. 4])) {
        print "Valid!\n";
        $total += $number;
    } else {
        print "Invalid\n";
    }
}

print "Total: $total\n";

__END__

http://adventofcode.com/2016/day/4
