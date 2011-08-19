package Error::Pure::Tags::HTMLCustomPage;

# Pragmas.
use base qw(Exporter);
use strict;
use warnings;

# Modules.
use Error::Pure::Die;
use Error::Pure::Utils qw(err_helper);
use Error::Pure::Output::Tags::HTMLCustomPage qw(err_pretty);
use List::MoreUtils qw(none);
use Readonly;

# Constants.
Readonly::Array our @EXPORT_OK => qw{err};
Readonly::Scalar my $EMPTY => q{};
Readonly::Scalar my $EVAL => 'eval {...}';

# Version.
our $VERSION = 0.01;

# Content type.
our $CONTENT_TYPE = 'application/xhtml+xml';

# Encoding.
our $ENCODING = 'UTF-8';

# Tags object.
our $TAGS = $EMPTY;

# Tags structure.
our $TAGS_STRUCTURE_AR = [
	'html',
	'head',
	'title',
	\'Error',
	'end_title',
	'end_head',
	'body',
	'div',
	\'Error on page',
	'end_div',
	'end_body',
	'end_html',
];

# XML version.
our $XML_VERSION = '1.1';

# Process error.
sub err {
	my @msg = @_;

	# Check to Tags object.
	if (! $TAGS) {
		Error::Pure::Die::err('Bad Tags object');
	}

	# Errors.
	my @errors = err_helper(@msg);

	# Finalize in main on last err.
	my $stack_ar = $errors[-1]->{'stack'};
	if ($stack_ar->[-1]->{'class'} eq 'main'
		&& none { $_ eq $EVAL || $_ =~ /^eval '/ms}
		map { $_->{'sub'} } @{$stack_ar}) {

		err_pretty($TAGS, $ENCODING, $CONTENT_TYPE, $XML_VERSION,
			$TAGS_STRUCTURE_AR);

	# Die for eval.
	} else {
		die "$msg[0]\n";
	}

	return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

Error::Pure::Tags::HTMLCustomPage - TODO

=head1 SYNOPSIS

TODO

=head1 SUBROUTINES

=over 8

=item B<err()>

TODO

=back

=head1 EXAMPLE

TODO

=head1 DEPENDENCIES

L<Error::Pure::Die(3pm)>,
L<Error::Pure::Utils(3pm)>,
L<Error::Pure::Output::Tags::HTMLCustomPage(3pm)>,
L<Exporter(3pm)>,
L<List::MoreUtils(3pm)>,
L<Readonly(3pm)>.

=head1 SEE ALSO

L<Error::Pure(3pm)>.

=head1 AUTHOR

Michal Špaček L<skim@cpan.org>

=head1 LICENSE AND COPYRIGHT

 BSD license.

=head1 VERSION

0.01

=cut
