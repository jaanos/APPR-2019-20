

data_EU <- merge(World, podatki_svet, by.x="iso_a3", by.y="iso_code")
data_EU <- data_EU %>% filter(continent.x == "Europe")
data_EU$date = as.integer(as.Date(data_EU$date,format="Y%-m%-d%")) - min(as.integer(as.Date(data_EU$date,format="Y%-m%-d%")))
data_EU$area = as.integer(data_EU$area )
data_EU["economy2"]=rep(0,nrow(data_EU))
data_EU["income_grp2"]=rep(0,nrow(data_EU))
for(i in 1:nrow(data_EU)){
  data_EU$economy2[i] = which(levels(data_EU$economy) %in% as.character(data_EU$economy[i]))
  data_EU$income_grp2[i] = which(levels(data_EU$income_grp) %in% as.character(data_EU$income_grp[i]))
}
data_SLO <- data_EU %>% filter(name=="Slovenia")
data_EU <- data_EU %>% filter(name != "Slovenia")
data_EU_Y = data_EU[,"total_cases"]
data_SLO_Y = data_SLO[,"total_cases"]

data_EU <- data_EU[,c("area","pop_est","gdp_cap_est","life_exp","well_being","footprint","inequality",
                      "HPI","date","new_tests","economy2","income_grp2","total_cases")]
data_SLO <-data_SLO[,c(5:7,10:15,18,19,23,25,27,28)]


data_EU=as.matrix(data)


n <- neuralnet(medv ~ crim + zn + indus + chas + nox + rm + age + dis + rad + tax + ptratio + b + lstat,
               data=data,
               hidden = c(10,5),
               linear.output = F,
               lifesign = "full",
               rep=1)




data=as.matrix(data)
dimnames(data)= NULL
ind <- sample(2,nrow(data),replace = T,prob=c(0.7,0.3))
training = data[ind==1,1:13]
test = data[ind==2,1:13]
traingingtarget=data[ind==1,14]
testtarger=data[ind==2,14]

#normalize
m <- colMeans(training)
s <- apply(training,2,sd)
training <- scale(training, center=m,scale= s)
test <- scale(test,center=m,scale=s)

#create model

model <- keras_model_sequential() 
model %>%
  layer_dense(units = 5,activation = "relu", input_shape = c(13)) %>%
  layer_dense(units=1)

#compile

model %>% compile(loss="mse",
                  optimizer = "rmsprop",
                  metrics = "mae")
#fit model

mymodel <- model  %>% fit(training,
                          traingingtarget,
                          epochs=200,
                          batch_size=32,
                          validation_split=0.2)

model %>% evaluate(test, testtarger)
pred <- model %>% predict(test)
mean((testtarger-pred)^2)






###########################
model <- keras_model_sequential() 
model %>%
  layer_dense(units = 100,activation = "relu", input_shape = c(13)) %>%
  layer_dropout(rate=0.4) %>% 
  layer_dense(units = 50,activation = "relu", input_shape = c(13)) %>%
  layer_dropout(rate=0.4) %>% 
  layer_dense(units = 30,activation = "relu", input_shape = c(13)) %>%
  layer_dropout(rate=0.4) %>% 
  layer_dense(units = 10,activation = "relu", input_shape = c(13)) %>%
  layer_dense(units = 5,activation = "relu", input_shape = c(13)) %>%
  layer_dense(units=1)

summary(model)
#compile
plot(mymodel)
model %>% compile(loss="mse",
                  optimizer = "rmsprop",
                  metrics = "mae")
#fit model

mymodel <- model  %>% fit(training,
                          traingingtarget,
                          epochs=100,
                          batch_size=32,
                          validation_split=0.2)
