#!/usr/bin/perl

use strict;
use warnings;
use Locale::PO;

my %ga;

my $aref = Locale::PO->load_file_asarray('joomla-1.0.ga.po');
foreach my $msg (@$aref) {
	next if $msg->fuzzy();
	my $ctxt = $msg->msgctxt();
	my $id = $msg->msgid();
	my $str = $msg->msgstr();
	if (defined($id) && defined($str) && defined($ctxt)) {
		if ($str and $id and $id ne '""') {
			next if ($str eq '""');
			$ctxt =~ s/^"//;
			$ctxt =~ s/"$//;
			$str =~ s/^"//;
			$str =~ s/"$//;
			$str =~ s/\\"/"_QQ_"/g;
			$str =~ s/\\\\/\\/g;
			$id =~ s/^"//;
			$id =~ s/"$//;
			$id =~ s/\\"/"_QQ_"/g;
			$id =~ s/\\\\/\\/g;
			#print "Saving key: $ctxt=\"$id\"\n";
			#print "with value: $ctxt=\"$str\"\n";
			$ga{"$ctxt=\"$id\""} = "$ctxt=\"$str\"";
		}
	}
}

# reads original ini.txt
while (<STDIN>) {
	chomp;
	my $line = $_;
	if ($line =~ m/^[A-Z][^ =]+="/) {
		if (exists($ga{$line})) {
			print "$ga{$line}\n";
		}
		else {
			print "$line\n";
		}
	}
	else {
		print "$line\n";   # comments, blanks
	}
}
exit 0;
