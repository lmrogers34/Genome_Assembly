#!/bin/bash
for i in /assembly/ec_1963*_adapt

do
folder=$(basename "$i" )


#echo "i is $i"
echo "folder is $folder"

cd $folder
if [ -d soapdenovo2 ]
then
cd soapdenovo2

for m in *
do
if [ -d "$m" ]
then
quast.py -o ${m}-soap-quast --threads 2 -L --gene-finding --fast ${m}/${m}.contig
mv ${m}-soap-quast /quast
fi
done


cd ../ # mv out of soap dir
else 
echo "no soapdenovo2 for $i"
fi
cd ../ # mv out of $folder
done # end of batch

