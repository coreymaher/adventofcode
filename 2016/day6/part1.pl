#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part1.pl filename" unless scalar @ARGV == 1;

my @input = read_file($ARGV[0]);

my $chars = [];

for my $line (@input) {
    chomp $line;

    my $i = 0;
    for (split//, $line) {
        $chars->[$i]->{$_}++;
        $i++;
    }
}

for my $column (@$chars) {
    my $char = (sort { $column->{$a} <=> $column->{$b} } keys $column)[-1];
    print $char;
}

print "\n";

__END__

http://adventofcode.com/2016/day/6
