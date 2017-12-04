#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part2.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
chomp $input;
my $result = 0;

for my $line (split(/\n/, $input)) {
    my @columns = split(/\s/, $line);
    my @sorted = sort { $b <=> $a } @columns;
    CHECK: for (my $i = 0; $i < scalar @sorted; $i++) {
        for (my $j = $i+1; $j < scalar @sorted; $j++) {
            if ($sorted[$i] % $sorted[$j] == 0) {
                $result += ($sorted[$i] / $sorted[$j]);
                last CHECK;
            }
        }
    }
}

print "Result: $result\n";

__END__

http://adventofcode.com/2017/day/2
