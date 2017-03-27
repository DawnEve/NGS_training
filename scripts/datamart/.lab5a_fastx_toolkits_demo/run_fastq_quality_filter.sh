#!/bin/sh

fastq_quality_filter -q 30 -i test_1.fq -o test_1_quality_filter.fq
fastq_quality_filter -q 30 -i test_2.fq -o test_2_quality_filter.fq
