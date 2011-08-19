# Pragmas.
use strict;
use warnings;

# Modules.
use Test::More 'tests' => 2;

BEGIN {

	# Test.
	use_ok('Error::Pure::Output::Tags::HTMLCustomPage');
}

# Test.
require_ok('Error::Pure::Output::Tags::HTMLCustomPage');
