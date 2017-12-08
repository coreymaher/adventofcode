#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;
use List::Util qw/max/;

die "usage part2.pl filename" unless scalar @ARGV == 1;

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

getWeight($root);

sub getWeight {
    my $name = shift;

    my $totalWeight = $tower->{$name}->{weight};
    my @childWeights = map { { name => $_, weight => getWeight($_) }; } @{$tower->{$name}->{children}};

    # Find mode
    my $values = {};
    for (@childWeights) {
        $values->{$_->{weight}}++;
    }
    my $max = max values %$values;
    my $weight = 0;
    for (keys $values) {
        if ($values->{$_} == $max) {
            $weight = $_;
            last;
        }
    }
    for (@childWeights) {
        if ($_->{weight} != $weight) {
            print $_->{name} . "\n";
            print "Does not match!\n";
            print "Correct weight: $weight\n";
            print "Total tree weight: " . $_->{weight} . "\n";
            my $childrenWeight = ($_->{weight} - $tower->{$_->{name}}->{weight});
            print "Children weight = total - weight: $childrenWeight\n";
            my $newWeight = $weight - $childrenWeight;
            print "New weight = correct - children: " . $newWeight . "\n";
            $tower->{$_->{name}}->{weight} = $newWeight;
        }

        $totalWeight += $weight;
    }

    return $totalWeight;
}

print "Root: $root\n";

__END__

http://adventofcode.com/2017/day/7
