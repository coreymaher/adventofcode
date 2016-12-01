#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part1.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
my $nice = 0;
for (split(/\n/, $input)) {
    next if m/(ab|cd|pq|xy)/;
    next unless m/[aeiou].*[aeiou].*[aeiou]/;
    next unless m/(.)\1/;

    $nice++;
}
print "Nice: $nice\n";

__END__

Santa needs help figuring out which strings in his text file are naughty or nice.

- It contains at least three vowels (aeiou only)
- It contains at least one letter that appears twice in a row
- It does not contain the strings ab, cd, pq, or xy

How many strings are nice?
