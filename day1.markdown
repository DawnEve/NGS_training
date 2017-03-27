# 	2017.3.24 pm
---
## 12. 如何评价拼接质量？
N50/N90，拼接到一半时scafold的长度。
把contig 和 scaffold 从长到短进行排列,然后相加,当恰好加到1M的50％,也就是1G基因组的500k的时候 ,那一条contig 或者scaffold 的长度就叫做Contig N50和Scaffold N50.很明显这个数值越大说明组装的质量越好.

BACs, Fosmids。保持很好的共线性，说明拼接的很好。

Assembly Validation by cDNA dataset.

使用经典软件的优势是不用过多解释方法：
[broadinstitute](https://www.broadinstitute.org/)

都用新软件则风险很大。方法review可能需要花很多时间。

最近institute发布了新分析流程。??//todo

end14:07



## 13. 重复序列去除
1.数据库repeatMasker(reference)只能识别已知重复；
2.repeatModeler(de novo)能识别未知重复。

end14:12

## 14. 基因组ncRNA
  - 常规ncRNA、lncRNA、lincRNA、circRNA、snoRNA、piRNA
    - Rfam: http://xfam.org/
  - miRNA: http://www.mirbase.org/
  - rRNA

## 15. 基因组组装
  - 怎么挖掘 genome SSR marker ？
    - 方便育种。方便被引用。

  - 大片段扩增和基因重复：Lastz、Nucmer软件，进化分析分析。

  - [trinity](https://github.com/trinityrnaseq/trinityrnaseq/wiki)不好，但是无参拼接没有更好的了。所以尽量使用长reads。公司拼接可能去掉200bp以下的短reads，这样碎片少一点。

  - half de novo 就是使用近缘物种genome作为refer，拼接新物种。

  - protein map to genome: [Spaln](http://www.genome.ist.i.kyoto-u.ac.jp/~aln_user/spaln/index.html)

  - [PASA](http://pasapipeline.github.io/) 真核生物基因组注释工具，用于refine。

end14:30

##16. 基因开放阅读框/基因结构分析识别工具。
(部分基于预测的？因为有些不表达)


## 17. 基因组注释

没有近缘株，只用blast nr注释肯定不行。

需要做domain、motif分析。[P11,3]
  - hypothetical基本不算注释。
  - 亮氨酸拉链 => 差不多是转录因子TF。

基因组比较：
  - 寄生虫可能丢失脂肪酸代谢基因。

基因组也必须做KEGG分析：
  - 原因：识别物种哪些代谢途径是完整的。
  - 转录组表示在用该通路，基因组表示是否有该通路。
  - KEGG母图是不具有物种差异的。识别这个物种的代谢途径。

软件：多是一代测序时代的产物。

end14:44



---

## 18. 转录组分析[P12,3]
1.https://github.com/trinityrnaseq/RNASeq_Trinity_Tuxedo_Workshop/wiki

2.[Tuxedo Genome Guided Transcriptome Assembly Workshop](https://github.com/trinityrnaseq/RNASeq_Trinity_Tuxedo_Workshop/wiki/Tuxedo-Genome-Guided-Transcriptome-Assembly-Workshop)

3.RNA测序2个方向：真核转录组、RNA病毒测序。

4.一代、芯片关注：有polyA尾巴的RNA。
相当数量lncRNA也有polyA，不编码蛋白。

二代可以关注repeat、假基因等。

[ENCODE](https://www.encodeproject.org/) 计划：针对人和小鼠，完善基因组注释。https://www.encodeproject.org/data/annotations/

2008-09芯片、NGS较量厉害的2年。

需要3个生物学重复，不需要技术重复。

不要做等分取样？？？//todo

  - 如果分析低丰度转录本，则加大数据量。

  - mRNA内标的问题。
    - 至今没有被广泛接受的内标。

  - SAGE:1994-1995出来的技术。
    - 开始以为能一次检测多个基因表达量，很受期待。
    - 基因表达连续分析--SAGE(Serial Analysis of Gene Expression)
    - 很难做，反复地PCR、电泳、回收，且几十bp片段很难回收。很鸡肋。
    - refer http://www.dxy.cn/bbs/topic/266695?ppg=1
    - 改进：增加片段长度。
    - 实验很难，分析很难。
    - small RNA测序时代：分离SAGE后，用小RNA盒子测序。(hASHIMOTO s-I,ET AL.(2009)PLoS ONE)

  - rRNA删除：
    - 随着nonCoding的重视，开始从全RNA中删除rRNA。
    - 删18S、28S序列：探针池，互相overlap覆盖18S+28S全长的一系列探针。增加捕获的效率。
    - 做两轮删除，从80%下降到0.2%。
    - rRNA删除试剂盒：人、拟南芥、G+、G-菌。
    - 如果没有kit，先调取18S和28S，和人、拟南芥比对。自己合成一个盒子太贵！或者用人的捕获一次，用动物的捕获一次。
    - 古菌：差别太大，很难做统一适用的盒子。clustalW看差别很大。简单粗暴：提取total RNA，直接测序。

  - 适用性
    - RNA | 研究明确，性状明确 |
    - SAGE | eGWAS数量性状(红花+白花=>红、白、红花白点、白花红点，做co-expression，找表达差异基因模块，叫做eQTL) | 需要很多RNAseq。
    - rRNA | 复杂调控机理 | 调控网络很多涉及很多ncRNA。|优点：分析全面。适合模式生物。|缺点：要求有高组装质量的基因组。成本最高的，>20G数据量。生信分析的压力最大。

  - lincRNA 功能很难验证。不编码蛋白，选择压力小。水稻xx基因，小麦的xx基因再做已经没有新意了，但是做lincRNA就很有新意，但实验难度并没有增加。

  - 镇住销售的名词：核糖体去除 链特异的RNAseq。
  - web分析系统：http://waprna.big.ac.cn/



## 19. RNAseq的常见图
1. 5'3'完整性。
2. FPKM比RPKM分辨率高。[P16,1]
3. 关心：中高表达、高表达的基因，基本都被研究烂了，是做质控用的，在文献中占用2-3行。
4. heatmap热图：可以做全基因的，DE基因，pathway基因等，单向、双向聚。分析发掘很重要。
    - 小鼠1w、4w、10w的脑基因表达无基因symbol的热图分析：一周和十周基本呈现开和关状态，青春期小鼠实现从幼年到老年的关键阶段。
    - 1w独有基因拿出来做GO分析，说明1w重点发育xx；
    - 10w独有基因拿出来做GO分析，说明10w中xx在做什么。
5. 芯片和表达的关系。中高表达量上一致，低表达量上NGS分辨率更高。芯片去除背景后，损失很多低表达基因。
6. 生信需要学做图。基本是用R语言。http://www.genome.jp/kegg/ 中根据表达量显示颜色。
7. 高表达、中低表达分析套路不同。
      - 高丰度表达基因，DESeq等基于p值的，高表达一般是下游，集中在具体通路。
      - 上游调控TF等低丰度基因，差异很小，p值也不显著。不用看P值，只用RPKM值相除，处理前/处理后，上调就染红，下调就染绿，给出整体的KEGG图也很有说服力。
      - [DAVID](https://david.ncifcrf.gov/) 做功能富集分析。橡胶割一刀后，分析到有损伤修复。
      - [IPA](http://qiagenbioinformatics.com/products/ingenuity-pathway-analysis/)构建调控网络的构建（）B细胞分化过程相关基因调控网络。解读方式和DAVID不一样，一个球一个功能。网络的凝聚性，判断效应个数、关联。
8. 直系基因（不同物种）、旁系基因（同一个物种扩增出来的基因）


--
