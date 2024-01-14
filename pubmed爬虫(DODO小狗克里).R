rm(list=ls())
setwd("/Users/chenchen/Desktop/ALG3课题设计/糖基化结果重新跑/代码/爬取文章")
#加载所需要的R包，没安装的提前安装
# install.packages("rcrossref")  # 安装XML包
library(httr)
library(magrittr)
library(rvest)
library(xml2)
library(stringr);library(openxlsx)
library(dplyr);library(survival);library(parallel);library(reshape);library(limma)
library(jsonlite)
library(rcrossref)

#####在这里输入你要的基因#####
# genes<-read.table("待文献精筛X蛋白2.txt",header = T)
# genes <- genes[genes != "NA"]
genes<-as.data.frame(c("PANX2","STMN1"))

genes <- genes[genes != "NA"]
length(genes)
#####在这里输入你要搜索条目####
content<-c("zebrafish",
            "neurodegenerative disease")
url_content<-gsub(" ", "+", content)

base_url <- "https://pubmed.ncbi.nlm.nih.gov"
sort_by <- ""
# final_res<- data.frame(matrix(nrow = 0, ncol = 8))

total_time<-0

genes<-genes[]
res3<-as.data.frame(c())
for (gene in genes) {
  web_links<-c()
  start_time <- Sys.time()
  index<-which(gene==as.vector(genes))
  number<-length(genes)
  res2<-as.data.frame(c())
  for (i in 1:length(url_content)) {
    if(grepl("\\(\\w+.*or.*\\w+\\)", url_content[i])==F){search_term<-paste(paste0('"', gene, '"'),"+",url_content[i],sep="")}
    if(grepl("\\(\\w+.*or.*\\w+\\)", url_content[i])==T){
      pattern <- "\\((.*?)\\)"  # 匹配括号中的内容，使用非贪婪模式匹配
      a<-sub(pattern, "\\1", regmatches(url_content[i], regexpr(pattern, url_content[i])))  # 提取括号中的内容
      search_term<-paste(paste0('"', gene, '"')," %28",a,"%29",sep="")
      search_term <- gsub(" ", "+", search_term)}
    
    url <-paste(base_url, "/?term=", search_term, "&sort=", sort_by,"&size=200",sep="")
    title <- c();author <- c() ;web <- c()
    parsed_html <-read_html(url,encoding = 'utf-8')
    result_count <- parsed_html %>%
      html_nodes(".value") %>%
      html_text() 
    result_count<-as.numeric(gsub(",","",result_count))
    if(length(result_count)>=1){
      # result_count<-as.numeric(gsub(",","",result_count))
      # result_count<-result_count[1]
      title <- c(title, parsed_html%>% html_nodes(".docsum-title") %>% html_text(trim = T))
      author <- c(author,parsed_html %>%   # 2、爬取文章作者
                    html_nodes('.full-authors') %>%
                    html_text())
      web <- c(web,parsed_html %>% html_nodes('.docsum-title') %>% html_attr(name = 'href'))
    }
    if(length(result_count)==0){
      if(length(rvest::html_text(rvest::html_nodes(parsed_html, "#full-view-identifiers > li:nth-child(1) > span > strong")))>=1){
        a<-parsed_html%>% html_nodes(".heading-title") %>% html_text(trim = T)
        title <- c(title,  a[1])
        
        authors<-parsed_html %>%   # 2、爬取文章作者
          html_nodes('.authors-list') %>%
          html_text()
        # 去掉多余的空格和分行符号
        authors <- gsub("\\s+", " ", authors)
        authors <-authors[1]
        author <- c(author,authors)
        
        pmid<-parsed_html %>% html_nodes('.current-id')
        paste0("/",gsub("[^0-9]", "", pmid)[1],"/")
        web <- c(web,paste0("/",gsub("[^0-9]", "", pmid)[1],"/"))
      }#搜到一篇的情况都没有的情况
      if(length(rvest::html_text(rvest::html_nodes(parsed_html, "#full-view-identifiers > li:nth-child(1) > span > strong")))==0){
        result_count<-0
        title <- c(title,"")
        author <- c(author,"")
        web <- c(web,"")
      }#搜到仅有一篇的情况，1
    }
    
    web_link <- paste('https://pubmed.ncbi.nlm.nih.gov',web,sep = '') # 连接成网址
    res1 <- data.frame(Genes=gene,Search=content[i],Title = title,Author = author,web = web_link)
    res2<-rbind(res2,res1)
  }
  res3<-rbind(res3,res2)
  end_time <- Sys.time()
  running_time = difftime(end_time, start_time, units = "secs")
  total_time<-total_time+as.numeric(running_time)
  print(paste0("已完成第",index,"个基因,","进度为",round(index/number,4)*100,"%,","总用时为:",round(total_time/60,2),"分钟  ",end_time))
  print(running_time)
}
print("PMID获取已完成，接下去爬取文章摘要")


# res3<-res3[!res3$Title=="",];res3<-res3[!duplicated(res3$web),]
# write.xlsx(res3,"res3.xlsx")
# res3<-read.xlsx("res3.xlsx")

#--------------------跑完一半了-----------------
web_links<-res3$web
length(web_links)

print(paste0("总数量:",length(web_links)))
total_time<-0
results <- list() 
start<-1
for(i in start:length(web_links)){
  start_time <- Sys.time()
  url<-web_links[i]
  aa<-rvest::read_html(url, encoding = "utf-8")
  # 获取c和d的文本内容
  c<-rvest::html_text(rvest::html_nodes(aa, "#eng-abstract > p"), trim = TRUE)
  d<-rvest::html_text(rvest::html_nodes(aa, "#abstract > p"), trim = TRUE)
  # 将结果添加到列表中
  results[[i]] <- list(c = c, d = d)
  end_time <- Sys.time()
  running_time = difftime(end_time, start_time, units = "secs")
  total_time<-total_time+as.numeric(running_time)
  print(paste0("已完成第",i,"篇文章,","进度为",round(i/length(web_links),4)*100,"%,","总用时为:",round(total_time/60,2),"分钟  ",end_time))
  print(running_time)
}
# 创建一个新的列表，保存 results 中每个元素的第一层
abstract <- lapply(results, "[[", 1)
Keywords<- lapply(results, "[[", 2)
abstract_clean <- lapply(abstract, gsub,pattern = '\n',replacement = '')
Keywords_clean <- lapply(Keywords, gsub,pattern = '\n',replacement = '')

abs_res <- c()# 连接为一个字符串对于多个部分的摘要
for(j in 1:length(abstract)){
  # 判断元素长度
  len = length(abstract_clean[[j]])
  if(len == 1){
    # 如果只有一个摘要就保存
    abs_res <- c(abs_res,abstract_clean[[j]])
  }else{
    # 如果摘要格式有多个，连接成一个
    abs_res <- c(abs_res,paste(abstract_clean[[j]],sep = '-',collapse = ' '))
  }
}
Keywords_res <- c()
for(j in 1:length(Keywords_clean)){
  if (length(Keywords_clean[[j]])==0) {Keywords_clean[[j]] <- "none"}
  Keywords_res<-c(Keywords_res,str_remove(Keywords_clean[[j]], "Keywords:\\s+"))
}
# PMID=str_extract(res2$web, "\\d+")
res4<- data.frame(web = web_links[1:i],Keywords=Keywords_res,Abstract = abs_res)
# ress4<-read.xlsx("res3.xlsx")
# a<-rbind(ress4,res4)
# write.xlsx(res4,"res4临时保存.xlsx")

res5 <- left_join(res3, res4, by = c("web" = "web"))
res5$PMID<-str_extract(res5$web, "\\d+")

res5<-res5[,c("Genes","Search","Title","Abstract","Keywords","Author","web","PMID")]
wb <- createWorkbook()
sheet<-"文献结果"
addWorksheet(wb, sheet)                    # 添加一个工作表
freezePane(wb, sheet, firstRow = TRUE)     #冻结首行
writeData(wb, sheet, res5,
          withFilter=T,headerStyle=createStyle(
            fontSize = 11, fontName = "Calibri",
            textDecoration = "bold", halign = "left"))
saveWorkbook(wb, "文献.xlsx", overwrite = TRUE)

