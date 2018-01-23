#!/bin/bash
for i in /store2/pog/analysis_192/assembly/ec_196[3456]*_adapt
#for i in /store2/pog/analysis_192/assembly/ec_219[234]*_adapt
#for i in /store2/pog/analysis_192/assembly/ec_219[789]*_adapt
do
folder=$(basename "$i" )


#echo "i is $i"
echo "folder is $folder"

cd $folder
if [ -d spades_careful ]
then
cd spades_careful

quast.py -o ${folder}-spades-quast --threads 2 -L --gene-finding --fast contigs.fasta

mv ${folder}-spades-quast quast

cd ../ # mv out of spades_careful dir
else 
echo "no spades_careful for $i"
fi

cd ../ # mv out of $folder
done # end of batch
