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
		$canal=~s/Ciné/CINE/;
                my $line = `grep -i '^$canal;' channels-vdr-fr.conf|head -n 1`;
                if($line ne ""){
			$entries[$canal_number]=$line;
                } else {
			print STDERR "# MISSING CHANNEL FOR $canal\n";
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
