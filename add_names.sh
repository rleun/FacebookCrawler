#!/bin/bash

for filename in *.csv ; do
    app=$(echo $filename | cut -d'_' -f 1)
    sed -i "s/$/,$app/g" $filename
    sed -i '1d' $filename
done


cat *.csv > out.csv

tr -d '\r' < out.csv > all.csv

rm out.csv
