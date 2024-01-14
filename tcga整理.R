library(TCGAbiolinks)
# 查询这一步是需要的！即使网在烂，这一步应该可以成功的...
query <- GDCquery(project = "TCGA-COAD",
                  data.category = "Transcriptome Profiling",
                  data.type = "Gene Expression Quantification",
                  workflow.type = "STAR - Counts"
)
# 下载这一步就不用了，我们是通过官网手动下载的~
GDCdownload(query, files.per.chunk = 100) #每次下载100个文件
# 整理
GDCprepare(query,save = T,save.filename = "example.rdata")

##|===============================================================================|100%   ##                   Completed after 1 m 
##Starting to add information to samples
## => Add clinical information to samples
## => Adding TCGA molecular information from marker papers
## => Information will have prefix 'paper_' 
##coad subtype information from:doi:10.1038/nature11252
##Available assays in SummarizedExperiment : 
##  => unstranded
##  => stranded_first
##  => stranded_second
##  => tpm_unstrand
##  => fpkm_unstrand
##  => fpkm_uq_unstrand
##=> Saving file: example.rdata
##=> File saved