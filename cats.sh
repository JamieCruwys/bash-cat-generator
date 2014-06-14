#!/bin/bash
source menu.sh

declare -a options=("Hell Yeah!" "No thanks");

function getCats() 
{
	xml=$(curl -s 'http://thecatapi.com/api/images/get?format=xml&results_per_page=1&type=jpg' -o outfile.xml)
	file=$(sed -n -e 's/.*<url>\(.*\)<\/url>.*/\1/p' outfile.xml)
	curl -s $file -o cat.jpg
	rm outfile.xml
	open cat.jpg
	askForCats
}

function askForCats()
{
	clear
	generateDialog "options" "Would you like to see cats?" "${options[@]}"

	read choice
	case $choice in
		1) getCats; ;;
		2) rm cat.jpg&>- exit 0;;
		*) askForCats ;;
	esac
}

askForCats;
