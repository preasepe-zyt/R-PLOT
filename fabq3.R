hm <- read_excel("C:/Users/79403/Desktop/hm.xlsx")
hm[,-1] -> hm
as.matrix(hm) -> hm
dim(hm) <- c(80,1)

gene <- c(rep("fabp3",5),rep("pparg",5),rep("c-fos",5),rep("bdnf",5),rep("a-syn",5),
rep("parkin",5), rep("pink1",5), rep("th",5), rep("uchl1",5), rep("dj1",5), rep("pomc",5), 
rep("gr",5), rep("mr",5), rep("hcrt",5), rep("mc2r",5), rep("prl",5))
as.data.frame(hm)->hm
group <- c("CTL", "MPTP", "25ug/ml", "50ug/ml","100ug/ml")
group2 <- rep(group,16)
hm$group <- group2
fin <- c("p","gene","group")

## plot
library(ggplot2)
p1 <- ggplot(hm,aes(x=p,y= gene)) + 
  geom_point(aes(size= p, fill= p),
             shape=21,
             color="black") +
  scale_fill_gradient2(name = 'Log2FC\n(Expression)',
                       limit = c(-1.001,1.001),
                       breaks = c(-1.0,-0.5,0.0,0.5,1.0),
                       low='#444283',
                       high='#943934', 
                       mid="white", 
                       midpoint = 0)+
  scale_size_continuous(name = '-Log10 qvalue',
                        limit = c(-0.001,3.1),
                        breaks = c(0,1,2,3))+
  geom_hline(yintercept=c(5.5, 10.5))+
  labs(x=NULL,
       y=NULL,
       title = "Expression of immunomodulatory genes (9p21-Loss vs 9p21-WT)")+
  theme_bw()+
  theme(panel.grid = element_blank(),
        legend.key = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 12),
        axis.text =element_text(size = 10, color = "black"),
        axis.text.y = element_blank(),
        axis.text.x=element_text(angle=45,hjust = 0.5,vjust=0.5))
p1  
# rect anotate
anotate <- data %>% distinct(gene,.keep_all = T)
head(anotate)
p2 <- ggplot(anotate,aes(x = 0,y = gene,label= gene )) +
  geom_text()+
  annotate("rect", 
           ymin = c(0.5,5.5,10.5), ymax = c(5.5,10.5,15.5),
           xmin = -5, xmax = 0.7,
           fill = c('#ecf7fb','#fffbe7','#ffe7df'),
           alpha = 0.5)+
  theme_void()


p2
# patch
library(patchwork)
library(cowplot)
p2+p1+plot_layout(nrow= 1,
                  width = c(1, 2))

ggsave('bubble_heatmep.pdf',width = 10,height = 5)
