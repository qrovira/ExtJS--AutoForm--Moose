package MooseTests::Class0;

use Moose;
use JSON::Any;

with "ExtJS::Reflection::Moose";

for (qw(Str Num Int Bool)) {
    has lc($_) => ( is => "rw", isa => $_ );
}

sub results {
    my @fields = (
        { title => "str", xtype => "textfield" },
        { title => "num", xtype => "numberfield", allowDecimals => JSON::Any::true },
        { title => "int", xtype => "numberfield", allowDecimals => JSON::Any::false },
        { title => "bool", xtype => "checkbox" },
    );

    return {
        simple => [ @fields ],
        hierarchy => [
            {
                'children' => [ @fields ],
                'title' => 'MooseTests::Class0',
                'xtype' => 'fieldgroup'
            },
        ],
    };
}

1;
