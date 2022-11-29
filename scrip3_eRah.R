rm(list=ls())

#if (!require("BiocManager", quietly = TRUE))
# install.packages("BiocManager")

#BiocManager::install("mzR")

library(erah)
library(Rcpp)
library(mzR)

createdt("~/Desktop/dataprocessing/data/eRah") # This step creates the two .csv files 
ex_alk <- newExp(instrumental="~/Desktop/dataprocessing/data/eRah/eRah_inst.csv",
                 phenotype = "~/Desktop/dataprocessing/data/eRah/eRah_pheno.csv") # create a new experiment
metaData(ex_alk) # check that everything looks good
phenoData(ex_alk)

# Deconvolution 
ex.dec.par <- setDecPar(min.peak.width=1.5, min.peak.height=5000, 
                        noise.threshold=500, avoid.processing.mz=c(35:69,73:75,147:149), 
                        analysis.time=c(12,15))
ex_bat_dec <- deconvolveComp(ex_alk, ex.dec.par)

# Save
save(ex_bat_dec, file = "deconvolution_alk.rda")
# Load
load("deconvolution_alk.rda")

# Alignment
ex.al.par <- setAlPar(min.spectra.cor = 0.90,
                      max.time.dist = 0.1)
ex_alk <- alignComp(ex_bat_dec, alParameters = ex.al.par)
ex_alk <- recMissComp(ex_alk, min.samples = 3, free.model = FALSE)
alignment <- alignList(ex_alk, by.area=TRUE)
alignment

write.csv(alignment, file = "featuretable.csv")