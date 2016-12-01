#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;
use File::Slurp;

die "usage part1.pl filename" unless scalar @ARGV == 1;

my $input = read_file($ARGV[0]);
my $code  = 0;
my $chars = 0;
my $encCodes = 0;
for (split(/\n/, $input)) {
    $code += length $_;

    my $str = $_;
    $str =~ s/\\/\\\\/g;
    $str =~ s/\"/\\"/g;

    $chars += length $str;

    my $esc = $_;
    $esc =~ s/^"(.*)"$/$1/;
    $esc =~ s/\\\\/\\/g;
    $esc =~ s/\\"/\"/g;
    $esc =~ s/\\x[a-fA-F0-9]{2}/!/g;

    $str = "\"$str\"";

    $encCodes += length $str;
}
print "Chars: $chars\n";
print "Codes: $code\n";
print "Encoded: $encCodes\n";

my $newCode = $encCodes - $code;

print "New: $newCode\n";


__END__
