#!/bin/bash
#for i in /store2/pog/analysis_192/assembly/ec_196[3456]*_adapt
#for i in /store2/pog/analysis_192/assembly/ec_196[789]*_adapt
#for i in /store2/pog/analysis_192/assembly/ec_197*_adapt
#for i in /store2/pog/analysis_192/assembly/ec_219[234]*_adapt
for i in /store2/pog/analysis_192/assembly/ec_219[789]*_adapt
do
folder=$(basename "$i" )


#echo "i is $i"
echo "folder is $folder"

cd $folder
if [ -d mira ]
then
cd mira


quast.py -o ${folder}-$k-abyss-quast --threads 2 -L --gene-finding --fast $k/${folder}-$k-contigs.fa

quast.py -o ${folder}-mira-quast --threads 2 -L --gene-finding --fast ${folder}_assembly/${folder}_d_results/${folder}_out.unpadded.fasta

mv ${folder}-mira-quast /store2/pog/analysis_192/quast


cd ../ # mv out of mira dir
else 
echo "no mira for $i"
fi


done # end of batch



