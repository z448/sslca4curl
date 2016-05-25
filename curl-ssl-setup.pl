#!/usr/bin/env perl

##########################################################################
##                                                             
##         FILE: curl-setup-ssl.pl
##        USAGE: Add to your ~/.bashrc or export from command line
##               export `curl-ssl-setup.pl`
##  DESCRIPTION: Download and setup Mozilla certificates for curl SSL/TLS
##
##      OPTIONS:  -h for help
## REQUIREMENTS:  perl
##         BUGS:  ---
##        NOTES:  ---
##       AUTHOR:  Zdenek Bohunek (z448), zed448@icloud.com
##      COMPANY:  load.sh laboratory
##      VERSION:  1.0
##      CREATED:  05/25/2016 09:34:33
##     REVISION:  ---
##########################################################################

use warnings;
use strict;

use Getopt::Std;
use Cwd;
use open qw<:encoding(UTF-8)>;

my( %option, $mozilla_ca_path, $mk_ca_bundle_script, $CURL_CA_BUNDLE ) = ();
getopts('h', \%option);

if(defined $option{h}){
    system("perldoc $0");
    die;
}

# setup cpan
$ENV{PERL_MM_USE_DEFAULT}=1;

# use cpan to install Mozilla::CA
open my $pipe,"-|", "perl -MCPAN -e 'install Mozilla::CA'";
close $pipe;

# find Mozilla::CA installed path 
open $pipe,"-|", 'perldoc -l Mozilla::CA';
while(<$pipe>){ $mozilla_ca_path = $_ }
close $pipe;

# find path to mk-ca-bundle.pl
$mk_ca_bundle_script = $mozilla_ca_path;
$mk_ca_bundle_script =~ s/(.*)(\/CA\.pm)/$1/;
$mk_ca_bundle_script = $1;
$mk_ca_bundle_script = "$mk_ca_bundle_script" . '/' . 'mk-ca-bundle.pl';

# execute mk-ca-bundle.pl to download certificates
open $pipe,"-|", "$mk_ca_bundle_script 2>&1";
close $pipe;

# find path to created cacert.pem
my $cwd = getcwd();
chomp $mozilla_ca_path;
$mozilla_ca_path =~ s/(.*)(\.pm)/$1/;
$CURL_CA_BUNDLE = $mozilla_ca_path . '/' . 'cacert.pem';

# make export string
print "CURL_CA_BUNDLE=$CURL_CA_BUNDLE";

=head1 NAME 

=over 12

=item curl-ssl-setup.pl

=back

=head1 SYNOPSIS

=over 12

=item Download and setup Mozilla certificates for curl SSL/TLS

=item e.g fixes error bellow

curl: (60) SSL certificate problem: unable to get local issuer certificate
More details here: http://curl.haxx.se/docs/sslcerts.html

curl performs SSL certificate verification by default, using a "bundle"
of Certificate Authority (CA) public keys (CA certs). If the default
bundle file isn't adequate, you can specify an alternate file
using the --cacert option.
If this HTTPS server uses a certificate signed by a CA represented in
the bundle, the certificate verification probably failed due to a
problem with the certificate (it might be expired, or the name might
not match the domain name in the URL).
If you'd like to turn off curl's verification of the certificate, use
the -k (or --insecure) option.

=back

=head1 EXAMPLE

=over 12

=item C<export `curl-ssl-setup.pl`>

=back

=cut





