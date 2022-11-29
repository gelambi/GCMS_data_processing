rm(list=ls())

library(dplyr)
library(ggplot2)
library(ggpubr)

data <- read.csv("samplecomparison.csv")
head(data)

ChemStation <- data %>% filter(Sofware.tool %in% c("ChemStation/GCalignR")) # 38
metaMS <- data %>% filter(Sofware.tool %in% c("metaMS")) # 42
GNPS <- data %>% filter(Sofware.tool %in% c("GNPS")) # 97

ChemStation <- ggplot(ChemStation, aes(x = RT, y = area)) + 
  theme_classic(base_size = 15) +
  geom_jitter(width = 0.3, size = 3, alpha = 0.5) +
  geom_line(color = "grey",size = 1) +
  ylab ("Instrument response, ChemStation") +
  xlab ("Retention time") 

ChemStation

metaMS <- ggplot(metaMS, aes(x = RT, y = area)) + 
  theme_classic(base_size = 15) +
  geom_jitter(width = 0.3, size = 3, alpha = 0.5) +
  geom_line(color = "grey",size = 1) +
  ylab ("Instrument response, metaMS") +
  xlab ("Retention time") 

metaMS

GNPS <- ggplot(GNPS, aes(x = RT, y = area)) + 
  theme_classic(base_size = 15) +
  geom_jitter(width = 0.3, size = 3, alpha = 0.5) +
  geom_line(color = "grey",size = 1) +
  ylab ("Instrument response, GNPS") +
  xlab ("Retention time") 

GNPS

chromatograms <- ggarrange(ChemStation,
                           metaMS,
                           GNPS,
                           labels = c("A", "B", "C"),
                           ncol = 1, nrow = 3) 

chromatograms

ggsave(file="chromatograms.jpg", 
       plot= chromatograms,
       width=7,height=15,units="in",dpi=300)
