## Install Packages

if(!require(pacman)) install.packages("pacman") ; require(pacman)


p_load(rio, # import/export data
       tidyverse, # tidy-data
       skimr, # summary data
       gridExtra, # visualizing missing data
       corrplot, # Correlation Plots 
       stargazer, # tables/output to TEX. 
       MASS # various statistical functions
       )   


# load data
db <- import("https://github.com/ignaciomsarmiento/datasets/blob/main/GEIH_sample1.Rds?raw=true")
db <- as_tibble(db) %>% rename(gender=sex) 


# Create variables
db_of<- db %>% 
      group_by(oficio, gender)  %>% 
      summarise(ofic_ingLab= mean(y_ingLab_m, na.rm=T), .groups="drop") %>%
      mutate(ofic_ingLab= ofic_ingLab/1000000)

db_of  %>% dplyr:: select(oficio, gender, ofic_ingLab) %>% head(4)



# merge with the original data set
db_int <- db %>% inner_join(db_of, by=c("oficio", "gender"))


summary(db_int$totalHoursWorked)
summary(db_int$ofic_ingLab)


# child indicator
db_int <- db_int %>%
  mutate(flag = ifelse(age <= 18, 1, 0))

#  total number of children per household

db_int <- db_int %>%
  group_by(directorio, secuencia_p) %>%
  mutate(nmenores = sum(flag)) %>%
  dplyr::select(-flag) %>% 
  ungroup()


db_int %>% dplyr:: select(directorio, secuencia_p, age , nmenores ) %>% tail()


# subset  with people with positive labor force supply participation
db_int= db_int %>% filter(totalHoursWorked>0)

