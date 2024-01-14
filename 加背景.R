# 选取presidential子集
presidential <- subset(presidential, start > economics$date[1])
ggplot(economics) + 
    #使用geom_rect()增加矩形背景
    geom_rect(
        aes(xmin = start, xmax = end, fill = party), 
        ymin = -Inf, ymax = Inf, alpha = 0.2, 
        data = presidential
    )+
    #使用geom_vline()增加垂直分割线
    geom_vline(
        aes(xintercept = as.numeric(start)),
        data=presidential,
        col = 'grey',alpha=0.5
    )+
    #使用geom_text()添加文本标签
    geom_text(
        aes(x=start,y=2500,label=name),
        data=presidential,
        size = 3,nudge_x=50
    )+
    # 使用geom_line()绘制时间序列曲线
    geom_line(aes(date, unemploy)) + 
    scale_fill_manual(values = c("blue", "red")) +#颜色设置
    xlab("date") + 
    ylab("unemployment")
