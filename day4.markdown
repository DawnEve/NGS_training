# 2017.3.27

## 基因功能注释
 - 通过表达量FC，p-value，得到DE gene list。
 - GO & KEGG。

 - [trinotate](http://trinotate.github.io/) 转录本功能注释
   - blast
   - pfam 蛋白注释
   - uniprot
   - SQLite

### [trinotate流程](http://trinotate.github.io/)
1. TransDecoder 预测编码区。
2. blast获取同源序列。
3. HMMER 使用隐马尔科夫模型发现蛋白质domain，很敏感。
4. signalP 发现信号肽。
5. tmHMM 预测跨膜区。
6. RNAMMER 识别rRNA。
7. Trinotate 会输入如上结果到SQLite数据库。
8. 以上1-6的server服务需要自己运行，之后把结果放到一个文件夹下，给步骤7，输出为excel文件。


```
转录组基因注释
lab8a

lab8b
```

## 差异基因列表的目的
1. 列表中什么基因？
2. list中的基因家族是什么？
3. 富集的term是什么？
4. ？？

## 什么是好的term？
1. 包含很多重要的基因（marker gene）
2. 合适的基因数（100-2000）
3. 大多数基因统计上显著
4. 上下调基因有生物学意义
5. 有富集生物学意义
6. 高度重复
7. 其他wet实验可以验证的。

## CASEG 分析
Cluster of Adjacent and Similarly Expressed Genes(CASEG)

https://www.researchgate.net/publication/221586673_The_Human_Genome_Contains_Numerous_Clusters_of_Adjacent_Co-Regulated_Genes

- GO一级分类3个


- 数据预处理 log之后可能就正态分布了。
- 富集分析也是很复杂的领域，剩下的不过：DAVID等。
  - class I: singular enrichment Analysis仅仅考虑p值。
  - class II:考虑基因的FC和p-value。GSEA。
  - class III:还要考虑DE gene之间的关系。wgcna。

 - Gene命名产生了GO，后来GO越来越复杂了。Gene Oncology.
 - GO enrichment analysis
   - map gene 到Goterm ，blast2GO
   - GO 画图。
 - 蛋白互作网络PPI: string-db,
 - gene list analysis: GoSeq, KOBAS, DAVID**[推荐]**.
 - 非模式生物，不建议做GO分析，没有意义。
 - DAVID最早使用affimatrix的probe ID作为输入的，现在支持的输入越来越多了。

- http://geneontology.org/page/go-enrichment-analysis


 - AltAnalyze
   - for model organism
   - was designed for ??


## 全长转录本测序技术IsoSeq
  - 模式生物等已经研究的差不多了，就不用做三代测序了。三代不能定量。仅用于发现新长转录本。
  - 前提是能够用实验手段获得全长转录本。
  - 样本制备时还是有PCR。目前测序过程中酶能跑到30k。
  - 建库：bluePipin仪器或者手工切胶建库。
  - Hybrid assembly is a frontier.





## [Circos](http://circos.ca/)软件画圈图 - 基于perl的脚本。




## 怎么识别列表中的转录因子？


## 怎么用IGV看图？



--
