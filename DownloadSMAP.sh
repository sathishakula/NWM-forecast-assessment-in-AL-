#!/bin/bash
# Get SMAP L4 Global 3-hourly 9 km EASE-Grid Surface and Root Zone Soil Moisture Geophysical Data V004
# https://search.earthdata.nasa.gov/search/granules?p=C1522346899-NSIDC_ECS&tl=1528760255!4!!&q=SMAP%20l4&ac=true
# This script is used to download ACT, ACF and AL state (large domain) SMAP data


attention="PLEASE ATTENTION PLEASE ATTENTION PLEASE ATTENTION!!!"
index=0
while IFS='' read -r line || [[ -n "$line" ]]; do
    myfile[$index]="$line"
    #echo "${myfile[$index]}"
    index=$(($index+1))
done <5000000130338.txt

count=0
index=$(($index-1))
until [ $count -gt $index ]
do   
    outname="/***Please use your own route***/"${myfile[$count]:75:36}""
    wget -O $outname  "${myfile[$count]}"
    count=$(($count+1))
done  

count=0
until [ $count -gt $index ]
do 
      outname="/***Please use your own route***/"${myfile[$count]:75:36}""
      FILESIZE=$(stat -c%s "$outname")
      if [ $FILESIZE -le 200 ]
      then  
         wget -O $outname  "${myfile[$count]}"
      fi  
      count=$(($count+1))
done

count=0
until [ $count -gt $index ]
do 
      outname="/***Please use your own route***/"${myfile[$count]:75:36}""
      FILESIZE=$(stat -c%s "$outname")
      if [ $FILESIZE -le 200 ]
      then  
         wget -O $outname  "${myfile[$count]}"
      fi  
      count=$(($count+1))
done

count=0
until [ $count -gt $index ]
do 
      outname="/***Please use your own route***/"${myfile[$count]:75:36}""
      FILESIZE=$(stat -c%s "$outname")
      if [ $FILESIZE -le 200 ]
      then  
         wget -O $outname  "${myfile[$count]}"
      fi  
      count=$(($count+1))
done

count=0
until [ $count -gt $index ]
do 
      outname="/***Please use your own route***/"${myfile[$count]:75:36}""
      FILESIZE=$(stat -c%s "$outname")
      if [ $FILESIZE -le 200 ]
      then  
         echo $attention
         echo $outname
      fi  
      count=$(($count+1))
done
