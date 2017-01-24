#!/usr/bin/perl -w

use strict;

use LWP::UserAgent;
use Term::ANSIColor;

#Dans le cas de l'erreur de certificat
$ENV{'PERL_LWP_SSL_VERIFY_HOSTNAME'} = 0;

#Mise en place de l'agent utilisateur pour la connexion web
my (@addr , $ip);
my $service = "https://ipv4.wtfismyip.com/";
my $ua = LWP::UserAgent->new();

my $httpRequest = HTTP::Request->new( GET => $service );
my $status = $ua->request($httpRequest);

if ($status->is_success) {
    my $pageContent = $status->decoded_content;
    my @page = split(/ / , $pageContent);

    foreach (@page) {
        chomp;

        #Extraction de l'adresse IP
        if ("$_" =~ m/([0-9]{1,3}\.){3}([0-9]{2,3})/) {
            my $addr = (split(/\>/ , "$_"))[4];
            $ip = join("" , (split(/\</ , $addr))[0]);
            #print "$ip";
        }

    }

}

#Affichage de l'adresse ip cliente
print "Adresse IP: ";
print color 'cyan';
print "$ip\n";
print color 'reset';
