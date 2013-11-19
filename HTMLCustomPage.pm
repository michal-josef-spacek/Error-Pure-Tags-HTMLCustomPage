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
	['b', 'html'],
	['b', 'head'],
	['b', 'title'],
	['d', 'Error'],
	['e', 'title'],
	['e', 'head'],
	['b', 'body'],
	['b', 'div'],
	['d', 'Error on page'],
	['e', 'div'],
	['e', 'body'],
	['e', 'html'],
];

# XML version.
our $XML_VERSION = '1.1';

# Process error.
sub err {
	my @msg = @_;

	# Check to Tags object.
	if (! $TAGS) {
		Error::Pure::Die::err('Bad \'Tags\' object');
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
		print $TAGS->flush;

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

Error::Pure::Tags::HTMLCustomPage - Error::Pure module with output as Tags custom page.

=head1 SYNOPSIS

 use Error::Pure::Tags::HTMLCustomPage qw(err);
 err 'This is a fatal error.', 'name', 'value';

=head1 SUBROUTINES

=over 8

=item C<err(@messages)>

 Process error with messages @messages.

=back

=head1 VARIABLES

=over 8

=item C<$CONTENT_TYPE>

 Content type.
 Default value is 'application/xhtml+xml'.

=item C<$ENCODING>

 Encoding.
 Default value is 'UTF-8'.

=item C<$TAGS>

 Tags object.
 It is required.
 Default value is ''.

=item C<$TAGS_STRUCTURE_AR>

 Tags structure.
 Default value is: [
         ['b', 'html'],
         ['b', 'head'],
         ['b', 'title'],
         ['d', 'Error'],
         ['e', 'title'],
         ['e', 'head'],
         ['b', 'body'],
         ['b', 'div'],
         ['d', 'Error on page'],
         ['e', 'div'],
         ['e', 'body'],
         ['e', 'html'],
 ];

=item C<$XML_VERSION>

 XML version.
 Default value is '1.1'.

=back

=head1 EXAMPLE1

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use Error::Pure::Tags::HTMLCustomPage qw(err);

 # Error.
 err "1";

 # Output like:
 # Bad 'Tags' object at %s/HTMLCustomPage.pm line 56.

=head1 EXAMPLE2

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use Error::Pure::Tags::HTMLCustomPage qw(err);
 use Tags::Output::Raw;

 # Tags object.
 $Error::Pure::Tags::HTMLCustomPage::TAGS = Tags::Output::Raw->new;

 # Error.
 err "1";

 # Output like:
 # Cache-Control: no-cache
 # Date: Tue, 19 Nov 2013 13:05:29 GMT
 # Content-Type: application/xhtml+xml
 #
 # <?xml version="1.1" encoding="UTF-8" standalone="no"?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"><html><head><title>Error</title></head><body><div>Error on page</div></body></html>

=head1 EXAMPLE3

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use Error::Pure::Tags::HTMLCustomPage qw(err);
 use Tags::Output::Indent;

 # Tags object.
 $Error::Pure::Tags::HTMLCustomPage::TAGS = Tags::Output::Indent->new;

 # Error.
 err "1";

 # Output like:
 # Cache-Control: no-cache
 # Date: Tue, 19 Nov 2013 13:10:44 GMT
 # Content-Type: application/xhtml+xml
 #
 # <?xml version="1.1" encoding="UTF-8" standalone="no"?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"><html>
 #   <head>
 #     <title>
 #       Error
 #     </title>
 #   </head>
 #   <body>
 #     <div>
 #       Error on page
 #     </div>
 #   </body>
 # </html>

=head1 DEPENDENCIES

L<Error::Pure::Die>,
L<Error::Pure::Utils>,
L<Error::Pure::Output::Tags::HTMLCustomPage>,
L<Exporter>,
L<List::MoreUtils>,
L<Readonly>.

=head1 SEE ALSO

L<Error::Pure>.

=head1 AUTHOR

Michal Špaček L<skim@cpan.org>

=head1 LICENSE AND COPYRIGHT

 BSD license.

=head1 VERSION

0.01

=cut
