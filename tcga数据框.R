devtools::install_github("ayueme/easyTCGA")
主要功能
1行代码实现1个常见分析！

getmrnaexpr
只需要提供正确的TCGA project名字即可；
自动下载并整理mRNA和lncRNA的counts，tpm，fpkm共6种表达矩阵，以及对应的临床信息，临床信息样本顺序和表达矩阵样本顺序完全一致，无需再次整理；
自动保存以上6种表达矩阵和临床信息到当前工作目录下的output_mRNA_lncRNA_expr文件夹下，并且同时保存rdata和csv两种文件格式；
下载的数据为最新数据，和GDC TCGA官网(https://portal.gdc.cancer.gov/)保持一致；
支持通过手动下载的TCGA数据进行自动整理并完成以上过程，手动下载数据请参考：可能是最适合初学者的TCGA官网下载和表达矩阵整理教程
getmirnaexpr
只需要提供正确的TCGA project名字即可；
自动下载并整理miRNA的counts，rpm2种表达矩阵；
自动保存以上2种表达矩阵到当前工作目录下的output_miRNA_expr文件夹下，并且同时保存rdata和csv两种文件格式；
下载的数据为最新数据，和GDC TCGA官网(https://portal.gdc.cancer.gov/)保持一致；
getsnvmaf
只需要提供正确的TCGA project名字即可；
自动下载并整理TCGA MAF文件(masked annotated somatic mutation)以及对应的临床信息，并自动保存到当前工作目录下的output_snv文件夹下；
输出结果可以直接通过maftools::read.maf()函数读取，无需再次整理
diff_analysis
与getmrnaexpr函数无缝对接，直接使用其输出结果即可，无需任何整理；
自动通过3个R包进行差异分析：DESeq2, edgeR, limma，
输出结果默认为1个list，内含3种差异分析结果，可保存rdata格式数据到本地
batch_survival
自动对大约20000个基因进行logrank检验和单因素cox分析，基于中位数；
与getmrnaexpr函数无缝对接，直接使用其输出结果即可，无需任何整理；
支持counts，tpm，fpkm3种格式的数据，如果是counts，则通过DESeq2::vst()进行转换，如果是tpm/fpkm，则进行log2(x + 0.1)转换；
支持打印基因序号到屏幕，方便定位有问题的基因
使用注意
需要自己解决网络问题，比如访问github，TCGA官网, google等，如果你无法解决网络问题，那么生信数据挖掘可能不适合你......

TO DO
增加对甲基化表达矩阵的支持；
增加对miRNA和lncRNA的差异分析和生存分析支持；
增加批量生存分析支持自定义分组标准；
1行代码实现多种免疫浸润分析
提示信息修改
