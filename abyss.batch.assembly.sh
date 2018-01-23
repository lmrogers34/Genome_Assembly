#!/bin/bash
#Trying to automate assembly of reads.
#Will take reads and in the assembly folder, create a reads folder which will contain the different assemblies of that reads
#example of read file name : ec_pe_l250_f100_1.fq
for i in /ec_196[3456]*_1.fq

do
folder=$(basename "$i" _1.fq)
read1=$i
read2=${read1/_1.fq/_2.fq} #names the second read
#echo "i is $i"
echo "folder is $folder"
#echo "read1 is $read1"
#echo "read2 is $read2"

if [ -d $folder ] # $folder exists
then
cd $folder #changes into a read specific folder
else
mkdir $folder #creates a read specific folder
cd $folder #changes into a read specific folder
fi

if [ -d abyss ] # checks if the abyss folder exists within the directory
then
cd abyss
else
mkdir abyss
cd abyss #cd into abyss dir
fi

#Abyss for loop
for k in {21..127..2} # loops between all integers between 21 and 127 in increments of 2
do
if [ -d $k ]
then
cd $k
else
mkdir $k
cd $k
fi


if [ -f $folder-$k-contigs.fa ]
then
echo "assembly for $folder-$k exists"
else
abyss-pe k=$k n=10 in="$read1 $read2" name=$folder-$k
fi

cd ../
echo "k-mer $k done"
done    
cd ../ #leave abyss dir
echo "abyss done"
cd ../
done

