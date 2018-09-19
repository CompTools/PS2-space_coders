#!/bin/bash

#question 1: Finds all flights to and from GNV, select cloumns DEP_DEL15 and ARR_DEL15, sort, count all flights that arrive to GNV 15 mins late or depart from GNV 15 mins late or both.

grep "GNV" ./flights.May2017-Apr2018.csv | awk -F, '{print $13  $16}' | sort | grep -E "0.001.00|1.000.00|1.001.00" -wc

#question 2: Prints flight destination, whether its arrival was delayed, and whether it was due to weather
## Data to Temporary Output File GNVTmp.txt

awk -F, '{if ($3 ~ /GNV/) {print $7,$16,$24}}' flights.May2017-Apr2018.csv > GNVTmp.txt

#Generation of table data

ATLCount=$(grep -wc ATL GNVTmp.txt)
echo $ATLCount

ATLDelay=$(grep ATL GNVTmp.txt | grep -c 1.00)

echo $ATLDelay

ATLWeather=$(awk -F'[ ]' '{
	 if ($3 ~ /[1-9]+[0-9]\.../ && $1 ~ /ATL/)
	{
		print $3
	}
	 else if ($3 ~ /[1-9]\.../ && $1 ~ /ATL/)
	{
		print $3 
	} 
	fi
}' GNVTmp.txt | wc -l )

echo $ATLWeather

CLTCount=$(grep -wc CLT GNVTmp.txt)

echo $CLTCount

CLTDelay=$(grep CLT GNVTmp.txt | grep -c 1.00)
CLTWeather=$(awk -F'[ ]' '{
	 if ($3 ~ /[1-9]+[0-9]\.../ && $1 ~ /CLT/)
	{
		print $3
	}
	 else if ($3 ~ /[1-9]\.../ && $1 ~ /CLT/)
	{
		print $3 
	} 
	fi
}' GNVTmp.txt | wc -l )


MIACount=$(grep -wc MIA GNVTmp.txt)
MIADelay=$(grep MIA GNVTmp.txt | grep -c 1.00)
MIAWeather=$(awk -F'[ ]' '{
	if ($3 ~ /[1-9]+[0-9]\.../ && $1 ~ /MIA/)
{
                print $3
        }
         else if ($3 ~ /[1-9]\.../ && $1 ~ /MIA/)
        {
                print $3
        }
        fi
}' GNVTmp.txt | wc -l )

#Creation of .txt file with proper header and categories (tab-delimited)
printf "Destination\tTotal Flights\tTotal Flights Delayed >15min\tTotal flights delayed due to weather\nATL\t$ATLCount\t$ATLDelay\t$ATLWeather\nCLT\t$CLTCount\t$CLTDelay\t$CLTWeather\nMIA\t$MIACount\t$MIADelay\t$MIAWeather" > FlightTable.txt


#Deletion of Temporary File
rm GNVTmp.txt


#question 3:  select all data from column 3 (ORIGIN) and cloumn 6 (DEST), concatnate both list sort for unique codes.

uniq_airport_codes ()	{

	awk -F, '{print $3}' ./flights.May2017-Apr2018.csv | sort -u > OriginList.txt
	awk -F, '{print $7}' ./flights.May2017-Apr2018.csv | sort -u > DestList.txt
	cat OriginList.txt DestList.txt | sort -u
 
}
uniq_airport_codes


# question 4: find all FL in columns 5 (ORIGIN_CITY_NAME) and columns 9 (DEST_CITY_NAME) print the City name (column 4 and 8) sort for unique cities.

airports_in_florida () {
	
	awk -F, '{if ($5 ~ /FL/) {print $4"\n"}}' ./flights.May2017-Apr2018.csv | awk -F, '{if ($9 ~ /FL/) {print $8"\n"}}' ./flights.May2017-Apr2018.csv | sort -u

}
airports_in_florida








