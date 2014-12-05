# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Pure::Tags::HTMLCustomPage;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($Error::Pure::Tags::HTMLCustomPage::VERSION, 0.04, 'Version.');
