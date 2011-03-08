#!perl -T

use Test::More tests => 2;

BEGIN {
    use_ok( 'ExtJS::Reflection' ) || print "Bail out!
";
    use_ok( 'ExtJS::Reflection::Moose' ) || print "Bail out!
";
}

diag( "Testing ExtJS::Reflection $ExtJS::Reflection::VERSION, Perl $], $^X" );
