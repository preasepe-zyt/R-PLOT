library(httr)
library(rvest)
library(stringr) 
url <- "https://api.bilibili.com/x/relation/stat?vmid=631185362&jsonp=jsonp"
response <- GET(url)
# 解析页面内容
parsed_html <- read_html(response$content)
parsed_html<-as.character(parsed_html)
follower <- str_extract(parsed_html, '\"follower\":\\d+')
follower <- str_extract(follower,"\\d+")
# 格式设置成:连接函数，格式为“YYYY-MM-DD HH:MM:SS”

paste(strftime(Sys.time(), format = "%Y-%m-%d %H:%M:%S")," ","b站粉丝数是:",follower,sep="")
