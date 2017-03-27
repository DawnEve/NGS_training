# 20170326 day3

## 1.数据分析哟啊解决的问题？
1. mapping
2. 转录组重建
3. 表达水平定量
4. 差异表达
5. 图形化
  - CummeRbund

## 2.fastqc质控
[P48]

## 质控后数据有问题怎么办？
lab5a 使用[fastX Toolkit](http://hannonlab.cshl.edu/fastx_toolkit/)对数据进行清洗。[P74]

### Available Tools
Fastq_to_fasta -h

- FASTQ-to-FASTA converter
  * Convert FASTQ files to FASTA files.
- FASTQ Information
  * Chart Quality Statistics and Nucleotide Distribution
- FASTQ/A Collapser 去掉adaptor？
  * Collapsing identical sequences in a FASTQ/A file into a single sequence (while maintaining reads counts)
- FASTQ/A Trimmer
  * Shortening reads in a FASTQ or FASTQ files (removing barcodes or noise).
- FASTQ/A Renamer
  * Renames the sequence identifiers in FASTQ/A file.
- FASTQ/A Clipper
  * Removing sequencing adapters / linkers
- FASTQ/A Reverse-Complement
  * Producing the Reverse-complement of each sequence in a FASTQ/FASTA file.
- FASTQ/A Barcode splitter
  * Splitting a FASTQ/FASTA files containning multiple samples
- FASTA Formatter
  * changes the width of sequences line in a FASTA file
- FASTA Nucleotide Changer
  * Convets FASTA sequences from/to RNA/DNA
- FASTQ Quality Filter
  * Filters sequences based on quality
- FASTQ Quality Trimmer
  * Trims (cuts) sequences based on quality
- FASTQ Masker
  * Masks nucleotides with 'N' (or other character) based on quality



```
  user120@ipags002:~/my_projects/lab5a_fastxtoolkit$ fastq_quality_filter -h
  usage: fastq_quality_filter [-h] [-v] [-q N] [-p N] [-z] [-i INFILE] [-o OUTFILE]
  Part of FASTX Toolkit 0.0.13 by A. Gordon (gordon@cshl.edu)

     [-h]         = This helpful help screen.
     [-q N]       = Minimum quality score to keep.
     [-p N]       = Minimum percent of bases that must have [-q] quality.
     [-z]         = Compress output with GZIP.
     [-i INFILE]  = FASTA/Q input file. default is STDIN.
     [-o OUTFILE] = FASTA/Q output file. default is STDOUT.
     [-v]         = Verbose - report number of sequences.
                    If [-o] is specified,  report will be printed to STDOUT.
                    If [-o] is not specified (and output goes to STDOUT),
                    report will be printed to STDERR.

  user120@ipags002:~/my_projects/lab5a_fastxtoolkit$


  #数据过滤
  $ fastq_quality_filter -q 30 -p 100 -i test_1.fq -o test_1_filter.fq -Q 33
  $ fastq_quality_filter -q 30 -p 100 -i test_2.fq -o test_2_filter.fq -Q 33

  #去掉前10个碱基
  $ fastx_trimmer -f 11 -i test_1_filter.fq -o test_1_quality_filter_trimmed.fq
  $ fastx_trimmer -f 11 -i test_2_filter.fq -o test_2_quality_filter_trimmed.fq

  #将序列小于50的序列去除
  $ fastx_clipper -l 50 -i test_1_quality_filter_trimmed.fq  -o test_1_quality_filter_trimmed_clipper.fq
  $ fastx_clipper -l 50 -i test_2_quality_filter_trimmed.fq  -o test_2_quality_filter_trimmed_clipper.fq

  # 数据格式转换
  #fastq2fasta格式
  $ fastq_to_fasta -i test_1.fq -o test_1.fasta

  #fasta2tabulated格式
  $ fasta_formatter -t -i test_1.fasta -o test_1_tabulated.txt

$ fastqc test_1_quality_filter_trimmed_clipper.fq
```
下载到本地,用浏览器查看fastqc结果，看数据清洗后数据质量是否提高了。

## map method
1. un-spliced method:mapping to cDNA for quantification
  - xx
2. spliced method: for gene structure construction
  - Exon-first:适合绝大多数都能map。
    * 局限：如果有含有intron的假基因，则可能直接map到假基因上了。
  - seed and extend:打碎reads成小片段。
    * 适用于unmap部分，或者unmap比例较高的转录组。

## SAM文件格式
1. 记录reads比对结果的文件格式。
2. [SAM specs](https://samtools.github.io/hts-specs/SAMv1.pdf)
  - http://genome.sph.umich.edu/wiki/SAM
  - https://en.wikipedia.org/wiki/SAM_(file_format)
  - 11 列的纯文本tab文件。
  - @开头是描述信息：specs文件后面有详述。
  - SAM压缩成二进制后是BAM格式。

```
Col Field Type Regexp/Range Brief description
1 QNAME String [!-?A-~]{1,254} Query template NAME
2 FLAG Int [0,216-1] bitwise FLAG
3 RNAME String \*|[!-()+-<>-~][!-~]* Reference sequence NAME
4 POS Int [0,231-1] 1-based leftmost mapping POSition
5 MAPQ Int [0,28
-1] MAPping Quality
6 CIGAR String \*|([0-9]+[MIDNSHPX=])+ CIGAR string
7 RNEXT String \*|=|[!-()+-<>-~][!-~]* Ref. name of the mate/next read
8 PNEXT Int [0,231-1] Position of the mate/next read
9 TLEN Int [-231+1,231-1] observed Template LENgth
10 SEQ String \*|[A-Za-z=.]+ segment SEQuence
11 QUAL String [!-~]+ ASCII of Phred-scaled base QUALity+33

```

实验5b内容：使用[bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/manual.shtml)+sam tools +Bamview进行mapping、修改和查看。[]

1. 建立基因组的index
  - bowtie2-build xx_ref
2. align single-end reads
  - bowtie2 -x xx_ref -U
3. align paired-end reads
4. align reads with local alighnment option
5. 转成bam文件
6. 排序sort
7. 对bam做index
8. 使用bamview查看结果。

```
lab5b：map到reference上

1.建立索引
$bowtie2-build ../../../datamart/sample_data/lab5b_ref.fa lab5b_ref
2.单端比对
$ bowtie2 -x lab5b_ref -U ../../../datamart/sample_data/lab5b_reads_1.fq -S eg1.sam
10000 reads; of these:
  10000 (100.00%) were unpaired; of these:
    596 (5.96%) aligned 0 times
    9404 (94.04%) aligned exactly 1 time
    0 (0.00%) aligned >1 times
94.04% overall alignment rate
user120@ipags002:~/my_projects/lab5b_bowtie2$

3.双端比对
$ bowtie2 -x lab5b_ref -1 ../../../datamart/sample_data/lab5b_reads_1.fq -2 ../../../datamart/sample_data/lab5b_reads_2.fq -S eg2.sam
10000 reads; of these:
  10000 (100.00%) were paired; of these:
    834 (8.34%) aligned concordantly 0 times
    9166 (91.66%) aligned concordantly exactly 1 time
    0 (0.00%) aligned concordantly >1 times
    ----
    834 pairs aligned concordantly 0 times; of these:
      42 (5.04%) aligned discordantly 1 time
    ----
    792 pairs aligned 0 times concordantly or discordantly; of these:
      1584 mates make up the pairs; of these:
        1005 (63.45%) aligned 0 times
        579 (36.55%) aligned exactly 1 time
        0 (0.00%) aligned >1 times
94.97% overall alignment rate


4.使用本地比对选项。
$ bowtie2 --local -x lab5b_ref -U ../../../datamart/sample_data/longreads.fq -S eg3.sam
6000 reads; of these:
  6000 (100.00%) were unpaired; of these:
    157 (2.62%) aligned 0 times
    5634 (93.90%) aligned exactly 1 time
    209 (3.48%) aligned >1 times
97.38% overall alignment rate

5.sam2bam
$ samtools view -bS eg2.sam > eg2.bam

6.bam排序
samtools sort eg2.bam eg2.sorted

7.为排序过的bam建lindex
samtools index eg2.sorted.bam

8.查看比对结果
mkdir eg2
cp ../../../datamart/sample_data/lab5b_ref.fa eg2.ref.fa
cp eg2.ref.fa eg2.sorted.bam eg2.sorted.bam.bai eg2
下载eg2文加夹。
打开bamview文件，输入bam文件和eg2.ref.fa查看比对结果。
```

[Bamview](http://bamview.sourceforge.net/)接收输入bam文件，可选输入reference。
  - 蓝色 同向
  - 黑色 反向
  - 红色
  - 可以一直放大，直到看到碱基。
  - 可以单击序列，查看配对序列位置。

更好的是使用[IGV](http://software.broadinstitute.org/software/igv/)可视化。





## 转录组重建算法
1. De brijn graph
  - k-mer is a substring of length K.
  - 3mer, 分成2mer，left和right。
  - 然后序列按照mer进行画线连接。
  - 解析这些图的算法的实现：
    * scirpture: 选择所有路径？？
    * cufflink: 选择够用的路径？？


## 基因组依赖的组装
  - 两个补充
    * 分清楚错误和变异
    * 灵敏度和复杂度最优平衡。
  - 去掉low-covverage分支。
  - k-mer length->不同结果。
    * AbYss -> variable k-mer strategy.








refer links:
http://www.htslib.org/doc/

----
