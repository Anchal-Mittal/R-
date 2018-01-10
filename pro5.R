week <-c("sun","mon","tues","wed","thur","fri","sat")
print(week)

#printing only 2,4,6 element
u<- week[c(2,6,4)]
print(u)

#printing only 2 index element
u<- week[c(0,0,2)]
print(u)

#giving negative index wil drop the possition
u<- week[c(-1,-6,-2)]
print(u)
