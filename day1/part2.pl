#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part2.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
my $floor = 0;
my $pos = 1;
for (split(//, $input)) {
    $floor++ if ($_ eq '(');
    $floor-- if ($_ eq ')');

    last if ($floor < 0);

    $pos++;
}

print "Position: $pos\n";

__END__

An opening parenthesis, (, means he should go up one floor, and a closing parenthesis, ), means he should go down one floor.

What is the position of the character that causes Santa to first enter the basement?
