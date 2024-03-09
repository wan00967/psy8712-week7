# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(GGally)



# Data Import and Cleaning
week7_tbl <- read_csv("../data/week3.csv") %>%
  mutate(timeStart = as.POSIXct(timeStart, format = "%Y-%m-%d %H:%M:%S"),
         timeEnd = as.POSIXct(timeEnd, format = "%Y-%m-%d %H:%M:%S"),
         timeSpent = as.numeric(difftime(timeEnd, timeStart, units = "mins"))) %>%  #why is it negative?? i can't fix it
  mutate(across(q1:q10, as.numeric)) %>%
  mutate(condition = factor(condition, levels = c("A", "B", "C"), labels = c("Block A", "Block B", "Control"))) %>%
  mutate(gender = factor(gender, levels = c("M", "F"), labels = c("Male", "Female"))) %>%
  filter(q6 == 1) %>%
  select(-q6)