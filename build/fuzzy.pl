#!/usr/bin/perl

use strict;
use warnings;
use Locale::PO;

my %ga;

# existing translations => hash
my $aref = Locale::PO->load_file_asarray('joomla-prev.ga.po');
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
			$id =~ s/^"//;
			$id =~ s/"$//;
			$ga{$ctxt} = $msg->dequote($str);
		}
	}
}
my $aref2 = Locale::PO->load_file_asarray('joomla-1.0.ga.po');
foreach my $msg (@$aref2) {
	my $ctxt = $msg->msgctxt();
	my $id = $msg->msgid();
	my $str = $msg->msgstr();
	if (defined($id) && defined($str) && defined($ctxt)) {
		if ($str and $id and $id ne '""') {
			$ctxt =~ s/^"//;
			$ctxt =~ s/"$//;
			if ($str eq '""') {
				if (exists($ga{$ctxt})) {
					$msg->msgstr($ga{$ctxt});
					$msg->fuzzy(1);
				}
			}
		}
		print $msg->dump;
	}
}

exit 0;
