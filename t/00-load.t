#!perl -T

use Test::More tests => 3;

BEGIN {
    use_ok( 'MooseX::ExtJS::Reflection' ) || print "Bail out!
";
    use_ok( 'MooseX::ExtJS::Reflection::Types' ) || print "Bail out!
";
    use_ok( 'MooseX::ExtJS::Reflection::Util' ) || print "Bail out!
";
}

diag( "Testing ExtJS::Reflection $MooseX::ExtJS::Reflection::VERSION, Perl $], $^X" );
