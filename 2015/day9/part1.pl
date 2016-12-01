#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part1.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
my $locations = {};
for (split(/\n/, $input)) {
    my ($loc1, $loc2, $dist) = m/^(.+) to (.+) = (\d+)$/;

    add_location($loc1);
    add_location($loc2);

    $locations->{$loc1}->{paths}->{$loc2} = $dist;
    $locations->{$loc2}->{paths}->{$loc1} = $dist;
}

sub add_location
{
    my $name = shift;

    if (!$locations->{$name}) {
        $locations->{$name} = {
            paths => {},
        };
    }
}

sub find_path
{
    my $path = shift;
    my $dist = shift;

    my $currentLoc = $path->[-1];

    my $shortPath;
    my $shortDist = 9999;
    for my $loc (keys %$locations) {
        next if ($loc ~~ @$path);

        my $result = find_path([(@$path, $loc)], ($dist + $locations->{$currentLoc}->{paths}->{$loc}));
        if ($result->{dist} < $shortDist) {
            $shortPath = $result->{path};
            $shortDist = $result->{dist};
        }
    }

    my $newPath = $path;
    my $newDist = $dist;
    if ($shortPath) {
        $newPath = $shortPath;
        $newDist = $shortDist;
    }

    return {
        path => $newPath,
        dist => $newDist,
    };
}

my $shortestPath;
my $shortest = 9999;
for (keys %$locations) {
    my $result = find_path([ $_ ], 0);

    if ($result->{dist} < $shortest) {
        $shortestPath = $result->{path};
        $shortest     = $result->{dist};
    }
}

print "Path: ";
print Dumper $shortestPath;
print "Distance: $shortest\n";

__END__
