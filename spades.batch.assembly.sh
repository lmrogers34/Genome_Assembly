#!/bin/bash
#Bash script to automate assembly of reads using SPADES.
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

if [ -a ${folder}/spades_careful/contigs.fasta ] #checks if the assembly previously exists
then
echo "assembly exists for $i"
else
#Assembly
if [ -d $folder ] # $folder exists
then
cd $folder #changes into a read specific folder
else
mkdir $folder
cd $folder #changes into a read specific folder
fi

#Spades


spades.py -1 $read1 -2 $read2 --careful -t 8 -o spades_careful
echo "Spades assembler done for $folder"
cd ../ #changes back into original assessment dir to rerun read analysis
fi
echo "End of assemblers for $folder"
done
