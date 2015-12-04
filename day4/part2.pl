#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

use Digest::MD5 qw/md5_hex/;

my $input = 'iwrupvqb';
my $num = 1;
while (1) {
    my $hash = md5_hex($input . $num);

    if ($hash =~ m/^0{6}/) {
        print "Num: $num\n";
        last;
    }
    $num++;
}


__END__

Now find one that starts with six zeroes.
