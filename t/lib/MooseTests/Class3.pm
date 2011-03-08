package MooseTests::Class3;

use Moose;

extends "MooseTests::Class1";
with "MooseTests::Role1";

with "ExtJS::Reflection::Moose";

has attr3 => ( is => "ro", isa => "Str" );

sub results {
    my @fields = (
            { title => "attr3", xtype => "textfield" },
    );
    return {
        simple => [
            @{ MooseTests::Class1->results()->{simple} },
            @{ MooseTests::Role1->results()->{simple} },
            @fields 
        ],
        hierarchy => [
            @{ MooseTests::Class1->results()->{hierarchy} },
            @{ MooseTests::Role1->results()->{hierarchy} },
            {
                'children' => [ @fields ],
                'title' => 'MooseTests::Class3',
                'xtype' => 'fieldgroup'
            }
        ],
    };
}

1;
