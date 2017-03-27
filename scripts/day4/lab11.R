# R语言画图
library("ggplot2");
setwd("/biodata2/ipagc001/user120/my_projects/lab11_R_graph");


#1 饱和图
saturation_curve=read.table("saturation_curve.txt",sep=',',header=T)
ggplot(saturation_curve,aes(x=Distance,y=Percentage,color=Group)) + geom_line(size=1) + geom_point(size=3)


#2 火山图
volcano_plot=read.table("volcano_plot.txt",sep='\t',header=T)
ggplot(volcano_plot,aes(x=x,y=y,color=Regulated.Genes.225))+geom_point()+ylab("-log10(p value)")+xlab("log2(fold change)")



#3 气泡图 
balloon_plot=read.table("balloon_plot.txt",sep="\t",header=T)
ggplot(balloon_plot,aes(x=Fold.Enrichment,y=Term,size=Number.of.genes,fill=P_Value))+ geom_point(shape=21) + scale_fill_gradient(low="lightblue",high="red")

#3.1 更大的圆  
ggplot(balloon_plot,aes(x=Fold.Enrichment,y=Term,size=Number.of.genes,fill=P_Value))  + geom_point(shape=21)  + scale_fill_gradient(low="lightblue",high="red") + scale_size_area(max_size=15)

