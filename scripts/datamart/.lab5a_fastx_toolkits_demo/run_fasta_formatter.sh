#!/bin/sh

fastq_to_fasta -i test_1.fq -o test_01.fasta
fastq_to_fasta -i test_2.fq -o test_02.fasta
fasta_formatter -t -i test_01.fasta -o test_1_tabulated.txt
fasta_formatter -t -i test_02.fasta -o test_2_tabulated.txt
