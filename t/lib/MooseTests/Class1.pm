package MooseTests::Class1;

use Moose;

our $VERSION = "0.1";
# test with module versioning too since i wasn't sure version was returned on some moose introspection apis

with "ExtJS::Reflection::Moose";

has attr1 => ( is => "ro", isa => "Str" );

sub results {
    my @fields = (
        { title => "attr1", xtype => "textfield" },
    );

    return {
        simple => [ @fields ],
        hierarchy => [
            {
                'children' => [ @fields ],
                'title' => 'MooseTests::Class1',
                'xtype' => 'fieldgroup'
            },
        ],
    };
}

1;
