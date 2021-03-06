#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;

use constant SCRIPTS_DIR	=> '/root/bin/gitjoe/';
use constant SSH_BOY		=> 'root@jozanofastora.xyz';

sub main {
	my $argc = $#ARGV + 1;
	my $called_script = '';
	my $argv_line = '';
	if (
		$ARGV[0] eq 'addsshkey' ||
		$ARGV[0] eq 'newuser' ||
		$ARGV[0] eq 'rmuser' ||
		$ARGV[0] eq 'chdesc' ||
		$ARGV[0] eq 'chowner' ||
		$ARGV[0] eq 'chstate' ||
		$ARGV[0] eq 'newrepo' ||
		$ARGV[0] eq 'rmrepo' ||
		$ARGV[0] eq 'mvrepo'
		) {
		$called_script = SCRIPTS_DIR . $ARGV[0] . '.pl';
	}
	else {
		print colored("Failed!\n", 'bold red')
			. colored($ARGV[0], 'bold yellow')
			. ": unknown script. Known scripts are:\n"
			. colored("addsshkey\n", 'bold green')
			. colored("newuser\n", 'bold green')
			. colored("rmuser\n", 'bold green')
			. colored("chdesc\n", 'bold green')
			. colored("chowner\n", 'bold green')
			. colored("chstate\n", 'bold green')
			. colored("newrepo\n", 'bold green')
			. colored("rmrepo\n", 'bold green')
			. colored("mvrepo\n", 'bold green');
		exit 2;
	}
	print "Calling " . colored($called_script, 'bold green') . " via " . colored(SSH_BOY, 'bold magenta') . ".\n";
	if ($argc > 1) {
		print "Arguments:\n";
		my $i = 1;
		while ($i < $argc) {
			$argv_line = $argv_line . ' "' . $ARGV[$i] . '"';
			print colored($ARGV[$i], 'bold yellow') . "\n";
			$i += 1;
		}
	}
	system(
		'ssh ' . SSH_BOY . " << EOF
" . $called_script . $argv_line . "
exit
EOF
"
		);
	print "Done.\n";
	exit;
}

main();

__END__
