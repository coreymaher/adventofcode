#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part1.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
my $code  = 0;
my $chars = 0;
for (split(/\n/, $input)) {
    print "$_\n";
    $code += length $_;

    my $str = $_;
    $str =~ s/^"(.*)"$/$1/;
    $str =~ s/\\\\/\\/g;
    $str =~ s/\\"/\"/g;
    $str =~ s/\\x[a-fA-F0-9]{2}/!/g;

    $chars += length $str;

    print "$str\n";
}
print "Chars: $chars\n";
print "Codes: $code\n";

print $code - $chars . "\n";

__END__
