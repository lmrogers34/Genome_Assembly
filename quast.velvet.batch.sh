#!/bin/bash
for i in /assembly/ec_1963*_adapt
#for i in /assembly/ec_196[3456]*_adapt
#for i in /assembly/ec_219[234]*_adapt
#for i in /assembly/ec_219[789]*_adapt
do
folder=$(basename "$i" )


#echo "i is $i"
echo "folder is $folder"

cd $folder
if [ -d velvet ]
then
cd velvet

#velvet for loop
for k in {41..127..2}
do

if [ -d $k ]
then
quast.py -o ${folder}-$k-velvet-quast --threads 2 -L --gene-finding --fast $k/contigs.fa
mv ${folder}-$k-velvet-quast /quast
else
echo "$k doesn't exist for $i"
fi
done # end of k for loop

cd ../ # mv out of velvet dir
else 
echo "no velvet for $i"
fi

cd ../ # mv out of $folder
done # end of batch
