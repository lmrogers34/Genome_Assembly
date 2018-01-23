#!/bin/bash
#Automates the assembly of paired end reads using Velvet
#Will take reads and in the assembly folder, create a reads folder which will contain the different assemblies of that reads
#example of read file name : ec_pe_l250_f100_1.fq
for i in /reads/adapt/ec_196[3456]*_1.fq

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
mkdir $folder
cd $folder #changes into a read specific folder
fi

if [ -d velvet ] # $folder exists
then
cd velvet #changes into a read specific folder
else
mkdir velvet
cd velvet #changes into a read specific folder
fi

for j in {21..127..2}
do
echo "beginning $j"
if [ -a $j/contigs.fa ] #if the folder and assembly exists do nothing
then
   echo "$j done"
elif [ -a $j ] #if the folder without the assembly delete the folder, and do the assembly
then
   rm -r $j
   mkdir $j
   velveth ./$j $j -separate -fastq -shortPaired $read1 $read2 
   #Velvet g just done basically at first, can play around with parameters later
   velvetg ./$j -cov_cutoff auto -min_contig_lgth 200 -exp_cov auto 
   echo "finished $j"   
else #else folder doesn't exist, create the folder and do the assembly. 
   mkdir $j
   velveth ./$j $j -separate -fastq -shortPaired $read1 $read2 
   #Velvet g just done basically at first, can play around with parameters later
   velvetg ./$j -cov_cutoff auto -min_contig_lgth 200 -exp_cov auto 
   echo "finished $j"
fi
done
cd ../ #changes out of vel dir
echo "velvet done"
cd ../
done
