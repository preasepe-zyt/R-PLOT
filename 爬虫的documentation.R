'
1.爬虫包rvest中包含以下几个函数：
1）read_html()#读取文档（网页）中的函数；
2）html_nodes()#选择提取文档中指定元素、节点的部分；
3）html_text()#提取标签内的文本；
4）html_attrs()#提取属性名称及其内容。
2.HTML介绍：
1）HTML不是编程语言，而是用来描述网页的超文本标记语言；
2）标记语言有一套标记标签，用标记标签来描述网页，HTML的标签是由尖括号标记的关键词，如标签内容以<HTML>开始和以</HTML>结束。
'''

library(rvest)
url <- 'https://www.thepaper.cn/'
web <- read_html(url)
web
#可以看到，选中的新闻标题在该网页中的标签为span在r中输入如下代码：
news <- web %>% html_nodes('span')
news
#将会显示这个页面所有的新闻标题。由于我们仅仅想得到标题即这些汉字。
title <- news %>% html_text()
title
#接下来我想得到每个新闻对应的网址，在r中输入如下代码：
links <- news %>% html_attrs()
links
link1 <- c(1:length(links))#表示将从1到links的长度以向量的形式赋值给link1
for(i in 1:length(links))#下标i从1到links的长度的循环
{
  link1[i] <- links[[i]][1]#将links所有行的第一列数据依次赋值给link1
}
link1
link10 <- paste("https://www.thepaper.cn/",link1,sep='')#由于link1中的网址并不完全，因此需要在其前面加上澎湃新闻网址
link10
