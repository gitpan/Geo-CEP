
use strict;
use warnings;

BEGIN { require 5.008; }

use ExtUtils::MakeMaker 6.30;

use File::ShareDir::Install;
install_share dist => "share";


my %WriteMakefileArgs = (
  'ABSTRACT' => 'Resolve Brazilian city data for a given CEP',
  'AUTHOR' => 'Stanislaw Pusep <stas@sysd.org>',
  'BUILD_REQUIRES' => {},
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.30',
    'File::ShareDir::Install' => '0.03'
  },
  'DISTNAME' => 'Geo-CEP',
  'EXE_FILES' => [
    'bin/cep2city'
  ],
  'LICENSE' => 'perl',
  'NAME' => 'Geo::CEP',
  'PREREQ_PM' => {
    'File::ShareDir' => '0',
    'Moose' => '0',
    'Pod::Usage' => '0',
    'Text::CSV' => '0',
    'common::sense' => '0'
  },
  'VERSION' => '0.3',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

package
MY;
use File::ShareDir::Install qw(postamble);


