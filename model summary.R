modelsummary is very easy to use. This simple call often suffices:
  
  library(modelsummary)

mod <- lm(y ~ x, dat)
modelsummary(mod)
The command above will automatically display a summary table in the Rstudio Viewer or in a web browser. All you need is one word to change the output format. For example, a text-only version of the table can be printed to the Console by typing:
  
  modelsummary(mod, output = "markdown")
Tables in Microsoft Word and LaTeX formats can be saved to file by typing:
  
  modelsummary(mod, output = "table.docx")
modelsummary(mod, output = "table.tex")