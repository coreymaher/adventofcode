#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part1.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
my $pos = {
    x => 0,
    y => 0,
};
my $houses = {
    '0:0' => 1,
};
for (split(//, $input)) {
    $pos->{y}++ if $_ eq '^';
    $pos->{y}-- if $_ eq 'v';
    $pos->{x}++ if $_ eq '>';
    $pos->{x}-- if $_ eq '<';

    my $key = $pos->{x} . ':' . $pos->{y};
    $houses->{$key} = 1;
}

my $num = scalar keys %$houses;
print "Num houses: $num\n";

__END__

He begins by delivering a present to the house at his starting location,
and then an elf at the North Pole calls him via radio and tells him where to move next.
Moves are always exactly one house to the north (^), south (v), east (>), or west (<).
After each move, he delivers another present to the house at his new location.

How many houses receive at least one present?
