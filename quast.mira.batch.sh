#!/bin/bash
for i in /assembly/ec_196[3456]*_adapt

do
folder=$(basename "$i" )


#echo "i is $i"
echo "folder is $folder"

cd $folder
if [ -d mira ]
then
cd mira

quast.py -o ${folder}-mira-quast --threads 2 -L --gene-finding --fast ${folder}_assembly/${folder}_d_results/${folder}_out.unpadded.fasta

mv ${folder}-mira-quast /analysis_192/quast

cd ../ # mv out of mira dir
else 
echo "no mira for $i"
fi

cd ../ # mv out of $folder
done # end of batch
