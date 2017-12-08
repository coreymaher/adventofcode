#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part1.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
chomp $input;

my $result = 0;

my $registers = {};

for my $line (split(/\n/, $input)) {
    my ($reg, $op, $amount, $checkReg, $checkOp, $checkAmount) = $line =~ m/^(\S+) (\S+) (\S+) if (\S+) (\S+) (\S+)$/;

    my $checkRegValue = (exists $registers->{$checkReg}) ? $registers->{$checkReg} : 0;

    my $doOp = 0;
    $doOp = 1 if ($checkOp eq '>' && $checkRegValue > $checkAmount);
    $doOp = 1 if ($checkOp eq '<' && $checkRegValue < $checkAmount);
    $doOp = 1 if ($checkOp eq '==' && $checkRegValue == $checkAmount);
    $doOp = 1 if ($checkOp eq '!=' && $checkRegValue != $checkAmount);
    $doOp = 1 if ($checkOp eq '>=' && $checkRegValue >= $checkAmount);
    $doOp = 1 if ($checkOp eq '<=' && $checkRegValue <= $checkAmount);

    if ($doOp) {
        $registers->{$reg} += $amount if ($op eq 'inc');
        $registers->{$reg} -= $amount if ($op eq 'dec');
    }
}

my $max = -1;
for (keys $registers) {
    $max = $registers->{$_} if ($registers->{$_} > $max);
}

print "Max register: $max\n";

__END__

http://adventofcode.com/2017/day/8
