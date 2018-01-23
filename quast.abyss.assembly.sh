#!/bin/bash
for i in /assembly/ec_1963*_adapt

do
folder=$(basename "$i" )


#echo "i is $i"
echo "folder is $folder"

cd $folder
if [ -d abyss ]
then
cd abyss

#Abyss for loop
for k in {41..127..2}
do

if [ -d $k ]
then
if [ -d /quast/${folder}-$k-abyss-quast ]
then
echo "quast done for Abyss ${i}_${k}"
else
quast.py -o ${folder}-$k-abyss-quast --threads 2 -L --gene-finding --fast $k/${folder}-$k-contigs.fa
mv ${folder}-$k-abyss-quast /quast
fi
else
echo "$k doesn't exist for $i"
fi
done # end of k for loop

cd ../ # mv out of abyss dir
else 
echo "no abyss for $i"
fi

cd ../ # mv out of $folder
done # end of batch
