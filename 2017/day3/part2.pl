#!/usr/bin/env perl

use strict;

use Data::Dumper;

my $input = 277678;

my $x = 1;
my $y = 0;
my $row = 1;
my $dir = 'UP';
my $newRow = 0;

my $grid = {};
$grid->{0} = {
    0 => 1,
};

my $num = 0;
while ($num < $input) {
    $num = 0;
    $num += $grid->{$x+1}->{$y} if (exists($grid->{$x+1}->{$y}));
    $num += $grid->{$x-1}->{$y} if (exists($grid->{$x-1}->{$y}));
    $num += $grid->{$x}->{$y+1} if (exists($grid->{$x}->{$y+1}));
    $num += $grid->{$x}->{$y-1} if (exists($grid->{$x}->{$y-1}));
    $num += $grid->{$x+1}->{$y-1} if (exists($grid->{$x+1}->{$y-1}));
    $num += $grid->{$x+1}->{$y+1} if (exists($grid->{$x+1}->{$y+1}));
    $num += $grid->{$x-1}->{$y-1} if (exists($grid->{$x-1}->{$y-1}));
    $num += $grid->{$x-1}->{$y+1} if (exists($grid->{$x-1}->{$y+1}));

    $grid->{$x}->{$y} = $num;

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

print "First num greater than input: $num\n";

__END__

http://adventofcode.com/2017/day/3
