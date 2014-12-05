# Pragmas.
use strict;
use warnings;

# Modules.
use English qw(-no_match_vars);
use Error::Pure::Tags::HTMLCustomPage qw(err);
use Tags::Output::Raw;
use Test::More 'tests' => 5;
use Test::NoWarnings;

# Test.
$Error::Pure::Tags::HTMLCustomPage::TAGS = Tags::Output::Raw->new;
eval {
	err 'Error.';
};
is($EVAL_ERROR, "Error.\n", 'Simple message in eval.');

# Test.
eval {
	err 'Error.';
};
my $tmp = $EVAL_ERROR;
eval {
	err $tmp;
};
is($EVAL_ERROR, "Error.\n", 'More evals.');

# Test.
eval {
	err undef;
};
is($EVAL_ERROR, "undef\n", 'Error undefined value.');

# Test.
eval {
	err ();
};
is($EVAL_ERROR, "undef\n", 'Error blank array.');
