#!/bin/bash
#Automates the assembly of reads using MIRA
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

if [ -f ${folder}/mira/${folder}_assembly/${folder}_d_results/${folder}_out.unpadded.fasta ]
then
echo "mira assembly exists for $i"
else

if [ -d $folder ] # $folder exists
then
cd $folder #changes into a read specific folder
else
mkdir $folder
cd $folder #changes into a read specific folder
fi
printf "path is "
pwd


if [ -d mira ] # $folder exists
then
cd mira #change into mira dir
else
mkdir mira
cd mira #change into mira dir
#create manifest.conf file
fi


printf "path is "
pwd
if [ -f manifest.conf ]
then
echo "old file exists..  deleting..."
rm manifest.conf
fi

touch manifest.conf
echo "#Example for a manifest file describing a de-novo assembly with paired Illumina data" >>manifest.conf
echo "#Part 1 : Definitions">>manifest.conf
echo "project = $folder">>manifest.conf
echo "job = denovo,genome,accurate" >>manifest.conf
echo "parameters = -NW:cmrnl=warn" >>manifest.conf
echo "#Part 2 : Sequencing data" >>manifest.conf
echo "readgroup = Ecoli-paired" >>manifest.conf
echo "data = fastq::$read1 fastq::$read2">>manifest.conf
echo "technology = solexa" >>manifest.conf
echo "template_size = 250 550 autorefine " >>manifest.conf # insert size is 425
echo "segment_placement = ---> <--- " >>manifest.conf
echo "segment_naming = solexa" >>manifest.conf
#End of manifest file
mira -t 8 manifest.conf  # makes mira ignore problem with long read names
cd ../ #exit out of mira dir
echo "mira assembly done"
cd ../ #changes back into original assesment dir to rerun read analysis
echo "End of assemblers for $folder"
fi # check if assembly exists
done
