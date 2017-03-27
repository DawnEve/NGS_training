#!/bin/bash

###Align the RNA-Seq reads to the genome
bowtie2-build genome.fa genome

tophat -p 4 -G genes.gtf -o C1_R1_thout genome 4k_READS_sample/C1_R1_1.fq 4k_READS_sample/C1_R1_2.fq
tophat -p 4 -G genes.gtf -o C1_R2_thout genome 4k_READS_sample/C1_R2_1.fq 4k_READS_sample/C1_R2_2.fq
tophat -p 4 -G genes.gtf -o C2_R1_thout genome 4k_READS_sample/C2_R1_1.fq 4k_READS_sample/C2_R1_2.fq
tophat -p 4 -G genes.gtf -o C2_R2_thout genome 4k_READS_sample/C2_R2_1.fq 4k_READS_sample/C2_R2_2.fq

###Assemble exprssed genes and transcripts
cufflinks -p 4 -o C1_R1_clout C1_R1_thout/accepted_hits.bam
cufflinks -p 4 -o C1_R2_clout C1_R2_thout/accepted_hits.bam
cufflinks -p 4 -o C2_R1_clout C2_R1_thout/accepted_hits.bam
cufflinks -p 4 -o C2_R2_clout C2_R2_thout/accepted_hits.bam

echo "./C1_R1_clout/transcripts.gtf" > assemblies.txt
echo "./C1_R2_clout/transcripts.gtf" >> assemblies.txt
echo "./C2_R1_clout/transcripts.gtf" >> assemblies.txt
echo "./C2_R2_clout/transcripts.gtf" >> assemblies.txt

###Create a single merged transcriptome annotation
cuffmerge -g genes.gtf -s genome.fa -p 4 assemblies.txt

###Identify differentially expressed genes and transcripts
cuffdiff -o diff_out -b genome.fa -p 4 -L C1,C2 -u merged_asm/merged.gtf ./C1_R1_thout/accepted_hits.bam,./C1_R2_thout/accepted_hits.bam ./C2_R1_thout/accepted_hits.bam,./C2_R2_thout/accepted_hits.bam

###Explore differential analysis results with CummeRbund
echo "use the R to visualize the analysis results\n"
~

