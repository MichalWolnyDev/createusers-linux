#!/bin/bash
#Zadanie tworzenie uzytkownikow - Michał Wolny K35.2

# sprawdzenie czy skrypt uruchomiony jako root
filename="./lista_uzytkownikow.txt.txt"
function userExists() {
	if id "$1" >/dev/null 2>&1; then	
		return 0
	else
		return 1

	fi
}
function groupExists() {
	local g="$1"
	#echo $g
	if egrep -i "$g" /etc/group >/dev/null 2>&1; then	
		return 0
	else
		return 1
	fi

}

if [ "$(id -u)" != "0" ]; then
	echo "Musisz uruchomic ten skrypt jako root" 1>&2
	exit 1
fi

echo "Wspaniale, uruchomiles skrypt jako root :)"

while IFS=$':' read -r key value; do
	
	#userExists $key
	#groupExists $value
	
	if groupExists $value; then
		echo "istnieje ${value}"
	else
		echo "nie istnieje ${value}"
		groupadd "${value}"
	fi

	#if userExists $key; then
	#	echo "$key istnieje"
	#else
	#	echo "$key nie istnieje"
	#fi

	


	#echo "Uzytkownik: $key Grupa: $value"
done < $filename

