#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Lingua::Qaz' ) || print "Bail out!\n";
}

diag( "Testing Lingua::Qaz $Lingua::Qaz::VERSION, Perl $], $^X" );
