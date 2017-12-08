#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part1.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
chomp $input;

my $tower = {};

for my $line (split(/\n/, $input)) {
    my ($name, $weight, $holding) = $line =~ m/(\w+) \((\d+)\)(?: -> (.+))?/;

    $tower->{$name} = {
        parent => undef,
        name => $name,
        weight => $weight,
        children => ($holding) ? [ split(/,\s*/, $holding) ] : [],
    };
}

for my $name (keys $tower) {
    for my $child (@{$tower->{$name}->{children}}) {
        $tower->{$child}->{parent} = $name;
    }
}

my $root;
for my $name (keys $tower) {
    if (!$tower->{$name}->{parent}) {
        $root = $name;
    }
}

print "Root: $root\n";

__END__

http://adventofcode.com/2017/day/7
