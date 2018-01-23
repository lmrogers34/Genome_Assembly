#!/bin/bash
# adapter trimming
for i in *R1_001.fastq.gz
do
read1=$i #paired reads, only diff is _1 or _2
read2=${read1/R1_001.fastq.gz/R2_001.fastq.gz} #names the second read
folder=$(basename $i _L001_R1_001.fastq.gz)

cutadapt -b CTGTCTCTTATACACATCT -b AGATGTGTATAAGAGACAG -B CTGTCTCTTATACACATCT -B AGATGTGTATAAGAGACAG -b AAGAGGCA -b AGGCAGAA -b CAGAGAGG -b CGAGGCTG -b CGTACTAG -b CTCTCTAC -b GCTACGCT -b GGACTCCT -b GTAGAGGA -b TAAGGCGA -b TAGGCATG -b TCCTGAGC -B AAGAGGCA -B AGGCAGAA -B CAGAGAGG -B CGAGGCTG -B CGTACTAG -B CTCTCTAC -B GCTACGCT -B GGACTCCT -B GTAGAGGA -B TAAGGCGA -B TAGGCATG -B TCCTGAGC -o ${folder}.adapt.1.fastq -p ${folder}.adapt.2.fastq --info-file=${folder}.adapt.info $read1 $read2

done

mkdir fastqc_adapt
fastqc --threads 36 -o fastqc_adapt -f fastq *.adapt.*.fastq

#qual trimming
for i in *.adapt.1.fastq 
do
read1=$i #paired reads, only diff is _1 or _2
read2=${read1/.adapt.1.fastq /.adapt.2.fastq } #names the second read
folder=$(basename $i .adapt.1.fastq)

cutadapt -q 10,10 -o ${folder}.qual.1.fastq -p ${folder}.qual.2.fastq --info-file=${folder}.qual.info $read1 $read2

done

mkdir fastqc_qual
fastqc --threads 36 -o fastqc_qual -f fastq *.qual.*.fastq


