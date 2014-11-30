#!/usr/bin/perl -w
use strict;
use Encode qw( decode encode );
use WWW::Mechanize;
use POSIX;

my $agent = WWW::Mechanize->new( autocheck => 1 );

# $agent->get("http://www.canalsat.fr/pid1011-toutes-les-chaines.html");
$agent->get("http://www.canalsat.fr/pid2280-toutes-les-chaines.html");

my $source=$agent->content;
$source = decode( 'iso-8859-1', $source );
$source = encode( 'utf-8', $source );

my @entries;
while ($source=~/href="\/pid2640-chaine\.html\?chaine=(\d+)".+?title="(.+?)"/gm){
        my $canal=$2;
	$agent->get("/pid2640-chaine.html?chaine=$1");
	if($agent->content=~/<h2>(.+?)<\/h2>/) {
		$canal=$1;
	} 
	if($agent->content=~/class="canal">canal (\d+)</) {
	    my $canal_number=$1;
            if($canal!~/HD$/ && $canal!~/HD / && $canal_number < 350){
                if($canal eq "13ÈME RUE"){ $canal="13EME RUE"; }
                if($canal eq "SYFY "){ $canal="SYFY"; }
                if($canal eq "CHÉRIE 25"){ $canal="CHERIE 25"; }
                if($canal eq "RMC DÉCOUVERTE"){ $canal="RMC Decouverte"; }
                if($canal eq "FRANCE Ô"){ $canal="FRANCE (null)"; }
                if($canal eq "SERIECLUB"){ $canal="SERIE CLUB"; }
                if($canal eq "AB 1"){ $canal="AB1"; }
                if($canal eq "MTV "){ $canal="MTV FRANCE"; }
                if($canal eq "NATIONAL GEOGRAPHIC CHANNEL"){ $canal="NATIONAL GEO"; }
                if($canal eq "DISCOVERY CHANNEL"){ $canal="DISCOVERY"; }
                if($canal eq "PLANETE\+ NO LIMIT"){ $canal="PLANETE+ NOLIMIT"; }
                if($canal eq "EXTREME SPORTS CHANNEL"){ $canal="EXTREME SPORTS"; }
                if($canal eq "BEIN SPORT 1"){ $canal="beIn SPORT1"; }
                if($canal eq "BEIN SPORT 2"){ $canal="beIn SPORT2"; }
                if($canal eq "I TELE"){ $canal="I>TELE"; }
                if($canal eq "FRANCE 24"){ $canal="France 24 (en Franis)"; }
                if($canal eq "BLOOMBERG TELEVISION"){ $canal="Bloomberg Europe TV"; }
                if($canal eq "CNN INTERNATIONAL "){ $canal="CNN Int."; }
                if($canal eq "BBC WORLD NEWS"){ $canal="BBC World"; }
                if($canal eq "CNBC"){ $canal="CNBC Europe"; }
                if($canal eq "I24NEWS"){ $canal="I24 NEWS"; }
                if($canal eq "L'EQUIPE 21"){ $canal="L EQUIPE 21"; }
                if($canal eq "NICKELODEON JUNIOR"){ $canal="Nick Jr France"; }
                if($canal eq "NICKELODEON"){ $canal="NICKELODEON France"; }
                if($canal eq "DISNEY CHANNEL +1"){ $canal="DISNEY CHANNEL+1"; }
                if($canal eq "TELE TOON+"){ $canal="TELETOON+"; }
                if($canal eq "TELE TOON+1"){ $canal="TELETOON+1"; }
                if($canal eq "MTV BASE"){ $canal="MTV BASE FRANCE"; }
                if($canal eq "M6 BOUTIQUE"){ $canal="M6 BOUTIQUE LA CHAINE"; }
                if($canal eq "PINK TV"){ $canal="PINK TV/PINK X"; }
                if($canal eq "FOOT+"){ $canal="FOOT+ 24/24"; }
                if($canal eq "CANALPLUS A LA DEMANDE"){ $canal="C+ DEMANDE"; }
                if($canal eq "CANALSAT A LA DEMANDE"){ $canal="CSAT DEMANDE"; }
                if($canal eq "NRJ12"){ $canal="NRJ 12"; }
                if($canal eq "Paris Première"){ $canal="PARIS PREMIERE"; }
                if($canal eq "Piwi +"){ $canal="PIWI+"; }
		if($canal eq "13ème Rue"){ $canal="13EME RUE"; }
		if($canal eq "Comédie +"){ $canal="COMEDIE+"; }
		if($canal eq "MTV"){ $canal="MTV FRANCE"; }
		if($canal eq "June TV"){ $canal="JUNE"; }
		if($canal eq "Action"){ $canal="ACTION HD"; }
		if($canal eq "Planète +"){ $canal="PLANETE+"; }
		if($canal eq "Planète + Thalassa"){ $canal="PLANETE+ THALASSA"; }
		if($canal eq "Planète + CI"){ $canal="PLANETE+ CI"; }
		if($canal eq "Planète + A&E"){ $canal="PLANETE+ A&E"; }
		if($canal eq "Disney CINEmagic +1"){ $canal="DISNEY MAGIC+1"; }
		if($canal eq "Discovery Science"){ $canal="DISCOVERY SCIENCE HD"; }
		if($canal eq "National Geographic Channel"){ $canal="NATIONAL GEO"; }
		if($canal eq "RMC Découverte"){ $canal="RMC Decouverte"; }
		if($canal eq "TéléToon +"){ $canal="TELETOON+"; }
		if($canal eq "TéléToon +1"){ $canal="TELETOON+1"; }
		if($canal eq "E !"){ $canal="E!"; }
		if($canal eq "Téva"){ $canal="TEVA"; }
		if($canal eq "France4"){ $canal="FRANCE 4"; }
		if($canal eq "France O"){ $canal="FRANCE Ô"; }
		if($canal eq "TV5 Monde"){ $canal="TV5MONDE EUROPE"; }
		if($canal eq "beIN SPORTS 1"){ $canal="beIN SPORTS 1 HD"; }
		if($canal eq "beIN SPORTS 2"){ $canal="beIN SPORTS 2 HD"; }
		if($canal eq "Golf + - chaine en option"){ $canal="GOLF+ HD"; }
		if($canal eq "L'Equipe 21"){ $canal="L EQUIPE 21"; }
		if($canal eq "Girondons TV"){ $canal="GIRONDINS TV"; }
		if($canal eq "Infosport +"){ $canal="INFOSPORT+"; }
		if($canal eq "Brava HDTV"){ $canal="BRAVA HD"; }
		if($canal eq "Maison +"){ $canal="MAISON+"; }
		if($canal eq "La Chaine Météo"){ $canal="LA CHAINE METEO"; }
		if($canal eq "iTELE"){ $canal="I>TELE"; }
		if($canal eq "LCP - Public Sénat"){ $canal="LCP"; }
		if($canal eq "CNN"){ $canal="CNN Int."; }
		if($canal eq "BBC World News"){ $canal="BBC World"; }
		if($canal eq "Série Club"){ $canal="SERIE CLUB"; }
		if($canal eq "Non Stop People"){ $canal="NON STOP PEOPLE HD"; }
		if($canal eq "J One"){ $canal="J-ONE HD"; }
		if($canal eq "Numéro 23"){ $canal="NUMERO 23"; }
		if($canal eq "Cuisine +"){ $canal="CUISINE+"; }

		$canal=~s/Ciné/CINE/;
                my $line = `grep -i '^$canal;' channels-vdr-fr.conf|head -n 1`;
                if($line ne ""){
			$entries[$canal_number]=$line;
                } else {
			$canal="$canal HD";
                	my $line = `grep -i '^$canal;' channels-vdr-fr.conf|head -n 1`;
                	if($line ne ""){
				$entries[$canal_number]=$line;
                	} else {
			# print STDERR "# MISSING CHANNEL FOR $canal\n";
			print STDERR '# if($canal eq "'.$canal.'"){ $canal=""; }'."\n";
		}
                }
		}
        }
}
open (VDR, '>channels.conf');
open (DM5, '>userbouquet.dbe00.tv');

print DM5 "#NAME Canal Sat (19.2°)\n";
print DM5 "#SERVICE: 1:64:0:0:0:0:0:0:0:0:\n";

foreach my $key (keys @entries) {
	if(defined($entries[$key])){
		my $line=$entries[$key];
		print VDR ":$key\n$line";
		my @fields = split(/:/, $line);
		print DM5 "#SERVICE: 1:0:1:".sprintf("%x",$fields[9]).":".sprintf("%x",$fields[11]).":1:c00000:0:0:0:\n";
	}	
}
print DM5 "#SERVICE: 1:64:15:0:0:0:0:0:0:0:
#DESCRIPTION: --- built on ".strftime ("%F", localtime $^T)." ---
#END_DESCRIPTION
";
 
close(VDR);
close(DM5);
