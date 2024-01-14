library(multipanelfigure)
#Adding panels
library(lattice)
library(magrittr)
figure1 <- multi_panel_figure(
    width = 120, height = 100,
    columns = 2, rows = 8) %>% 
    fill_panel("Rplot06.pdf",
                     column = 1,row=1,
                     scaling = "fit") %>%
    fill_panel("Rplot06.pdf",
               column = 1,row=2,
               scaling = "fit") %>%
    fill_panel("Rplot06.pdf",
               column = 2,row=1,
               scaling = "fit")


figure2 <- multi_panel_figure(
    width = c(20, 30, 40),
    height = c(10, 20, 30))

a_lattice_plot <- xyplot(height ~ age, Loblolly)
figure1 %<>% fill_panel("Rplot06_00.png",
                        column = 1,
                        row=1,
                        scaling = "fit")
figure1 %<>% fill_panel("Rplot06_00.png",
                        column = 2,
                        row=1,
                        scaling = "fit")
figure1 %<>% fill_panel(
    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Persian_Cat_%28kitten%29.jpg/657px-Persian_Cat_%28kitten%29.jpg",
    column = 2:2,
    row = 2,
    scaling = "fit")

