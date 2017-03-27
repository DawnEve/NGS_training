#!/bin/sh 

if [ -e Trinity.fasta.gz ] && [ ! -e Trinity.fasta ]
then
    gunzip -c Trinity.fasta.gz > Trinity.fasta
fi


#TransDecoder -t Trinity.fasta -m 50
/share/apps/TransDecoder-2.0.1/TransDecoder.LongOrfs  -t Trinity.fasta -m 50

#../../trinity-plugins/transdecoder/TransDecoder -t Trinity.fasta -m 50

echo
echo 
echo See best_candidates.\*  for candidate ORFs
echo



