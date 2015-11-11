#!/usr/bin/perl

use strict;
use warnings;

# to avoid repeats
my %enhash;

while (<STDIN>) {
	chomp;
	next if (m/^[#;]/); # comments
	next if (m/^\s*$/); # blank lines
	(my $key, my $en) = m/^([^ =]+)="(.+)"$/;
	if (defined($en)) {   # skip if it looks like: KEY=""
		$en =~ s/ \\ / \\\\ /;  # once
		$en =~ s/\\([\/-])/\\\\$1/g;  # one msgid
		$en =~ s/"_QQ_"/\\"/g;
		unless (exists($enhash{"$key||$en"})) {
			$enhash{"$key||$en"}++;
			print "msgctxt \"$key\"\nmsgid \"$en\"\nmsgstr \"\"\n\n";
		}
	}
}
exit 0;
