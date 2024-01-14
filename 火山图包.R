devtools::install_github("BioSenior/ggvolcano")
library(ggVolcano)

## basic example code
# load the data
data(deg_data)

# use the function -- add_regulate to add a regulate column 
# to the DEG result data. 
data <- add_regulate(deg_data, log2FC_name = "log2FoldChange",
                     fdr_name = "padj",log2FC = 1, fdr = 0.05)

# plot
ggvolcano(data, x = "log2FoldChange", y = "padj",
          label = "row", label_number = 10, output = FALSE)


# Change the fill and color manually:
p1 <- ggvolcano(data, x = "log2FoldChange", y = "padj",
                fills = c("#e94234","#b4b4d8","#269846"),
                colors = c("#e94234","#b4b4d8","#269846"),
                label = "row", label_number = 10, output = FALSE)

p2 <- ggvolcano(data, x = "log2FoldChange", y = "padj",
                label = "row", label_number = 10, output = FALSE)+
  ggsci::scale_color_aaas()+
  ggsci::scale_fill_aaas()
#> Scale for 'colour' is already present. Adding another scale for 'colour', which
#> will replace the existing scale.
#> Scale for 'fill' is already present. Adding another scale for 'fill', which
#> will replace the existing scale.

library(patchwork)
p1|p2

基础用法
确保你有一个包含差异表达基因信息的DEG结果数据（数据需要包括：GeneName、Log2FC、pValue、FDR）。
如果你的数据没有名为 "regulate "的列，你可以使用add_regulate函数来添加，使用方法如下。
使用函数gradual_volcano来制作一般的火山图。你可以使用?gradual_volcano来查看该函数的参数。
# plot
gradual_volcano(deg_data, x = "log2FoldChange", y = "padj",
                label = "row", label_number = 10, output = FALSE)
#修改散点和描边
library(RColorBrewer)

# Change the fill and color manually:
p1 <- gradual_volcano(data, x = "log2FoldChange", y = "padj",
                      fills = brewer.pal(5, "RdYlBu"),
                      colors = brewer.pal(8, "RdYlBu"),
                      label = "row", label_number = 10, output = FALSE)

p2 <- gradual_volcano(data, x = "log2FoldChange", y = "padj",
                      label = "row", label_number = 10, output = FALSE)+
  ggsci::scale_color_gsea()+
  ggsci::scale_fill_gsea()
#> Scale for 'colour' is already present. Adding another scale for 'colour', which
#> will replace the existing scale.
#> Scale for 'fill' is already present. Adding another scale for 'fill', which
#> will replace the existing scale.

library(patchwork)
p1|p2

使用term_volcano函数来绘制GO通路相关火山图。
基本用法
确保你有一个包含差异表达基因信息的DEG结果数据（数据需要包括：GeneName、Log2FC、pValue、FDR）。
除了DEG结果数据，你还需要一个通路数据，这是一个包含一些基因的GO通路信息的两列数据框。
如果你的数据没有名为 "regulate "的列，你可以使用add_regulate函数来添加，使用方法如下。
使用函数term_Volcano来制作GO通路相关火山图。你可以使用?term_Volcano来查看该函数的参数。
data("term_data")

# plot
term_volcano(deg_data, term_data,
             x = "log2FoldChange", y = "padj",
             label = "row", label_number = 10, output = FALSE)

修改散点颜色和描边
library(RColorBrewer)

# Change the fill and color manually:
deg_point_fill <- brewer.pal(5, "RdYlBu")
names(deg_point_fill) <- unique(term_data$term)

term_volcano(data, term_data,
             x = "log2FoldChange", y = "padj",
             normal_point_color = "#75aadb",
             deg_point_fill = deg_point_fill,
             deg_point_color = "grey",
             legend_background_fill = "#deeffc",
             label = "row", label_number = 10, output = FALSE)

