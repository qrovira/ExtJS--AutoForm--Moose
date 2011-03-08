use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                 => 'MooseX::ExtJS::Reflection',
    AUTHOR               => q{Quim Rovira <quim@rovira.cat>},
    VERSION_FROM         => 'lib/MooseX/ExtJS/Reflection.pm',
    ABSTRACT_FROM        => 'lib/MooseX/ExtJS/Reflection.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES             => {},
    PREREQ_PM => {
        'Test::More'     => 0,
	'JSON::Any'      => 0,
    },
    dist                 => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean                => { FILES => 'MooseX-ExtJS-Reflection-*' },
);
