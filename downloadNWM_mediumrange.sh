#!/bin/bash
# Get NWM short, medium, and long range forecast data
# http://www.nco.ncep.noaa.gov/pmb/products/nwm/
# This script is used to download one day forecast

# download one day channel routing forecast index.html

rm index.html*
rm origionalnamechannel.txt
rm origionalnameland.txt

attention="PLEASE ATTENTION PLEASE ATTENTION PLEASE ATTENTION!!!"

bechan=0
beland=0

yesterday=$(date -d "-1 day" +%Y%m%d)
today=$(date +'%Y%m%d')
site="ftp://ftp.ncep.noaa.gov/pub/data/nccf/com/nwm/prod/nwm."$yesterday"/medium_range/"
wget $site
grep "channel_rt" index.html>origionalnamechannel.txt

index=0
while IFS='' read -r line || [[ -n "$line" ]]; do
    myfile[$index]="$line"
    #echo "${myfile[$index]}"
    index=$(($index+1))
done < origionalnamechannel.txt

count=$bechan
index=$(($index-1))
until [ $count -gt $index ]
do   
    outname="//***Please use your own route***//"${myfile[$count]:100:8}""${myfile[$count]:125:6}""${myfile[$count]:144:24}""
    wget -O $outname  "${myfile[$count]:42:126}"
    count=$(($count+1))
done  

count=$bechan
until [ $count -gt $index ]
do 
    outname="//***Please use your own route***//"${myfile[$count]:100:8}""${myfile[$count]:125:6}""${myfile[$count]:144:24}""
    FILESIZE=$(stat -c%s "$outname")
    if [ $FILESIZE -le 2000 ]
    then  
        wget -O $outname  "${myfile[$count]:42:126}"
    fi  
    count=$(($count+1))
done

count=$bechan
until [ $count -gt $index ]
do 
    outname="//***Please use your own route***//"${myfile[$count]:100:8}""${myfile[$count]:125:6}""${myfile[$count]:144:24}""
    FILESIZE=$(stat -c%s "$outname")
    if [ $FILESIZE -le 2000 ]
    then  
        echo $attention
        echo $outname
    fi  
    count=$(($count+1))
done
#------------------------------------------------------------------------------------------------------------------------------------------------
# download one day Land Output forecast index.html
grep ".land." index.html>origionalnameland.txt

index=0
while IFS='' read -r line || [[ -n "$line" ]]; do
    myfile[$index]="$line"
    #echo "${myfile[$index]}"
    index=$(($index+1))
done < origionalnameland.txt

count=$beland
index=$(($index-1))
until [ $count -gt 81 ]
do   
    outname="//***Please use your own route***//"${myfile[$count]:100:8}""${myfile[$count]:125:6}""${myfile[$count]:144:18}""
    wget -O $outname  "${myfile[$count]:42:120}"
    count=$(($count+1))
done  

count=$beland
until [ $count -gt 81 ]
do 
      outname="//***Please use your own route***//"${myfile[$count]:100:8}""${myfile[$count]:125:6}""${myfile[$count]:144:18}""
      FILESIZE=$(stat -c%s "$outname")
      if [ $FILESIZE -le 2000 ]
      then  
         wget -O $outname  "${myfile[$count]:42:120}"
      fi  
      count=$(($count+1))
done

count=$beland
until [ $count -gt 81 ]
do 
      outname="//***Please use your own route***//"${myfile[$count]:100:8}""${myfile[$count]:125:6}""${myfile[$count]:144:18}""
      FILESIZE=$(stat -c%s "$outname")
      if [ $FILESIZE -le 2000 ]
      then  
         echo $attention
         echo $outname
      fi  
      count=$(($count+1))
done
