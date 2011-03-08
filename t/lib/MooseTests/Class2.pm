package MooseTests::Class2;

use Moose;

extends "MooseTests::Class1" => { -version => "0.1" };
# test with module versioning too since i wasn't sure version was returned on some moose introspection apis

with "ExtJS::Reflection::Moose";

has attr2 => ( is => "ro", isa => "Str" );

sub results {
    my @fields = (
            { title => "attr2", xtype => "textfield" },
    );
    return {
        simple => [
            @{ MooseTests::Class1->results()->{simple} },
            @fields
        ],
        hierarchy => [
            @{ MooseTests::Class1->results()->{hierarchy} },
            {
                'children' => [ @fields ],
                'title' => 'MooseTests::Class2',
                'xtype' => 'fieldgroup'
            }
        ],
    };
}

1;
