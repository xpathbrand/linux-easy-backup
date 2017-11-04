#!/bin/bash

#
#   ██╗  ██╗██████╗  █████╗ ████████╗██╗  ██╗
#   ╚██╗██╔╝██╔══██╗██╔══██╗╚══██╔══╝██║  ██║
#    ╚███╔╝ ██████╔╝███████║   ██║   ███████║
#    ██╔██╗ ██╔═══╝ ██╔══██║   ██║   ██╔══██║
#   ██╔╝ ██╗██║     ██║  ██║   ██║   ██║  ██║
#   ╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝
#                                         


echo -e "\e[0m"
echo -e "\e[40;38;5;82m\nChe percorso vuoi copiare?\e[0m"
read -r percorso

if [[ $percorso == "" ]];
then
	percorso='/home/'$(whoami)
	echo -e "\e[40;38;5;226mOk, uso il mio percorso standard\e[0m"
fi

echo -e "\e[40;38;5;82mChe password metto?\e[0m"
read -r password

if [[ $password == "" ]];
then
	password='12345'
	echo -e "\e[1;38;5;226m!!!! Non hai messo una password. Usero': 12345\e[0m"
fi

cd $percorso
echo -e "\e[93m"
if [[ -f backup_linux_$(date +%Y_%m_%d).7z ]];
then
	echo -e "\e[1;91m[WARN] Questo file esiste gia', lo elimino? (si/no) \e[0m"
	read -r o
	if [[ $o == "si" ]];
		then
			rm backup_linux_$(date +%Y_%m_%d).7z
			echo -e "\e[0m\nFatto :)\n\e[93m"
		else
			echo -e "Esco dal programma...\n\n"
			exit
	fi
fi

7z a -p$password -mhe backup_linux_$(date +%Y_%m_%d).7z

echo -e "\n"
echo -e "\e[40;38;5;226m[INFO] Sto calcolando MD5 del file...\e[0m"
md5sum backup_linux_$(date +%Y_%m_%d).7z > MD5_backup_linux_$(date +%Y_%m_%d).7z.txt

echo -e "\e[40;38;5;82mPer caso vuoi fare una copia senza password? (si/no) \e[0m"
read -r o

if [[ $o == "si" ]];
	then
		echo -e "\e[93m"
		7z a backup_linux_$(date +%Y_%m_%d)_nopassword.7z
		echo -e "\e[0m\nFatto :)\n"
	else
		echo -e "Esco dal programma...\n\n"
		exit
fi

echo -e "\e[0m"