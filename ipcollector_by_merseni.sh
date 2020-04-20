#!/bin/bash

# Green : echo -e Default \e[32mGreen
# Red : echo -e Default \e[31mRed
# Yellow :echo -e Default \e[33mYellow
# Blue : echo -e Default \e[34mBlue
# Light Green : echo -e Default \e[92mLight green
# Light Red : echo -e Default \e[91mLight red
# Light Yellow : echo -e "Default \e[93mLight yellow
# Light cyan : echo -e Default \e[96mLight cyan
bannerArt(){
echo ''
echo ''
echo -e "\e[92m @@@  @@@@@@@       @@@@@@@   @@@@@@   @@@       @@@       @@@@@@@@   @@@@@@@  @@@@@@@   @@@@@@   @@@@@@@    @@@@@@"
echo -e "\e[92m @@@  @@@@@@@@     @@@@@@@@  @@@@@@@@  @@@       @@@       @@@@@@@@  @@@@@@@@  @@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@"
echo -e "\e[92m @@!  @@!  @@@     !@@       @@!  @@@  @@!       @@!       @@!       !@@         @@!    @@!  @@@  @@!  @@@  !@@"
echo -e "\e[92m !@!  !@!  @!@     !@!       !@!  @!@  !@!       !@!       !@!       !@!         !@!    !@!  @!@  !@!  @!@  !@!"
echo -e "\e[92m !!@  @!@@!@!      !@!       @!@  !@!  @!!       @!!       @!!!:!    !@!         @!!    @!@  !@!  @!@!!@!   !!@@!!"
echo -e "\e[92m !!!  !!@!!!       !!!       !@!  !!!  !!!       !!!       !!!!!:    !!!         !!!    !@!  !!!  !!@!@!     !!@!!!"
echo -e "\e[92m !!:  !!:          :!!       !!:  !!!  !!:       !!:       !!:       :!!         !!:    !!:  !!!  !!: :!!        !:!"
echo -e "\e[92m :!:  :!:          :!:       :!:  !:!   :!:       :!:      :!:       :!:         :!:    :!:  !:!  :!:  !:!      !:!"
echo -e "\e[92m ::   ::           ::: :::  ::::: ::   :: ::::   :: ::::   :: ::::   ::: :::     ::    ::::: ::  ::   :::  :::: ::"
echo -e "\e[92m :     :            :: :: :   : :  :   : :: : :  : :: : :  : :: ::    :: :: :     :      : :  :    :   : :  :: : :"
}

Usage(){
echo ''
echo -e '\e[33m >>>>>>>>>>  You will find the list of countries in country.txt file !!!!! '
echo -e '\e[33m >>>>>>>>>>  Usage : '
echo ''
echo -e '\e[33m >>>>>>>>>>  ipcollector {name of the country} '
echo -e '\e[33m >>>>>>>>>>  Example : '
echo ''
echo -e '\e[33m >>>>>>>>>> ipcollector CANADA'
}


if [ "$#" -ne 1 ]; then
    echo "You need to specify the country name !!!!!";
    sleep 2;
    Usage;
    exit
fi

bannerArt;
wget -q -O result.txt 'http://services.ce3c.be/ciprg/?countrys='$1'%2C&format=peerguardian&format2=Country+%3A%3A+%7Bcountry%7D%0D%0AStart+IP+of+range+%3A%3A+%7Bstartip%7D%0D%0AEnd+IP+of+range+%3A%3A+%7Bendip%7D%0D%0ANetmask+%3A%3A+%7Bnetmask%7D%0D%0A'

cat result.txt | cut -d ':' -f2 > $1.txt
rm result.txt
total=$(wc -l $1.txt | cut -d ' ' -f1)
touch $1_range.txt
x=1
for ip in $(cat $1.txt)
do
progressing=$(( x * 100 ));
progressing=$(( progressing / total))
echo -ne "COLLECTING $progressing% OF IP RANGES \033[0K\r"
x=$(( x + 1 ))
ipcalc $ip |  grep '/' >> $1_range.txt;
done
rm $1.txt
echo 'COLLECTING ARE DONE ! GUD LUCK  !!!!!!!! < use masscan to target vulnerable ips >'














