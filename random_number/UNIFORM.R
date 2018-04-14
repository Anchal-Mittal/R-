#generate  random datasets using uniform distribution

#runif function is used to generate random number,with size,mead and standard deviation passed as a parameter

udata1=runif(size_of_clusters[1],3,5)
udata2=runif(size_of_clusters[1],3,5)
udist=matrix(c(udata1,udata2,rep(1,size_of_clusters[1])),nrow=size_of_clusters[1],ncol=3)
udist

