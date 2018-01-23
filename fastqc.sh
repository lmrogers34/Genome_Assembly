#!/bin/bash
#qc-check
mkdir fastqc_check
fastqc --threads 36 -o fastqc_check -f fastq *.gz

