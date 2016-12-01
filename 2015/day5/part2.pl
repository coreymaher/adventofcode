#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part2.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
my $nice = 0;
for (split(/\n/, $input)) {
    next unless m/(.{2}).*\1/;
    next unless m/(.).\1/;

    $nice++;
}
print "Nice: $nice\n";

__END__

- It contains a pair of any two letters that appears at least twice in the string without overlapping,
    like xyxy (xy) or aabcdefgaa (aa), but not like aaa (aa, but it overlaps).
- It contains at least one letter which repeats with exactly one letter between them,
    like xyx, abcdefeghi (efe), or even aaa.

How many strings are nice?
