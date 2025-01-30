# Fill here the code to estimate the linear_model3 from the notebook
db_int <- db_int %>% filter(m1_std_residuals<2 & m1_std_residuals>-2 )
linear_model3<- lm(
  totalHoursWorked ~ ofic_ingLab + nmenores  +  nmenores*gender
                                 + H_Head + age + gender,
  data=db_int)



stargazer(linear_model, linear_model2, linear_model3  , type="text",
          covariate.labels=c("Mean Ocu Income","N under 18","Male",
                             "Hausehold Head","Age", "N under 18 x Male" ))
