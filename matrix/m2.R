rowNames<-c("row1","row2","row3")
colNames<-c("col","col2","col3")

m2<-matrix(c(3:11),3,byrow="TRUE",dimnames=list(rowNames,colNames))
print(m2)

# printing first row and seconf column element
print(m2[1,2])

# no matrix 0 x0
print(m2[0,0])

# print
print(m2[4])

# not print first row nd print print second nd third row with 0 elements
print(m2[-1,0])

# not print first row nd print print second nd third row 3 elements
print(m2[-1,3])

# not print first row nd print print second nd third row 2 elements
print(m2[-1,2])
