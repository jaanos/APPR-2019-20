
data<- read_csv("podatki/korona_po svetu_csv.csv",
                                    
                                    col_types=cols(.default=col_number(),
                                                   
                                                   iso_code=col_character(),
                                                   
                                                   continent=col_character(),
                                                   
                                                   location=col_character(),
                                                   
                                                   date=col_date(),
                                                   
                                                   tests_units=col_character()))





data$date = as.integer(as.Date(data$date,format="Y%-m%-d%")) - min(as.integer(as.Date(data$date,format="Y%-m%-d%")))
data_SLO=data %>% filter(location == "Slovenia",is.na(total_tests)==FALSE,is.na(total_cases)==FALSE)
data = data %>% filter(location != "Slovenia")
data = data[,c(4,9,14,23,25:27,30:31,36)]
data_SLO = data_SLO[,c(4,9,14,23,25:27,30:31,36)]
data = data %>% filter(is.na(total_cases_per_million)==FALSE,is.na(total_tests)==FALSE,
                       is.na(median_age)==FALSE,is.na(aged_65_older)==FALSE,is.na(cardiovasc_death_rate)==FALSE,
                       is.na(aged_70_older)==FALSE)


data=as.matrix(data)
data=  mapply(data, FUN=as.numeric)
data <- matrix(data, ncol=10, nrow=10472)
dimnames(data)= NULL
training = data[,c(1,3:10)]
traingingtarget=data[,c(2)]

data_SLO = as.matrix(data_SLO)
data_SLO =  mapply(data_SLO, FUN=as.numeric)
data_SLO<- matrix(data_SLO, ncol=10, nrow=145)
dimnames(data_SLO)= NULL
test = data_SLO[,c(1,3:10)]
testtarget = data_SLO[,c(2)]
#normalize
m <- colMeans(training)
s <- apply(training,2,sd)
training <- scale(training, center=m,scale= s)
test <- scale(test,center=m,scale=s)


#model
model <- keras_model_sequential() 

model %>% 
  layer_dense(units = 50,activation = "relu", input_shape = c(9)) %>%
  layer_dropout(rate=0.4) %>% 
  layer_dense(units = 10,activation = "relu", input_shape = c(9)) %>%
  layer_dropout(rate=0.2) %>% 
  layer_dense(units=1)


#compile

model %>% compile(loss="mse",
                  optimizer = "rmsprop",
                  metrics = "mae")
#fit model
mymodel <- model  %>% fit(training,
                          traingingtarget,
                          epochs=80,
                          batch_size=36,
                          validation_split=0.2)


df <- data.frame("cases_per_million"= c(model %>% predict(test),testtarget),
                 "tip" = c(rep("predikcija",length(model %>% predict(test))),
                           rep("realizacija",length(testtarget))),
                 "datum" = c(seq(as.Date("2020-03-12"),
                                 as.Date("2020-08-03"),"day"),
                             seq(as.Date("2020-03-12"),
                                 as.Date("2020-08-03"),"day")))

ggplot(df,aes(x=datum, y=cases_per_million,col=tip))+geom_line()


