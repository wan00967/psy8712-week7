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



# Visualization
ggpairs(week7_tbl %>% 
          select(q1, q2, q3, q4, q5, q7, q8, q9, q10))

(week7_tbl %>%
  ggplot(aes(x = timeStart, y = q1)) +
  geom_point() +
  labs(x = "Time Start", y = "Q1 Score")) %>%
  ggsave("../figs/fig1.png", ., dpi = 600, height = 3, width = 5)
  
(week7_tbl %>% 
  ggplot(aes(x = q1, y = q2, color = gender)) +
  geom_jitter())%>%
  ggsave("../figs/fig2.png", ., dpi = 600, height = 4, width = 6)

(week7_tbl %>%
  ggplot(aes(x = q1, y = q2)) +
  geom_jitter() +
  facet_wrap(~gender) +
  labs(x = "Score on Q1", y = "Score on Q2")) %>%
  ggsave("../figs/fig3.png", ., dpi = 600, height = 3, width = 6)

(week7_tbl %>%
    ggplot(aes(x = gender, y = timeSpent)) +
  geom_boxplot() +
  labs(x = "Gender", y = "Time Spent (mins)")) %>%
  ggsave("../figs/fig4.png", ., dpi = 600, height = 4, width = 7.25)

(week7_tbl %>%
  ggplot(aes(x = q5, y = q7, color = condition)) +
  geom_jitter(width = 0.2, height = 0.2) +  
  geom_smooth(method = "lm", se = FALSE) +  
  labs(x = "Score on Q5", y = "Score on Q7", color= "Experimental Condition") +
  theme(legend.position = "bottom", legend.background = element_rect(fill = "#DFDFDF"))) %>%
  ggsave("../figs/fig5.png", ., dpi = 600, height = 4, width = 7)

