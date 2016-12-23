#!/bin/bash

function makeepub() {
	eval in="\"$1\""
	eval out="$2"
	timestamp=$(date +"%Y%m%d")
	echo $in,$out,$timestamp
	ebook-convert "$in" /var/www/calibre/library/$out-$timestamp.epub && ln -sf /var/www/calibre/library/$out-$timestamp.epub /var/www/calibre/$out-latest.epub
}

makeepub "De Gentenaar.recipe" degentenaar
makeepub "De Morgen.recipe" demorgen
makeepub "De Tijd.recipe" detijd
makeepub "De Standaard.recipe" destandaard
makeepub "De Volkskrant.recipe" devolkskrant
makeepub "De Redactie.be.recipe" deredactie
makeepub "Gazet van Antwerpen.recipe" gazetvanantwerpen
makeepub "Het Belang Van Limburg.recipe" hetbelangvanlimburg
makeepub "Wired.recipe" wired
makeepub "The Economist.recipe" theeconomist
makeepub "The Guardian and The Observer.recipe" guardianobserver

#weeklies
makeepub "LWN.net Weekly Edition.recipe" lwnweekly
makeepub "xkcd.recipe" xkcd

#need passwords
#ebook-convert "lwn.recipe" /var/www/calibre/library/lwn-$(date +"%Y%m%d").epub
#ebook-convert /root/mypocket.recipe /var/www/calibre/library/pocket-$(date +"%Y%m%d").epub --user "calibrepocket@davevandijck.fastmail.fm" --password feedme
makeepub /root/mypocket.recipe pocket --user pqvgr --password=asdf
makeepub /root/myfeeds.recipe feeds

chown -R www-data.www-data /var/www/calibre/library

for infile in /var/www/calibre/toconvert/*
do
	ebook-convert "$infile" /var/www/calibre/library/$(basename $infile).epub && rm $infile
done

rm $(find /var/www/calibre/library -mtime +15 )
