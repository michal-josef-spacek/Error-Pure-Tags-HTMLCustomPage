#!/usr/bin/env perl

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