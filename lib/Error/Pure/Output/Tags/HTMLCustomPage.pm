package Error::Pure::Output::Tags::HTMLCustomPage;

# Pragmas.
use base qw(Exporter);
use strict;
use warnings;

# Modules.
use HTTP::Headers::Fast;
use Readonly;

# Constants.
Readonly::Array our @EXPORT_OK => qw(err_pretty);
Readonly::Scalar my $EMPTY_STR => q{};
Readonly::Scalar my $SPACE => q{ };

# Version.
our $VERSION = 0.01;

# Pretty print.
sub err_pretty {
	my ($tags_obj, $encoding, $content_type, $xml_version,
		$tags_structure_ar) = @_;

	# Reset.
	$tags_obj->reset;

	my $header = HTTP::Headers::Fast->new;
	$header->header(
		'Cache-Control' => 'no-cache',
		'Content-Type' => $content_type,
	);
	$header->date(time);
	$tags_obj->put(['r', $header->as_string."\n"]);

	# Debug from Tags object.
	my $debug = $tags_obj->{'set_indent'};

	# XML tag.
	$tags_obj->put(
		['i', 'xml', 'version="'.$xml_version.'" encoding="'.$encoding.
			'" standalone="no"'],
	);
	if ($debug) {
		$tags_obj->put(['r', "\n"]);
	}

	# DTD.
	my @dtd = (
		'<!DOCTYPE html',
		'PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"',
		'"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">',
	);
	my ($separator, $linebreak) = ($SPACE, $EMPTY_STR);
	if ($debug) {
		$separator = "\n".$tags_obj->{'next_indent'};
		$linebreak = "\n";
	}
	$tags_obj->put(['r', (join $separator, @dtd).$linebreak]);

	# Main page.
	my @tmp = @{$tags_structure_ar};
	$tags_obj->put(@tmp);

	# Ok.
	return 1;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

Error::Pure::Output::Tags::HTMLCommonPage - TODO

=head1 SYNOPSIS

TODO

=head1 SUBROUTINES

=over 8

=item B<err_pretty()>

TODO

=back

=head1 EXAMPLE

TODO

=head1 DEPENDENCIES

L<HTTP::Headers::Fast>,
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
