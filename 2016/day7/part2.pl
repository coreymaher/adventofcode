#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part2.pl filename" unless scalar @ARGV == 1;

my @input = read_file($ARGV[0]);

my $valid = 0;
for my $line (@input) {
    chomp $line;

    print "$line -> ";

    if ($line =~ m/(?: ^ \w* | \] \w* ) (\w) (?! \1 | \W ) (\w) \1 .* \[ \w* \2 \1 \2 \w* \]/x) {
        print "Valid\n";
        $valid++;
    } elsif ($line =~ m/\[ \w* (\w) (?! \1 | \W ) (\w) \1 \w* \] (?:\w | (?: \[ \w* \] ))* \2 \1 \2/x) {
        print "Valid\n";
        $valid++;
    } else {
        print "Invalid\n";
    }
}

print "Total: $valid\n";

__END__

http://adventofcode.com/2016/day/7
