#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part2.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
chomp $input;

my $count = 1;
my $seen = {};
my @blocks = split(/\s+/, $input);
my $size = scalar @blocks;

while (1) {
    my $largest = 0;
    for (my $i = 1; $i < $size; $i++ ) {
        if ($blocks[$i] > $blocks[$largest]) {
            $largest = $i;
        }
    }

    my $blocksToMove = $blocks[$largest];
    $blocks[$largest] = 0;
    my $i = $largest + 1;
    while ($blocksToMove > 0) {
        $blocks[($i % $size)]++;
        $blocksToMove--;
        $i++;
    }

    my $key = join(',', @blocks);
    if (exists $seen->{$key}) {
        print "Found loop after: $count redistributions\n";
        print "Loop size: " . ($count - $seen->{$key}) . "\n";
        last;
    }
    $seen->{$key} = $count;
    $count++;
}

__END__

http://adventofcode.com/2017/day/6
