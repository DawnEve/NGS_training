# 20170326 Linux命令

```
$ ssh user120@123.57.214.96
961251
```

视频链接在ppt中。
QQ群: 554135121

## 概念与历史
2000 fly

- WGS
- 生物学意义 biology of genome
- 疾病 biology of disease
- 制药 medicine
- 个性化医疗 healthcare


- Nextera:打断DNA。
- 为什么Illunima测序不是很长？
- PE测序顺序：read1,index1,reverse,index2,PCR, read2.
- mate pair 和pair end的区别？
  * matePair建库不同。两头变中间，中间变两头。相当于中间测得更长了。



- 三代测序比较成熟的pacBio和nanoPore
- pacBio的single molecule seq的2项技术:
    1. 核酸磷酸化连接（以前是荧光连接到碱基上，现在是连接到磷酸上。）
    2. 纳米小孔底部固定DNA聚合酶，高信噪比光学探头聚焦到孔底部。还要快速成像，很小的孔。荧光加上和解开时间差别大。
- nanoPore的
    1. 正反链都测
    2. 使用一个膜蛋白，放到一个不导电膜上，监测电流，如果有分子走过去，电流就会降低。


### 中草药参考基因库（植物所）。



## RNAseq实验设计

### 什么能发高分？
  - discovery 新机理
  - resource 测序了新的基因组
  - method 发明了新的方法
  - tools 网站、软件

### RNA-seq的目的：
  - 表达量
  - 差异表达

### RNA-seq和microarray的比较
  - 中表达基本一致
  - 低表达、高表达不一致。

### 测序深度的选择
  - 深度越高，则发现的基因越多。
  - 但是多高到一定程度，就不会发现新基因了。
  - fasta格式.
  - quality score: Q=-log10(P). Q+33的ASCII码描述碱基，得到fastq格式。

### fastqc数据质控





## 1.文件权限
chown UID:GID files
chmod o+w file.txt  #other组增加write权限

## 文本处理
grep
split
swk

## 文件查找
find

## sh script
#! /bin/bash
date
ls -la

## 文本编辑
nano
emacs
vi

## 进程管理
su suer
passwd
top
top -u user
history
ps
ps -ef 显示所有账号的进程详细列表
kill -9 pid

## 几个特殊符号
< 导入符号 到文件
| 管道符号，输出作为下一步的输入
> 重定向
& 后台处理

## 软件安装
ubuntu 使用apt-get
red hat使用 yum

## 加压缩
tar -xzvf xx.tar.gz
./configure
make
(sudo) make install
make clean


## 注意
1.注意大小写

end8:34

---
##  fastqc
http://yanshouyu.blog.163.com/
http://yanshouyu.blog.163.com/blog/static/214283182201302835744453/

http://cbsu.tc.cornell.edu/lab/doc/RNASeq_workshop_2013_part2.pdf

--
