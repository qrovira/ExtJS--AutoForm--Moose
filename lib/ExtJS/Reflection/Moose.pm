package ExtJS::Reflection::Moose;

use warnings;
use strict;

use Moose::Exporter;
use Moose::Util::TypeConstraints;
use Module::Loaded qw(is_loaded);

use namespace::autoclean;
use JSON::Any;

Moose::Exporter->setup_import_methods(
    as_is => [ qw(
        extjs reflect
    ) ],
);

my %EXTJS_DEFINITIONS = ();

=head1 NAME

ExtJS::Reflection::Moose - The great new ExtJS::Reflection::Moose!

=cut

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use ExtJS::Reflection::Moose;

    my $foo = ExtJS::Reflection::Moose->new();
    ...

=cut

=head1 SUBROUTINES/METHODS

=cut


#
# SYNTAX CURRY
#
sub extjs($) { { extjs => $_[0]  } }

sub reflect($$) {
    my $type_name = shift;
    my %p = map { %{$_} } @_; #really useless here. done this way since I was hoping to extend own Moose (sub)type sugar

    if($EXTJS_DEFINITIONS{$type_name})
    { _confess("The type reflection to extjs for type $type_name already exists"); }

    $EXTJS_DEFINITIONS{$type_name} = $p{extjs};
}

reflect 'Str'  => extjs { xtype => "textfield" };
reflect 'Num'  => extjs { xtype => "numberfield", allowDecimals => JSON::Any::true };
reflect 'Int'  => extjs { xtype => "numberfield", allowDecimals => JSON::Any::false };
reflect 'Bool' => extjs { xtype => "checkbox" };



#
# REFLECTION ROLE
#

use Moose::Role;

#IDEA: We should allow memoizing this shit using an import option, since in most cases, classes do not dynamically change
#      at runtime, and recursion cost is really unnecessary.
#      Yet, consider memory usage, and maybe implement some kind of specific (compressed?) caching
sub extjs_form {
    my $self = shift;
    my $meta = Class::MOP::Class->initialize(ref($self) || $self);
    my $options = {@_};

    return _recursive_reflect( $meta, $self, $options );
}

sub json_extjs_form {
    my $self = shift;
    return JSON::Any->objToJson($self->extjs_form(@_));
}

no Moose::Role; # will this keep internals from class definition?


sub _recursive_reflect {
    my ($meta, $class, $options, $done) = @_;
    my @extjs = ();
    $done ||= {pkgs => {}, attributes => {}};

    $done->{pkgs}{$meta->name} = 1;

    # Recurse superclasses when possible
    if($meta->can("superclasses")) {
        foreach my $pkg ($meta->superclasses) {
            my $meta = Class::MOP::Class->initialize($pkg);
            next if $done->{pkgs}{$meta->name};
            push @extjs, _recursive_reflect($meta, $class, $options, $done);
            $done->{pkgs}{$meta->name} = 1;
        }
    }

    # Recurse roles
    foreach my $pkg ($meta->calculate_all_roles) {
        next if $done->{pkgs}{$pkg->name};
        push @extjs, _recursive_reflect($pkg, $class, $options, $done);
        $done->{pkgs}{$pkg->name} = 1;
    }

    # Parse class attributes
    my @atts = ();
    foreach my $at ( sort { $a->insertion_order <=> $b->insertion_order } map { $meta->get_attribute($_) } $meta->get_attribute_list ) {
        next if $done->{attributes}{$at->name};
        push @atts, _attribute_to_extjs($at, $options);
        $done->{attributes}{$at->name} = 1;
    }

    if( $options->{hierarchy} ) {
        # If any, wrap them up in a field group with class/role name
        if(@atts) {
            push @extjs, {
                xtype => "fieldgroup",
                title => _cleanup_package_name($meta->name, $options),
                children => [@atts],
            };
        }
    } else {
        push @extjs, @atts;
    }

    return @extjs;
}

sub _attribute_to_extjs {
    my ($attribute, $options) = @_;
    my @extjs = ();

    push @extjs, {
        title => _cleanup_attribute_name($attribute->name, $options),
    };

    return @extjs;
}

sub _cleanup_package_name($$) {
    my ($name, $options) = @_;
    my $n = $name; # Does this really affect on inlining decision?

    if($options->{strip}) {
        $n =~ s#^$options->{strip}##;
    }

    if($options->{cleanup} && $options->{cleanup} eq "cute") {
        $n =~ s#::# #g;
    } elsif(ref($options->{cleanup}) eq "CODE")  {
        $n = $options->{cleanup}->($n);
    }

    return $n;
}

sub _cleanup_attribute_name($$) {
    my ($name, $options) = @_;
    my $n = $name;

    return $n;
}


# Util method stolen literally from Moose::Util::TypeConstraint
sub _confess {
    my $error = shift;

    local $Carp::CarpLevel = $Carp::CarpLevel + 1;
    Carp::confess($error);
}

=head1 AUTHOR

Quim Rovira, C<< quim at rovira.cat >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-extjs-reflection at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=ExtJS-Reflection>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc ExtJS::Reflection::Moose


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=ExtJS-Reflection>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/ExtJS-Reflection>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/ExtJS-Reflection>

=item * Search CPAN

L<http://search.cpan.org/dist/ExtJS-Reflection/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Quim Rovira.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of ExtJS::Reflection::Moose
