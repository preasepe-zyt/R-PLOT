library(bio3d) 
demo("pdb") 
demo("pca") 
demo("md") 
library(bio3d)
require(bio3d); require(graphics);
pause <- function() cat("Press ENTER/RETURN/NEWLINE to continue.")
pause()
trtfile <- system.file
(“D:/Program Files/R/R-4.1.0/bin/x64/start.dcd”,package=”bio3d”)
dcd <- read.dcd(“D:/Program Files/R/R-4.1.0/bin/x64/start.dcd”) (#定位到.dcd和.pdb所在的文件夹)
  pdbfile <- system.file
  (“D:/ProgramFiles/R/R-4.1.0/bin/x64/start.pdb”,package=”bio3d”)
  pdb <- read.pdb(“D:/ProgramFiles/R/R-4.1.0/bin/x64/start.pdb “)
  print(pdb)
  pause()
  dim(dcd)
  ncol(dcd) == length(pdb$xyz)
  pause ()
  ca.inds <- atom.select(pdb, elety = “CA”)
  xyz <- fit.xyz(fixed = pdb$xyz, mobile = dcd,
                 fixed.inds = ca.inds$xyz,
                 mobile.inds = ca.inds$xyz)
  DCCM的计算:
    cij <- dccm(xyz[,ca.inds$xyz])
  plot(cij)