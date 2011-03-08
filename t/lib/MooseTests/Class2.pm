package MooseTests::Class2;

use Moose;

use MooseTests::Class1;

extends "MooseTests::Class1" => { -version => "0.1" };
# test with module versioning too since i wasn't sure version was returned on some moose introspection apis

with "ExtJS::Reflection::Moose";

has [qw(class2)] => ( is => "ro", isa => "Str" );

sub results {
    return {
        simple => [
            @{ MooseTests::Class1->results()->{simple} },
            { title => "class2" },
        ],
        hierarchy => [
            @{ MooseTests::Class1->results()->{hierarchy} },
            {
                'children' => [
                    { 'title' => 'class2' }
                ],
                'title' => 'MooseTests::Class2',
                'xtype' => 'fieldgroup'
            }
        ],
    };
}

1;
