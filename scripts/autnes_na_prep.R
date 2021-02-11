#####################################################################################
##
##    File Name:        autnes_na_prep.R
##    Date:             2021-02-11
##    Author:           Daniel Weitzel
##    Email:            daniel.weitzel@univie.ac.at
##    Webpage:          www.danweitzel.net
##    Purpose:          Visualizing unit and item nonresponse in the AUTNES data
##    Date Used:        2021-02-11
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
pacman::p_load(tidyverse, readstata13, ggalluvial, naniar)


## Load the data sets
## df_multi is the three wave multi-mode panel. Waves 1-2 were conducted before the election
## and wave 3 was after the election. Each wave was done on the phone and online. 
## df_online is the six wave online panel. Waves 1-4 are pre-election panel waves,
## waves 5-6 are post-election panel waves.
## more information available on panel structure here:
## https://autnes.at/en/autnes-data/general-election-2017

#df_multi  <- read.dta13("data/10025_da_en_v1_0.dta")
df_online <- read.dta13("data/10017_da_en_v2_0.dta")

## Cleaning the data sets, NA need to be recoded, empty character strings need to be recoded as NA
# df_multi  <- 
#   df_multi %>% 
#   mutate_if(is.factor, list(~na_if(., "refused"))) %>% 
#   mutate_if(is.character, list(~na_if(., "refused"))) %>% 
#   mutate_if(is.character, list(~na_if(., ""))) %>% 
#   mutate_if(is.numeric, list(~na_if(., 99))) 


df_online <-
  df_online %>%
  mutate_if(is.factor, list(~na_if(., "refused"))) %>%
  mutate_if(is.character, list(~na_if(., "refused"))) %>%
  mutate_if(is.character, list(~na_if(., ""))) %>%
  mutate_if(is.numeric, list(~na_if(., 99)))

## Exploring the panel data set df_online
## Generating six new data frames for each individual wave
online_wave_1 <-
  df_online %>% 
  filter(w1_panelist == 1) %>% 
  dplyr::select(id, starts_with("w1_"), -c(w1_panelist:w1_dte)) 


online_wave_2 <-
  df_online %>% 
  filter(w2_panelist == 1) %>% 
  dplyr::select(id, starts_with("w2_"), -c(w2_panelist:w2_dte)) 

online_wave_3 <-
  df_online %>% 
  filter(w3_panelist == 1) %>% 
  dplyr::select(id, starts_with("w3_"), -c(w3_panelist:w3_dte)) 

online_wave_4 <-
  df_online %>% 
  filter(w4_panelist == 1) %>% 
  dplyr::select(id, starts_with("w4_"), -c(w4_panelist:w4_dte)) 

online_wave_5 <-
  df_online %>% 
  filter(w5_panelist == 1) %>% 
  dplyr::select(id, starts_with("w5_"), -c(w5_panelist:w5_dte)) 


online_wave_6 <-
  df_online %>% 
  filter(w6_panelist == 1) %>% 
  dplyr::select(id, starts_with("w6_"), -c(w6_panelist:w6_dte)) 


## NA visualization of each wave 
vis_miss(online_wave_1, warn_large_data = FALSE) 
vis_miss(online_wave_2, warn_large_data = FALSE)
vis_miss(online_wave_3, warn_large_data = FALSE)
vis_miss(online_wave_4, warn_large_data = FALSE)
vis_miss(online_wave_5, warn_large_data = FALSE)
vis_miss(online_wave_6, warn_large_data = FALSE)

## NOTES: A lot of forced responses where individuals could not opt out and had to pick an answer option
## Missingness occurs in two ways: 1) through survey item logic (e.g. first larger block of missigness 
## in the first wave is due to the survey question: "What do ou think is the most important issue?" and 
## then individuals were given a long list of possible issues. Whenever a survey respondent picked the issue
## it is 1 otherwise NA. A second type of missigness occurs when questions were conditional on previous questions
## Like: Only asks this to respondents who said that they voted or that they voted for the SPOE


## Some NA visualizations to check the type of questions were missigness occurs. 
## Y-axis observation labels can be cross-referenced with data frame or code book
gg_miss_var(online_wave_1)
gg_miss_var(online_wave_2)
gg_miss_var(online_wave_3)
gg_miss_var(online_wave_4)
gg_miss_var(online_wave_5)
gg_miss_var(online_wave_6)

### Another type of missigness is survey nonresponse
### In the plot below I use an alluvial plot to show movement in (1) and out (0) of the sample
### Included are only individuals that participated in the first wave (we have no info on people that did not complete the first wave)
### Colors stand for one of the many possible participation-nonparticipation combination (theoretically 2^6) across all waves. 
### We can see: Large number of participants (~1800) participates throughout the survey. Roughly 500 never participate again after the first wave
### and between waves there is considerable movement in and out of the survey. 

df_online %>% 
  dplyr::select(w1_panelist, w2_panelist, w3_panelist, 
                w4_panelist, w5_panelist, w6_panelist) %>% 
  group_by(w1_panelist, w2_panelist, w3_panelist, 
           w4_panelist, w5_panelist, w6_panelist) %>% 
  mutate_at(c(1:6), as.factor) %>% 
  add_tally(name = "freq") %>% 
  ungroup() %>% unique %>% 
  unite(type, c(w1_panelist, w2_panelist, w3_panelist, 
                w4_panelist, w5_panelist, w6_panelist), sep = ",", remove = FALSE) %>% 
  filter(w1_panelist == 1) %>% 
  ggplot(aes(y = freq,
             axis1 = w1_panelist, axis2 = w2_panelist, axis3 = w3_panelist,
             axis4 = w4_panelist, axis5 = w5_panelist, axis6 = w6_panelist)) +
  geom_alluvium(aes(fill = type),
                width = 0, knot.pos = 0, reverse = FALSE) +
  guides(fill = FALSE) +
  geom_stratum(width = 1/8, reverse = FALSE) +
  geom_text(stat = "stratum", aes(label = after_stat(stratum)),
            reverse = FALSE) +
  scale_x_continuous(breaks = 1:6, labels = c("W1", "W2", "W3", "W4", "W5", "W6")) +
  coord_flip() +
  labs(title = "Online Survey 2017", subtitle = "Participation across waves for individuals taking 1st wave",
       caption = "Data used six wave online panel of AUTNES 2017", y = "Frequency", x = "Wave") + theme_minimal()       
#ggsave("figures/generated/alluvial_attrition.pdf")
#ggsave("figures/generated/alluvial_attrition.png")

### Note: Analysis for the multi-mode survey is analogous but not included in the script. 

### Cleaning up the workspace
rm(online_wave_1, online_wave_2, online_wave_3, online_wave_4, online_wave_5, online_wave_6,
   df_alluvium, df_online)

# fin
