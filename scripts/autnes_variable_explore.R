#####################################################################################
##
##    File Name:        autnes_levels.R
##    Date:             2021-02-11
##    Author:           Daniel Weitzel
##    Email:            daniel.weitzel@univie.ac.at
##    Webpage:          www.danweitzel.net
##    Purpose:          Quick script to examine type of variable in the data set for ML model
##    Data Used:        Multi mode: 10025_da_en_v1_0.dta, Online mode: 10017_da_en_v2_0.dta
##    Output File:      (none)
##    Data Output:      (none)
##    Data Webpage:     (none)
##    Log File:         (none)
##    Notes:            Data available at: https://autnes.at/en/autnes-data/general-election-2017
##
#####################################################################################

## Setting the working directory
setwd(githubdir)
setwd("autnes_visualizations")

## This loads the required packages, if they are not installed it also installs them
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, readstata13)


## Load the data sets
## df_multi is the three wave multi-mode panel. Waves 1-2 were conducted before the election
## and wave 3 was after the election. Each wave was doneon the phone and online. 
## df_online is the six wave online panel. Waves 1-4 are pre-election panel waves,
## waves 5-6 are post-election panel waves.
## more information available on panel structure here:
## https://autnes.at/en/autnes-data/general-election-2017

#df_multi  <- read.dta13("data/10025_da_en_v1_0.dta")
df_online <- read.dta13("data/10017_da_en_v2_0.dta")


 ### Levels
wave1 <-
  df_online %>% 
  filter(w1_panelist == 1)  %>% 
  dplyr::select(id, starts_with("w1_"), -c(w1_panelist:w1_dte))
cat <- sapply(wave1, is.factor)
index3 <- sapply(wave1[,cat], nlevels)<4
index5 <- sapply(wave1[,cat], nlevels)<6
index7 <- sapply(wave1[,cat], nlevels)<8
t3 <- ncol(wave1[,cat][,index3, drop=FALSE])
t5 <- ncol(wave1[,cat][,index5, drop=FALSE])
t7 <- ncol(wave1[,cat][,index7, drop=FALSE])

wave2 <-
  df_online %>% 
  filter(w1_panelist == 2)  %>% 
  dplyr::select(id, starts_with("w2_"), -c(w2_panelist:w2_dte))
cat <- sapply(wave2, is.factor)
index3 <- sapply(wave2[,cat], nlevels)<4
index5 <- sapply(wave2[,cat], nlevels)<6
index7 <- sapply(wave2[,cat], nlevels)<8
t3 <- ncol(wave2[,cat][,index3, drop=FALSE])
t5 <- ncol(wave2[,cat][,index5, drop=FALSE])
t7 <- ncol(wave2[,cat][,index7, drop=FALSE])

wave3 <-
  df_online %>% 
  filter(w3_panelist == 1)  %>% 
  dplyr::select(id, starts_with("w3_"), -c(w3_panelist:w3_dte))
cat <- sapply(wave3, is.factor)
index3 <- sapply(wave3[,cat], nlevels)<4
index5 <- sapply(wave3[,cat], nlevels)<6
index7 <- sapply(wave3[,cat], nlevels)<8
t3 <- ncol(wave3[,cat][,index3, drop=FALSE])
t5 <- ncol(wave3[,cat][,index5, drop=FALSE])
t7 <- ncol(wave3[,cat][,index7, drop=FALSE])

wave4 <-
  df_online %>% 
  filter(w4_panelist == 1)  %>% 
  dplyr::select(id, starts_with("w4_"), -c(w4_panelist:w4_dte))
cat <- sapply(wave4, is.factor)
index3 <- sapply(wave4[,cat], nlevels)<4
index5 <- sapply(wave4[,cat], nlevels)<6
index7 <- sapply(wave4[,cat], nlevels)<8
t3 <- ncol(wave4[,cat][,index3, drop=FALSE])
t5 <- ncol(wave4[,cat][,index5, drop=FALSE])
t7 <- ncol(wave4[,cat][,index7, drop=FALSE])

wave5 <-
  df_online %>% 
  filter(w5_panelist == 1)  %>% 
  dplyr::select(id, starts_with("w5_"), -c(w5_panelist:w5_dte))
cat <- sapply(wave5, is.factor)
index3 <- sapply(wave5[,cat], nlevels)<4
index5 <- sapply(wave5[,cat], nlevels)<6
index7 <- sapply(wave5[,cat], nlevels)<8
t3 <- ncol(wave5[,cat][,index3, drop=FALSE])
t5 <- ncol(wave5[,cat][,index5, drop=FALSE])
t7 <- ncol(wave5[,cat][,index7, drop=FALSE])

wave6 <-
  df_online %>% 
  filter(w6_panelist == 1)  %>% 
  dplyr::select(id, starts_with("w6_"), -c(w6_panelist:w6_dte))

cat <- sapply(wave6, is.factor)
index3 <- sapply(wave6[,cat], nlevels)<4
index5 <- sapply(wave6[,cat], nlevels)<6
index7 <- sapply(wave6[,cat], nlevels)<8
t3 <- ncol(wave6[,cat][,index3, drop=FALSE])
t5 <- ncol(wave6[,cat][,index5, drop=FALSE])
t7 <- ncol(wave6[,cat][,index7, drop=FALSE])


rm(df_online, wave1, wave2, wave3, wave4, wave5, wave6, index3, index5, index7,
   t3, t5, t7)
