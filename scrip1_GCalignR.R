rm(list=ls())

library(GCalignR) 

# Read data 

data <- ("input_GCalignR.txt")
check_input(data = data)

# Chromatogram aligment 

peak_data_aligned <- align_chromatograms(data = data, # input data
                                         rt_col_name = "RT", # retention time variable name 
                                         rt_cutoff_low = 0, # remove peaks below 0 Minutes
                                         rt_cutoff_high = 45, # remove peaks exceeding 45 Minutes
                                         reference = NULL, # choose automatically 
                                         max_linear_shift = 0.05, # max. shift for linear corrections
                                         max_diff_peak2mean = 0.03, # max. distance of a peak to the mean across samples
                                         min_diff_peak2peak = 0.03, # min. expected distance between peaks 
                                         delete_single_peak = FALSE, # delete peaks that are present in just one sample 
                                         write_output = NULL) # add variable names to write aligned data to text files

peaksaligned <- peak_data_aligned$aligned$Area
peaksaligned
write.csv(peaksaligned, file = "1_featuretable_GCalignR.csv")
