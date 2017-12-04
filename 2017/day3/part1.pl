#!/usr/bin/env perl

use strict;

use Data::Dumper;

my $input = 277678;

my $num = 2;
my $x = 1;
my $y = 0;
my $row = 1;
my $dir = 'UP';
my $newRow = 0;

my $grid = {};
$grid->{0} = {
    0 => 1,
};

while ($num < $input) {
    $grid->{$x}->{$y} = $num++;

    if ($newRow) {
        $dir = 'UP';
        $newRow = 0;
    } elsif ($x == -1*$row && $dir ne 'DOWN') {
        $dir = 'DOWN';
    } elsif ($y == $row && $dir ne 'LEFT') {
        $dir = 'LEFT';
    } elsif ($y == -1*$row && $dir ne 'RIGHT') {
        $dir = 'RIGHT';
    } elsif ($x == $row && $dir eq 'RIGHT') {
        $row++;
        $dir = 'RIGHT';
        $newRow = 1;
    }

    if ($dir eq 'UP') {
        $y++;
    } elsif ($dir eq 'LEFT') {
        $x--;
    } elsif ($dir eq 'RIGHT') {
        $x++;
    } elsif ($dir eq 'DOWN') {
        $y--;
    }
}

my $endX = $x;
my $endY = $y;
$grid->{$endX}->{$endY} = $input;

=print_grid
print "Grid:\n";
my $places = length("$input");
for ($y = $row; $y >= -1*$row; $y--) {
    for ($x = -1*$row; $x <= $row; $x++) {
        #printf('%d,%d: %2d ', $i, $j, $grid->{$i}->{$j});
        printf("%${places}d ", $grid->{$x}->{$y});
        #print "$x,$y ";
    }
    print "\n";
}
=cut

print "Final x,y: $endX,$endY\n";

my $distance = (abs($endX) + abs($endY));
print "Distance: $distance\n";

__END__

http://adventofcode.com/2017/day/3
