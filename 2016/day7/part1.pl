#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part1.pl filename" unless scalar @ARGV == 1;

my @input = read_file($ARGV[0]);

my $valid = 0;
for my $line (@input) {
    chomp $line;

    print "$line -> ";

    if ($line =~ m/\[ \w* (\w) (?! \1 | \W ) (\w) \2 \1 \w* \]/x) {
        print "Invalid\n";
    } elsif ($line =~ m/(\w) (?! \1 | \W ) (\w) \2 \1/x) {
        print "Valid\n";
        $valid++;
    } else {
        print "Invalid\n";
    }
}

print "Total: $valid\n";

__END__

http://adventofcode.com/2016/day/7
