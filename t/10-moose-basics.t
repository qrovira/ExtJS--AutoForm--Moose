#!perl -T

use Test::More tests => 36;
use Data::Dumper;

use lib "t/lib";

my @res;

for my $cn (0..3) {
    # load test class
    use_ok("MooseTests::Class$cn");
    my $RESULTS = eval("return MooseTests::Class$cn\-\>results()");

    # simple reflection, through classname
    eval("\@res = MooseTests::Class$cn\-\>extjs_form;");
    ok( !$@, "Reflection of MooseTests::Class$cn through package" )
        or diag("Error: $@");
    is_deeply( \@res, $RESULTS->{simple}, "Data comparison 1 on MooseTests::Class$cn" )
        or diag("Bogus definition: ".Dumper(\@res));

    # simple reflection, through object instance
    eval("my \$tc = MooseTests::Class$cn\-\>new(); \@res = \$tc->extjs_form;");
    ok( !$@, "Reflection of MooseTests::Class$cn through object instance" )
        or diag("Error: $@");
    is_deeply( \@res, $RESULTS->{simple}, "Data comparison 2 on MooseTests::Class$cn" )
        or diag("Bogus definition: ".Dumper(\@res));

    # hierarchy-aware reflection, through classname
    eval("\@res = MooseTests::Class$cn\-\>extjs_form( 'hierarchy' => 1 );");
    ok( !$@, "Reflection of MooseTests::Class$cn through package using hierarchy" )
        or diag("Error: $@");
    is_deeply( \@res, $RESULTS->{hierarchy}, "Data comparison 3 on MooseTests::Class$cn" )
        or diag("Bogus definition: ".Dumper(\@res));

    # hierarchy-aware reflection, through object instance
    eval("my \$tc = MooseTests::Class$cn\-\>new(); \@res = \$tc->extjs_form( 'hierarchy' => 1 );");
    ok( !$@, "Reflection of MooseTests::Class$cn through object instance using hierarchy" )
        or diag("Error: $@");
    is_deeply( \@res, $RESULTS->{hierarchy}, "Data comparison 4 on MooseTests::Class$cn" )
        or diag("Bogus definition: ".Dumper(\@res));
}


