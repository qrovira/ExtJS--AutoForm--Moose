package MooseTests::Role1;

use Moose::Role;

has rattr1 => ( is => "ro", isa => "Str" );

sub results {
    my @fields = (
            { title => "rattr1", xtype => "textfield" },
    );
    return {
        simple => [ @fields ],
        hierarchy => [
            {
                'children' => [ @fields ],
                'title' => 'MooseTests::Role1',
                'xtype' => 'fieldgroup'
            },
        ],
    };
}

1;
