# ggplot
library(ggplot2) # lets start 

# lets understand the basic syntax then
ggplot(data,aes(x,y)) # thats the first one basic

# after this we have the geometry i.e geom_
# so lets take mtcars data set
cars <- mtcars

# now lets visulaise the scatterplot b/w mpg and wt
str(cars)

ggplot(data = cars,aes(x=mpg,y=wt)) + geom_point()
# we can see negetive correlation
cor(cars$mpg,cars$wt) #  -0.8676594 -ve cor

# now lets make this more intresting polt
ggplot(data = cars,aes(x=mpg,y=wt)) + geom_point(aes(size=cars$hp))
# the size will represent the hp or its power
# more we can do is
ggplot(data = cars,aes(x=mpg,y=wt)) + geom_point()

# see the cyl column it looks like factor variable
str(cars$cyl) # i.e i mean it has levels so it can be used in the plot basically
# but here it is considered as num , so dont get confused
# wait one more thing before we use factor here
# if we make it without that
ggplot(data = cars,aes(x=mpg,y=wt)) + geom_point(aes(size=cars$cyl))
# now see that it took all values form 4-8 , even when there are only 4,6,8
# so resolve this we used factor # and how we got to know was by seeing the col

ggplot(data = cars,aes(x=mpg,y=wt)) + geom_point(aes(size=factor(cars$cyl)))

# now we can use few more what should i say umm few more things to make it better
# we have size,color,shape as well

# now may be you are thinking that why we used aes in geom_point as well is it???
# basically it is when we want to use another col to customise the shapes and size n all
# lets do it then
ggplot(data = cars,aes(x=mpg,y=wt)) + geom_point(aes(color = factor(cars$cyl),
                                                     shape = factor(cars$cyl)))
# nice?? looks more intresting

# lables scatter plot of wt & mpg

ggplot(cars,aes(wt,mpg))+geom_point(size=2,shape=1,color="red")+
  geom_smooth(method = lm, se = F)+geom_label_repel(label= rownames(cars),color="brown")+
  xlab("Weight")+ylab("Miles per Gallon")+ggtitle("wt vs mpg scatter plot")+
  theme_classic()

lm(cars$wt~cars$mpg)

# here the data point lables are overlapping so we will use ggrepel

ggplot(cars,aes(wt,mpg))+geom_point(size=2.5,alpha=0.5,shape="circle")+
  geom_smooth(method = lm,se = F,linetype = "dashed")+geom_label_repel(label = rownames(cars),color = "red")+
  xlab("Weight")+ylab("Milles per Gallon")+ggtitle("Scatterplot b/w mpg and wt")+
  theme_classic()




# economist dataset visualisation
ecodata <- read.csv(file.choose(),header = T,sep = ",")

ecodata <- ecodata[,-1] # used to remove the first col as it was not needed

str(ecodata)
head(ecodata)

levels(ecodata$Region) 


# there is a operator known as match operator %in% syntax is data %in% condition
# for eg
c(1,4,8,9) %in% c(1:10)

c(1:10) %in% c(1,4,8,9) 

# lets do it


# extract data using subset

subset(ecodata,subset = ecodata$Country %in% countryname) # use of match operator

countryname <- c("Afghanistan","Argentina","Bangladesh","Brazil","Australia",
                 "Belgium","Congo","Sudan","Myanmar","Iraq","India","Russia",
                 "South Africa","China","Greece","Italy","Bhutan","Spain",
                 "France","US","Britain","Japan","Norway","New Zealand",
                 "Singapore","Barbados")



ggplot(ecodata,aes(log(CPI),HDI,color=Region))+geom_point(size=2.5,shape=1)+
  geom_smooth(aes(group=1),se = F,method = lm,formula = y~log(x))+
  geom_label_repel(aes(label=Country),data = subset(ecodata,ecodata$Country %in% countryname))+
  xlab("Corruption Perception Index,2011")+ylab("Human Devlopment Index,2011")+
  ggtitle("Coruption and Human Devlopment")+theme_classic()
  
# facet_grid()

ggplot(cars,aes(hp,mpg))+geom_point(aes(fill = factor(cyl),shape=factor(cyl)),color="red",alpha=0.5)+
  facet_grid(factor(cyl)~.)

# cartesian cooordinates
ggplot(cars,aes(hp,mpg))+geom_point(aes(fill = factor(cyl),shape=factor(cyl)),color="red",alpha=0.5)+
  facet_grid(factor(cyl)~.)+coord_cartesian(xlim = c(50,200),ylim = c(5,40))

# Boxplot
ggplot(cars,aes(factor(cyl),mpg))+geom_boxplot()

# if we want to flip the coordinates
ggplot(cars,aes(factor(cyl),mpg))+geom_boxplot()+
  coord_flip()

# heatmap
install.packages("ggplot2movies")
library(ggplot2movies)
ggplot(movies,aes(movies$year,rating))+geom_bin2d()
str(movies)

# Advance way of fitting the color in histogram
ggplot(movies,aes(rating))+
  geom_histogram(binwidth = 0.1,aes(fill=..count..))
