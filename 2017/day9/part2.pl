#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part2.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
chomp $input;

my $result = 0;
my $negate = 0;
my $comment = 0;
my $groups = 0;
my $level = 0;
my $garbage = 0;
for (split//, $input) {
    if ($negate) {
        $negate = 0;
    } elsif ($comment) {
        if ($_ eq '!') {
            $negate = 1;
        } elsif ($_ eq '>') {
            $comment = 0;
        } else {
            $garbage++;
        }
    } else {
        if ($_ eq '<') {
            $comment = 1;
        } elsif ($_ eq '{') {
            $groups += ++$level;
        } elsif ($_ eq '}') {
            $level--;
        }
    }
}

print "Result: $groups\n";
print "Garbage: $garbage\n";

__END__

http://adventofcode.com/2017/day/9
