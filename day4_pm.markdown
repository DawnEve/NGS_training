#2017.3.27 pm

## 标准的生物信息学分析结果。

1. density - log10FPKM图双峰表示有基因污染。牛胃可能被胃部微生物污染。
2. 火山图 -log10(P) - log2(FC)
3. 维恩图
4. 互做网络图
5. circos图：甲基化位点
  - 配置circos.conf文件
  - 准备实验数据
  - 运行circos -conf circos.conf
  - 查看circos.png或circos.svg文件
6. R语言简介：统计+画图。
  - 分类、聚类
  - Rstudio是R的IDE环境。
    * 123.57.214.96:8787 user/pass

## 各种.seq
1. 研究目的
2. 交联与否？
3. 怎么富集？抗体、蛋白


### 1. ChIRP-seq找到lincRNA的靶基因。
Chromatin Isolation by RNA purification
 (Liz et al,2014 PNAS.)(Li W,2013,Nature)

知道lincRNA，知道参与的表达调控。

### 2. GRO-seq
Global Run-on Sequencing.
SNP对enhencor selection（特异性？）和功能的影响。

### 3. (Ribo-seq)Ribosome Probiling sequencing

等等。

---
## 植物所的paper

1. CYK450和很多次生代谢产物密切相关。
2. 用在无法分析的数据部分，分析lincRNA。(Lij,2014,PLoS ONE)
  - 有map到CDS区域的，丢掉。
  - 预测ORF大于200，丢掉。
  - 长度小于200bp，丢掉。
  - 和miRNA db比对上的，丢掉。
3. ncRNA表达和mRNA表达量的关系(Chen H,2014,PLoS ONE)，三代可以做甲基化?
    - 如果有修饰，测序到该碱基会变慢，根据时间不同，可以确定甲基化的类型。
    - 周围做pattern discovery，发现几个。
    - 还需要实验验证。
4. [seqMonk]()对转录组数据的可视化分析。可以看各个比对的track:甲基化等。
    - https://www.bioinformatics.babraham.ac.uk/projects/seqmonk/
    - http://compbio.ucdenver.edu/Hunter_lab/Phang/resources/Teaching/AACR/SeqMonk-Analysis-V2.pdf
5. ncRNA、cRNA表达水平的相互作用（链特异的建库）头对头、尾对头、头对尾、尾对尾。
6. 不能完全相信RNAseq的结果，需要使用qrtPCR做验证。
7. asRNA和sRNA表达的差异。


### 做测试
答完之后，将答卷命名为answers_[your user id].txt, 提交到/tmp/quiz_20170327/, 运行以下命令修改相应的权限：chmod 400 answers_[your user id].txt

1. 列出你的姓名、单位、电子邮件。（5分）
2. 列出代表性的二代和三代测序平台各一个，每个平台最重要的技术特点有哪些？（5分）（限200字）
3. 简述RNA-seq的定义及其用来解决的问题。（5分）（限200字）
4. FASTA，FASTQ和GFF格式的文件是用来描述什么类型的数据，每种格式的基本组成是什么？（15分）（限200字）
5. 针对你所关心的科学问题，设计一个应用RNA-seq技术解决该问题的课题，提供技术路线，列出相应的实验技术和数据分析软件，讨论可能出现的问题及采取的解决方案。(30分）（限500字）

end14:37

---

## R语言简介
使用Rstudio环境。
 - tool->导入数据
 - tool->安装包
 - 










---------
