#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part1.pl filename wire" unless scalar @ARGV == 2;

my $input = read_file($ARGV[0]);
my $wires = {};
for (split(/\n/, $input)) {
    if (m/^(\d+) -> (.+)$/) {
        $wires->{$2} = $1;
    }

    if (m/^(\D+) -> (.+)$/) {
        $wires->{$2} = {
            op => 'VAL',
            first => $1,
        };
    }

    if (m/^(\S+) (\S+) (\S+) -> (\S+)$/) {
        if ($2 eq 'AND') {
            $wires->{$4} = {
                op => 'AND',
                first => $1,
                second => $3
            };
            #$wires->{$4} = ($wires->{$1} & $wires->{$3}) & 0xffff;
        }

        if ($2 eq 'OR') {
            $wires->{$4} = {
                op => 'OR',
                first => $1,
                second => $3,
            };
            #$wires->{$4} = ($wires->{$1} | $wires->{$3}) & 0xffff;
        }

        if ($2 eq 'LSHIFT') {
            $wires->{$4} = {
                op => 'LSHIFT',
                first => $1,
                second => $3,
            };
            #$wires->{$4} = ($wires->{$1} << $3) & 0xffff;
        }

        if ($2 eq 'RSHIFT') {
            $wires->{$4} = {
                op => 'RSHIFT',
                first => $1,
                second => $3,
            };
            #$wires->{$4} = ($wires->{$1} >> $3) ^ 0xffff;
        }
    }

    if (m/^NOT (\w+) -> (.+)$/) {
        $wires->{$2} = {
            op => 'NOT',
            first => $1,
        };
        #$wires->{$2} = ~$wires->{$1} & 0xffff;
    }
}

sub get_wire
{
    my $name = shift;

    if ($name =~ m/^\d+$/) {
        return $name;
    }

    print "get_wire($name)\n";
    if (!defined $wires->{$name}) {
        print "Unable to find wire: $name\n";
        exit;
    }

    my $wire = $wires->{$name};
    my $result;
    if (ref $wire) {
        if ($wire->{op} eq 'VAL') {
            $result = get_wire($wire->{first});
        }

        if ($wire->{op} eq 'NOT') {
            $result = (~get_wire($wire->{first})) & 0xffff;
        }

        if ($wire->{op} eq 'AND') {
            $result = (get_wire($wire->{first}) & get_wire($wire->{second})) & 0xffff;
        }

        if ($wire->{op} eq 'OR') {
            $result = (get_wire($wire->{first}) | get_wire($wire->{second})) & 0xffff;
        }

        if ($wire->{op} eq 'LSHIFT') {
            $result =  (get_wire($wire->{first}) << $wire->{second}) & 0xffff;
        }

        if ($wire->{op} eq 'RSHIFT') {
            $result = (get_wire($wire->{first}) >> $wire->{second}) & 0xffff;
        }
    } else {
        return int $wire;
    }

    $wire->{$name} = $result;

    return $result;
}

sub has_value
{
    my $name = shift;

    return 1 if ($name =~ m/^\d+$/);
    return (!ref $wires->{$name});
}

sub get_value
{
    my $name = shift;

    return int $name if ($name =~ m/^\d+$/);
    return int $wires->{$name};
}

while (!has_value($ARGV[1])) {
    for my $name (keys %$wires) {
        my $wire = $wires->{$name};
        if (ref $wire) {
            if ($wire->{op} eq 'VAL') {
                if (has_value($wire->{first})) {
                    $wires->{$name} = get_value($wire->{first});
                }
            }

            if ($wire->{op} eq 'NOT') {
                if (has_value($wire->{first})) {
                    $wires->{$name} = ~ get_value($wire->{first}) & 0xffff;
                }
            }

            if ($wire->{op} eq 'AND') {
                if (has_value($wire->{first}) && has_value($wire->{second})) {
                    $wires->{$name} = (get_value($wire->{first}) & get_value($wire->{second})) & 0xffff;
                }
            }

            if ($wire->{op} eq 'OR') {
                if (has_value($wire->{first}) && has_value($wire->{second})) {
                    $wires->{$name} = (get_value($wire->{first}) | get_value($wire->{second})) & 0xffff;
                }
            }

            if ($wire->{op} eq 'LSHIFT') {
                if (has_value($wire->{first}) && has_value($wire->{second})) {
                    $wires->{$name} = (get_value($wire->{first}) << get_value($wire->{second})) & 0xffff;
                }
            }

            if ($wire->{op} eq 'RSHIFT') {
                if (has_value($wire->{first}) && has_value($wire->{second})) {
                    $wires->{$name} = (get_value($wire->{first}) >> get_value($wire->{second})) & 0xffff;
                }
            }
        }
    }
}

#print get_wire($ARGV[1]) . "\n";
print Dumper $wires;
print $wires->{$ARGV[1]} . "\n";

__END__
