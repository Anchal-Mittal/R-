####   Lists and data frames   ###

### Lists: creation
(my_list <- list(c(1,2,3,4,5), month.name, matrix(c(1,2,3,4), nrow = 2, ncol = 2)))

### Lists: naming of elements
names(my_list) <- c("myVector", "Months", "myMatrix")

### Lists: creation + naming
(my_list2 <- list(myVector = c(1,2,3,4,5), 
                 Months = month.name, 
                 myMatrix = matrix(c(1,2,3,4), nrow = 2, ncol = 2)))


### It is possible for elements of lists to be lists themselves

### Combining lists
(my_list3 <- c(list(a = 1, b = 3), c = list(c(1,2,3,4))))

### convert lists to vectors using unlist() function
unlist(my_list3)


######################################################


### Data frames: creation
my_df <- data.frame(letters = letters[1:5],
                    nums = c(1,2,3,4,5),
                    norm_dist_nums = rnorm(5), #generates random numbers from normal distribution
                    logical = runif(5) > 0.5) #generate n uniform random numbers lie in the interval (min, max)


my_df


my_df$letters

length(my_df)

length(my_df$letters)

my_df2 <- data.frame(letters = letters[3:7],
                     norm_dist_nums = rnorm(5), #generates random numbers from normal distribution
                     nums = c(1,2,3,4,5),
                     logical = runif(5) > 0.5) #generate n uniform random numbers lie in the interval (min, max)


my_df2

### join two data frames
rbind(my_df, my_df2)    ### smart!!! but does not work when column names are different in the data frames

cbind(my_df, my_df2)    ### Not smart!!! just appends the columns from the 2nd data frame to those of the 1st data frame

### merge two data frames using common column
merge(my_df, my_df2, by = "letters") 
merge(my_df, my_df2, by = "letters", all = TRUE)


### colsums and colmeans
colSums(my_df[, 2:3])
colMeans(my_df2[, 2:3])


### reading from and writing to files
my_df
write.csv(my_df, file = "/Users/ANCHAL/Desktop/Msc lab/sample.csv", row.names = FALSE) ### if col.names = FALSE, the header will not be saved, by default col.names = TRUE

read_mydf <- read.csv(file = "/Users/ANCHAL/Desktop/Msc lab/sample.csv", header = FALSE) ### if header = TRUE, first row is treated as header
read_mydf
