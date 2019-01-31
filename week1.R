#The first thing I did was set the WD by going to sesson -> set Working Directory 

###Question 2###
#I read in the csv file 
lizards<-read.csv("lizards.csv")

#I used the View function to pull up the data to view
View(lizards)

#use head to check top few rows in df lizards
head(lizards)

#View only rows where the time column has a value of "early"
lizards[lizards$time=="early",]
View(lizards[lizards$time=="early",])

#call all rows from a specific column (all rows in column 3, height)
View(lizards[,3])

summary(lizards)
#summary outputs summary statistics for each column 

####Question3###
#histogram of lizard$gfrac to check distribution, data not normally distributed, 
#so I will log transform in order to (hopefully) achieve normality 
hist(lizards$gfrac)

#add new column by (log + 1) transforming gfrac column. 
lizards$log1gfrac<-log1p(lizards$gfrac)

#check normality of transformed column, didn't help oh well 
hist(lizards$log1gfrac)

#add in a tally column to easily count stuff
lizards$tally<-1

###Question4###
#aggregate stuff! with piping and not 
#using median as the function. Not really comfotable with piping after all, so going to do it without
f1<-lizards%>%
  subset(grahami > 7)%>%
  aggregate(.~time, ., FUN = median)

#Aggregate lizards dataset by different variables and functions

f1<-aggregate(tally~time+light,FUN=sum, data=lizards)
f2<-aggregate(tally~grahami+gfrac, FUN=mean, data=lizards)

#create a table
tab1<-table(lizards$time,lizards$light)
