#分组计算均值

psych::describe(inner_7_ug,trim = 0.01) -> inner_7_ug_mean
xlsx::write.xlsx(inner_7_ug_mean,"C:/Users/79403/Desktop/批量处理/7-ug/inner_mean.xlsx",sheetName = "Sheet1",col.names = TRUE,row.names = TRUE,append = FALSE,showNA = TRUE,password = NULL)
psych::describe(outer_7_ug,trim = 0.01) -> outer_7_ug_mean
xlsx::write.xlsx(outer_7_ug_mean,"C:/Users/79403/Desktop/批量处理/7-ug/outer_mean.xlsx",sheetName = "Sheet1",col.names = TRUE,row.names = TRUE,append = FALSE,showNA = TRUE,password = NULL)
psych::describe(inner_14_ug,trim = 0.01) -> inner_14_ug_mean
xlsx::write.xlsx(inner_14_ug_mean,"C:/Users/79403/Desktop/批量处理/14-ug/inner_mean.xlsx",sheetName = "Sheet1",col.names = TRUE,row.names = TRUE,append = FALSE,showNA = TRUE,password = NULL)
psych::describe(outer_14_ug,trim = 0.01) -> outer_14_ug_mean
xlsx::write.xlsx(outer_14_ug_mean,"C:/Users/79403/Desktop/批量处理/14-ug/outer_mean.xlsx",sheetName = "Sheet1",col.names = TRUE,row.names = TRUE,append = FALSE,showNA = TRUE,password = NULL)
psych::describe(inner_28_ug,trim = 0.01) -> inner_28_ug_mean
xlsx::write.xlsx(inner_28_ug_mean,"C:/Users/79403/Desktop/批量处理/28-ug/inner_mean.xlsx",sheetName = "Sheet1",col.names = TRUE,row.names = TRUE,append = FALSE,showNA = TRUE,password = NULL)
psych::describe(outer_28_ug,trim = 0.01) -> outer_28_ug_mean
xlsx::write.xlsx(outer_28_ug_mean,"C:/Users/79403/Desktop/批量处理/28-ug/outer_mean.xlsx",sheetName = "Sheet1",col.names = TRUE,row.names = TRUE,append = FALSE,showNA = TRUE,password = NULL)
psych::describe(inner_28_ug_alone,trim = 0.01) -> inner_28_ug_alone_mean
xlsx::write.xlsx(inner_28_ug_alone_mean,"C:/Users/79403/Desktop/批量处理/28-ug-alone/inner_mean.xlsx",sheetName = "Sheet1",col.names = TRUE,row.names = TRUE,append = FALSE,showNA = TRUE,password = NULL)
psych::describe(outer_28_ug_alone,trim = 0.01) -> outer_28_ug_alone_mean
xlsx::write.xlsx(outer_28_ug_alone_mean,"C:/Users/79403/Desktop/批量处理/28-ug-alone/outer_mean.xlsx",sheetName = "Sheet1",col.names = TRUE,row.names = TRUE,append = FALSE,showNA = TRUE,password = NULL)
psych::describe(inner_ctl,trim = 0.01) -> inner_ctl_mean
xlsx::write.xlsx(inner_ctl_mean,"C:/Users/79403/Desktop/批量处理/ctl/inner_mean.xlsx",sheetName = "Sheet1",col.names = TRUE,row.names = TRUE,append = FALSE,showNA = TRUE,password = NULL)
psych::describe(outer_ctl,trim = 0.01) -> outer_ctl_mean
xlsx::write.xlsx(outer_ctl_mean,"C:/Users/79403/Desktop/批量处理/ctl/outer_mean.xlsx",sheetName = "Sheet1",col.names = TRUE,row.names = TRUE,append = FALSE,showNA = TRUE,password = NULL)
psych::describe(inner_利血平造模,trim = 0.01) -> inner_利血平造模_mean
xlsx::write.xlsx(inner_利血平造模_mean,"C:/Users/79403/Desktop/批量处理/利血平造模/inner_mean.xlsx",sheetName = "Sheet1",col.names = TRUE,row.names = TRUE,append = FALSE,showNA = TRUE,password = NULL)
psych::describe(outer_利血平造模,trim = 0.01) -> outer_利血平造模_mean
xlsx::write.xlsx(outer_利血平造模_mean,"C:/Users/79403/Desktop/批量处理/利血平造模/outer_mean.xlsx",sheetName = "Sheet1",col.names = TRUE,row.names = TRUE,append = FALSE,showNA = TRUE,password = NULL)