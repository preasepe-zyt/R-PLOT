
library(dae)
data(SPLGrass.dat)
interaction.ABC.plot(Main.Grass, x.factor=Period,
                     groups.factor=Spring, trace.factor=Summer,
                     data=SPLGrass.dat,
                     title="Effect of Period, Spring and Summer on Main Grass")
data(ABC.Interact.dat)
ABC.Interact.dat$se <- rep(c(0.5,1), each=4)

interaction.ABC.plot(选课态度,心理资本,说服信息, 课程难度,  data=anova)-> p
interaction.ABC.plot(选课态度,心理资本,课程难度, 说服信息,  data=anova) -> p2
interaction.ABC.plot(选课态度,课程难度,说服信息,心理资本,   data=anova) -> p3
interaction.ABC.plot(选课态度,课程难度,心理资本,说服信息,   data=anova) -> p4
interaction.ABC.plot(选课态度,说服信息,课程难度,心理资本,   data=anova) -> p5
interaction.ABC.plot(选课态度,说服信息,心理资本,课程难度,   data=anova) -> p6

p + p2 + p3 | p4 + p5 + p6
