#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part1.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
my $pos = {
    santa => {
        x => 0,
        y => 0,
    },
    robo => {
        x => 0,
        y => 0,
    },
};
my $houses = {
    '0:0' => 2,
};
my $person = 'santa';
for (split(//, $input)) {
    $pos->{$person}->{y}++ if $_ eq '^';
    $pos->{$person}->{y}-- if $_ eq 'v';
    $pos->{$person}->{x}++ if $_ eq '>';
    $pos->{$person}->{x}-- if $_ eq '<';

    my $key = $pos->{$person}->{x} . ':' . $pos->{$person}->{y};
    $houses->{$key} = (defined $houses->{$key}) ? $houses->{key} : 0;
    $houses->{$key}++;

    $person = ($person eq 'santa') ? 'robo' : 'santa';
}

my $num = scalar keys %$houses;
print "Num houses: $num\n";

__END__

Santa and Robo-Santa start at the same location (delivering two presents to the same starting house),
then take turns moving based on instructions from the elf.

How many houses receive at least one present?
