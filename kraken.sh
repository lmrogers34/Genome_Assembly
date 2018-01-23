#!/bin/bash
for i in *R1_001.fastq.gz
do
read1=$i #paired reads, only diff is _1 or _2
read2=${read1/R1_001.fastq.gz/R2_001.fastq.gz} #names the second read
folder=$(basename $i _L001_R1_001.fastq.gz)

kraken --db /tools/kraken/kraken_db --threads 48 --fastq-input --gzip-compressed --unclassified-out ${folder}_unclassified.out --classified-out ${folder}_classified.out --output ${folder}.out --paired $read1 $read2
kraken-translate --db /tools/kraken/kraken_db ${folder}.out > ${folder}.labels
kraken-translate --db /tools/kraken/kraken_db --mpa-format ${folder}.out > ${folder}.mpa
done
