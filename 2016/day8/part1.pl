#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part1.pl filename" unless scalar @ARGV == 1;

my @input = read_file($ARGV[0]);

my $maxWidth = 50;
my $maxHeight = 6;
my $display = [];

for my $y (0 .. $maxHeight - 1) {
    for my $x (0 .. $maxWidth - 1) {
        $display->[$y]->[$x] = '.';
    }
}

showDisplay($display);

my $total = 0;
for my $line (@input) {
    chomp $line;

    print "$line\n";
    if ($line =~ m/rect (\d+)x(\d+)/) {
        for my $y (0 .. ($2 - 1)) {
            for my $x (0 .. ($1 - 1)) {
                $display->[$y]->[$x] = '#';
            }
        }
    } elsif ($line =~ m/rotate row y=(\d+) by (\d+)/) {
        my @newRow = ();
        for my $i (0 .. $maxWidth - 1) {
            my $newPos = ($i + $2) % $maxWidth;
            $newRow[$newPos] = $display->[$1]->[$i];
        }

        $display->[$1] = \@newRow;
    } elsif ($line =~ m/rotate column x=(\d+) by (\d+)/) {
        my @newColumn = ();
        for my $i (0 .. $maxHeight - 1) {
            my $newPos = ($i + $2) % $maxHeight;
            $newColumn[$newPos] = $display->[$i]->[$1];
        }

        for my $i (0 .. $maxHeight - 1) {
            $display->[$i]->[$1] = $newColumn[$i];
        }
    }

    showDisplay($display);
}

my $total = 0;
for my $y (0 .. $maxHeight - 1) {
    for my $x (0 .. $maxWidth - 1) {
        $total++ if ($display->[$y]->[$x] eq '#');
    }
}


print "Total: $total\n";

sub showDisplay
{
    my $display = shift;

    for my $y (0 .. $maxHeight - 1) {
        for my $x (0 .. $maxWidth - 1) {
            print $display->[$y]->[$x];
        }

        print "\n";
    }
}

__END__

http://adventofcode.com/2016/day/8
