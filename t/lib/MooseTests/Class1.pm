package MooseTests::Class1;

use Moose;

our $VERSION = "0.1";
# test with module versioning too since i wasn't sure version was returned on some moose introspection apis

with "ExtJS::Reflection::Moose";

has [qw(class1)] => ( is => "ro", isa => "Str" );

sub results {
    return {
        simple => [
            { title => "class1" },
        ],
        hierarchy => [
            {
                'children' => [
                    { 'title' => 'class1' }
                ],
                'title' => 'MooseTests::Class1',
                'xtype' => 'fieldgroup'
            },
        ],
    };
}

1;
