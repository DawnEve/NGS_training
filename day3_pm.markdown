# 2017.3.26

## 1. 基因表达定量
1. FPKM(用于双端PE测序) vs RPKM
2. 转录水平
  - Unique reads only method 低估一些低表达isoform
  - isoform level 定量 using MLE(most likely estimateds)[best]
3. gene level
  - map到exon的reads 计数
  - map到
  - ？
4. 有参：
  - 参考基因组
  - 参考注释文件
      - IGV可以加track，文件格式是[GFF格式](https://github.com/The-Sequence-Ontology/Specifications/blob/master/gff3.md)

### GFF3文件格式：9列tab文件，记录基因信息。
- Column 1: "seqid"
- Column 2: "source"
- Column 3: "type"
- Columns 4 & 5: "start" and "end"
- Column 6: "score"
- Column 7: "strand"
- Column 8: "phase"
- Column 9: "attributes" 预定义很多标签(id,parent,)

```
0  ##gff-version 3.2.1
 1  ##sequence-region ctg123 1 1497228
 2  ctg123 . gene            1000  9000  .  +  .  ID=gene00001;Name=EDEN
 3  ctg123 . TF_binding_site 1000  1012  .  +  .  ID=tfbs00001;Parent=gene00001
 4  ctg123 . mRNA            1050  9000  .  +  .  ID=mRNA00001;Parent=gene00001;Name=EDEN.1
 5  ctg123 . mRNA            1050  9000  .  +  .  ID=mRNA00002;Parent=gene00001;Name=EDEN.2
 6  ctg123 . mRNA            1300  9000  .  +  .  ID=mRNA00003;Parent=gene00001;Name=EDEN.3
 7  ctg123 . exon            1300  1500  .  +  .  ID=exon00001;Parent=mRNA00003
 8  ctg123 . exon            1050  1500  .  +  .  ID=exon00002;Parent=mRNA00001,mRNA00002
 9  ctg123 . exon            3000  3902  .  +  .  ID=exon00003;Parent=mRNA00001,mRNA00003
10  ctg123 . exon            5000  5500  .  +  .  ID=exon00004;Parent=mRNA00001,mRNA00002,mRNA00003
11  ctg123 . exon            7000  9000  .  +  .  ID=exon00005;Parent=mRNA00001,mRNA00002,mRNA00003
12  ctg123 . CDS             1201  1500  .  +  0  ID=cds00001;Parent=mRNA00001;Name=edenprotein.1
13  ctg123 . CDS             3000  3902  .  +  0  ID=cds00001;Parent=mRNA00001;Name=edenprotein.1
```

能从gff文件看出复杂的基因结构的注释信息：
  - 一个基因id有3个mRNA
  - 有4个外显子
  - 可以导入gff文件到IGV，生成track。
  - 其他基因注释格式
  - 基因组文件 + gff文件 => 导出转录本信息、promoter信息等。
  - 更多基因相关文件格式：https://genome.ucsc.edu/FAQ/FAQformat.html
  - bed文件时gff的简化版本。一般都是tab文件。


## 2.差异表达分析算法
- DE 分析方法。
- 不同condition的mean sv 画分布图。
- modeling the distribution of count.
  * 泊松分布可能最合适，后来又发展其他non-linear方法。
- 基因定量的3种方法。
  * 直接map到exon
  * splice map 到exon
  * isoform更好
+ 考虑的其他因素
  - 测序深度
  - 基因表达量
  - 基因长度
  - lib构建方法
  - 只有生物学重复才能提高严谨度。
+ 数据分析软件
  - 有参考*
    - 有基因组序列
    - 有基因组注释信息
    - **Tuxedo**(燕尾服) package

+ lab6 有参RNAseq分析
  1. [bowtie](http://bowtie-bio.sourceforge.net/index.shtml)、 [tophat](https://ccb.jhu.edu/software/tophat/index.shtml)
  2. [cufflink](http://cole-trapnell-lab.github.io/cufflinks/)
  3. [cummeRbund](http://compbio.mit.edu/cummeRbund/)
  4. 如果不想发现新的选择性剪切，tophat加参数 -no-??
  5. 推荐：每个样品分别做cufflink，在cuffmerge合并。
  6. 要有对照，要有重复。怎么描述？TSS I有2个转录本，TSS II有1个转录本。哪个基因转录因子用的多？哪个转录本多？

## 3.实验
- $ ls
  4k_READS_sample  cummeRbund.R.script  genes.gtf  genome.fa
- http://agetouch.blog.163.com/blog/static/2285350902016739843185/

```
1.建立索引
$ bowtie2-build genome.fa genome

2.tophat 做mapping
$ tophat -p 4 -G genes.gtf -o C1_R1_thout genome 4k_READS_sample/C1_R1_1.fq 4k_READS_sample/C1_R1_2.fq
$ tophat -p 4 -G genes.gtf -o C1_R2_thout genome 4k_READS_sample/C1_R2_1.fq 4k_READS_sample/C1_R2_2.fq

$ tophat -p 4 -G genes.gtf -o C2_R1_thout genome 4k_READS_sample/C2_R1_1.fq 4k_READS_sample/C2_R1_2.fq
$ tophat -p 4 -G genes.gtf -o C2_R2_thout genome 4k_READS_sample/C2_R2_1.fq 4k_READS_sample/C2_R2_2.fq

生成bam文件。最重要的是accepted_hits.bam文件，在cufflinks和cuffdiff都会用到。



3.组装基因和转录组
$ cufflinks -p 4 -o C1_R1_clout C1_R1_thout/accepted_hits.bam
$ cufflinks -p 4 -o C1_R2_clout C1_R2_thout/accepted_hits.bam
$ cufflinks -p 4 -o C2_R1_clout C2_R1_thout/accepted_hits.bam
$ cufflinks -p 4 -o C2_R2_clout C2_R2_thout/accepted_hits.bam

生成gtf文件，transcripts.gtf。
会有基因定量，gene.tracking,isoxx.tracking文件。

echo "./C1_R1_clout/transcripts.gtf" > assemblies.txt
echo "./C1_R2_clout/transcripts.gtf" >> assemblies.txt
echo "./C2_R1_clout/transcripts.gtf" >> assemblies.txt
echo "./C2_R2_clout/transcripts.gtf" >> assemblies.txt

4.创建单个的转录注释文件
cuffmerge -g genes.gtf -s genome.fa -p 4 assemblies.txt

5. 识别差异表达基因和转录本
cuffdiff -o diff_out -b genome.fa -p 4 -L C1,C2 -u merged_asm/merged.gtf ./C1_R1_thout/accepted_hits.bam,./C1_R2_thout/accepted_hits.bam ./C2_R1_thout/accepted_hits.bam,./C2_R2_thout/accepted_hits.bam

注意2个条件之间要有空格，条件内部是没有空格的逗号。
```
exp.diff是最重要的文件。


# MA-Plot怎么看？

http://bioinfo.cipf.es/babelomicstutorial/maplot
 - MA图用于研究2个变量的log比值，和这两个变量的的均值的依赖性。
 - Y轴是M值（log尺度的minus）是2个变量的log比值。
 - X轴是A值，2个参数的平均值（log尺度的average）。

 - X: logCounts
 - Y: logFc.
 - 应该是一条线？？


## volcano plot
1. FDR
  - 考虑多样本矫正，又考虑?的排名。
  - 做法：p-value * 测序基因数量 / ?排名。





---
# 无参转录组

## 非模式生物数据分析软件。

trinity(三位一体) software
  - Inchworm: 构建contigs，大概是isoform
  - Chrysalis cluster: contig clusters. de Bruijn graphs
  - Butterfly: reconstructed isoforms

- trinity程序的组成部分
  - reads组装需要大型服务器
  - 聚类：连接contig成cluster
  - de brujn graph，之后解析基因等。


````
运行trinity的硬件：512G-1T内存。
trinity: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3571712/
https://github.com/trinityrnaseq/trinityrnaseq/wiki
````





----------
- 使用UCSC基因组浏览器看ENCODE数据：https://www.genome.gov/multimedia/slides/encode2015-researchappsusers/08_fujita.pdf
