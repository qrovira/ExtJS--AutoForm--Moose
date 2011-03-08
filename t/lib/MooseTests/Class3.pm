package MooseTests::Class3;

use Moose;

extends "MooseTests::Class1";
with "MooseTests::Role1";

with "ExtJS::Reflection::Moose";

has [qw(class3)] => ( is => "ro", isa => "Str" );

sub results {
    return {
        simple => [
            @{ MooseTests::Class1->results()->{simple} },
            @{ MooseTests::Role1->results()->{simple} },
            { title => "class3" },
        ],
        hierarchy => [
            @{ MooseTests::Class1->results()->{hierarchy} },
            @{ MooseTests::Role1->results()->{hierarchy} },
            {
                'children' => [
                    { 'title' => 'class3' }
                ],
                'title' => 'MooseTests::Class3',
                'xtype' => 'fieldgroup'
            }
        ],
    };
}

1;
