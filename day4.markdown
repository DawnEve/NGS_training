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
lab8a


```








--
