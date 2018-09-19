#!/bin/bash

#question 1: Finds all flights to and from GNV, select cloumns DEP_DEL15 and ARR_DEL15, sort, count all flights that arrive to GNV 15 mins late or depart from GNV 15 mins late or both.

grep "GNV" ./flights.May2017-Apr2018.csv | awk -F, '{print $13  $16}' | sort | grep -E "0.001.00|1.000.00|1.001.00" -wc

#question 2: Fi


#question 3: 

# select all data from column 3 (ORIGIN) and cloumn 6 (DEST), concatnate both list sort for unique codes.

uniq_airport_codes ()	{

	awk -F, '{print $3}' ./flights.May2017-Apr2018.csv > OriginList.txt
	awk -F, '{print $7}' ./flights.May2017-Apr2018.csv > DestList.txt
	cat OriginList.txt DestList.txt | sort -u 
 
}


uniq_airport_codes


# question 4: 

airports_in_florida () {
	
	grep "FL"   






