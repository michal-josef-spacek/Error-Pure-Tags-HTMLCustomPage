# Pragmas.
use strict;
use warnings;

# Modules.
use inc::Module::Install;

# Definition.
abstract 'Perl module for structured errors. HTMLCustomPage version.';
author 'Michal Špaček <skim@cpan.org>';
license 'bsd';
name 'Error-Pure-Tags-HTMLCustomPage';
requires 'Exporter' => 0;
requires 'Error::Pure::Die' => 0.05;
requires 'Error::Pure::Utils' => 0.05;
requires 'HTTP::Headers::Fast' => 0;
requires 'Indent::PerlStruct' => 0.01;
requires 'List::MoreUtils' => 0;
requires 'Readonly' => 0;
resources 'bugtracker' => 'https://rt.cpan.org/Public/Dist/Display.html'.
	'?Name=Error-Pure-Tags-HTMLCustomPage';
resources 'homepage' => 'https://github.com/tupinek/'.
	'Error-Pure-Tags-HTMLCustomPage';
resources 'repository' => 'git://github.com/tupinek/'.
	'Error-Pure-Tags-HTMLCustomPage';
test_requires 'Cwd' => 0;
test_requires 'English' => 0;
test_requires 'File::Spec::Functions' => 0;
test_requires 'FindBin' => 0;
test_requires 'Test::More' => 0;
test_requires 'Test::Pod' => 0;
test_requires 'Test::Pod::Coverage' => 0;
tests_recursive;
version '0.01';

# Run.
WriteAll();
