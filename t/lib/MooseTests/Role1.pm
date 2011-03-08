package MooseTests::Role1;

use Moose::Role;

has [qw(role1)] => ( is => "ro", isa => "Str" );

sub results {
    return {
        simple => [
            { title => "role1" },
        ],
        hierarchy => [
            {
                'children' => [
                    { 'title' => 'role1' }
                ],
                'title' => 'MooseTests::Role1',
                'xtype' => 'fieldgroup'
            },
        ],
    };
}

1;
