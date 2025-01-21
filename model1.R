# drop missing values in each variable (but you are invited to check if there is 
# an imputation method that can be useful)
# this to include post estimation variables in the data set


features<- c("ofic_ingLab", "nmenores",  "H_Head",  "age",  "gender" )

db_int<- db_int %>% drop_na(any_of(features))



## Regression
linear_model<- lm(totalHoursWorked ~ ofic_ingLab + nmenores  +  nmenores*gender + H_Head + age + gender, data=db_int  )
summary(linear_model)

