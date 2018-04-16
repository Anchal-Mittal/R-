cluster_size<- sample(50:100,5)
library(MASS) #for mvrnorm
#   NORMAL DISTRIBUTION 1   
norm1<-data.frame(mvrnorm(cluster_size[1],mu=c(-1,-5),Sigma = diag(2)),rep(1))
names(norm1)<-c("x","y","label")
plot(x=norm1$x,y=norm1$y,pch=20)

# NORMAL DISTRIBUTION 2
#dia= matrix(c(4,2,2,9),nrow = 2)
norm2<-data.frame(mvrnorm(cluster_size[2],mu=c(-5,0),Sigma = diag(2)),rep(2))
names(norm2)<-c("x","y","label")
plot(x=norm2$x,y=norm2$y,pch=20)

# NORMAL DISTRIBUTION 3
#dia=matrix(c(4,1,1,9),nrow = 2)
norm3<-data.frame(mvrnorm(cluster_size[3],mu=c(-6,-6),Sigma = diag(2)),rep(3))
names(norm3)<-c("x","y","label")
plot(x=norm3$x,y=norm3$y,pch=20)


#======================================EXPONENTIAL DISTRIBUTION==========================================

x1<-data.frame(rexp(cluster_size[4],rate = 1.5))
names(x1)<-c("x")
x2<-data.frame(rexp(cluster_size[4],rate =0.8 ),rep(4))
names(x2)<-c("y","label")
expdata<-cbind(x1,x2)
plot(x=expdata$x,y=expdata$y,pch=20)

#========================================= UNIFORM DISTRIBUTION===========================================

x1<-data.frame(runif(cluster_size[5],min =-6 , max = -1))
names(x1)<-c("x")
x2<-data.frame(runif(cluster_size[5],min = 3,max = 5),rep(5))
names(x2)<-c("y","label")
uniformd<-cbind(x1,x2)

#===========================================dataset======================================================

dataset<- rbind(norm1,norm2,norm3,expdata,uniformd)
mycol=c("red", "blue", "yellow","black", "magenta")
plot(x=dataset$x,y=dataset$y,col=mycol[dataset$label],pch=20,xlab = "x-coordinate",ylab = "y-coordinate",main="dataset dataset " )
legend("bottomleft",legend=levels(factor(dataset$label)),pch=20,col=mycol)
text(-2,-5,"No.of data points :")
text(2,-5,sum(cluster_size))


#======================================creating purity function===========================================
purity<-function(clust,w)
{
  n<-w
  resultq<-clust  
  
  ## confusion matrix
  t1<-table( resultq,dataset$label)
  colnames(t1)<-c("t1","t2","t3","t4","t5")
  
  each<-sample(1:n,n)
  ## intialization of array
  for(i in 1:n)
  {
    each[i]=0
  }
  
  ##calculating purity
  for(i in 1:n)
  {
    for(j in 1:5)
    {
      if(each[i]<t1[i,j])
        each[i]=t1[i,j]
      
    }
  }  
  s1<-sum(each)
  total<-sum(cluster_size)
  purity<-s1/total
  }

# k-means 
result1<-kmeans(dataset[,1:2],5)
result1
library(cluster)
kpurity<-purity(result1$cluster,5)
kpurity
##kmeans SSE
SSE<-0
for(i in 1:nrow(dataset))
{
  SSE<-SSE+ (result1$center[result1$cluster[i]]-dataset[i,1])^2+(result1$center[result1$cluster[i],2]-dataset[i,2])^2
  
}

SSE

#nrow(dataset)
#clusteris<-array(dim=c(1))
#for(i in 1:nrow(dataset))
#{
  
#}
mycol=c("red", "blue", "green","black", "magenta")
plot(x=dataset$x,y=dataset$y,col=mycol[result1$cluster],pch=20,xlim=c(-10,6),ylim=c(-10,10),xlab = "x-coordinate",ylab = "y-coordinate",main="kmeans " )
legend("bottomleft",legend=levels(factor(result1$cluster)),pch=20,col=mycol)
text(x=5,y=-5,labels=paste("Purity =",kpurity))
text(x=5,y=-8.7,labels=paste("SSE =", SSE))



## hierarchical clustering
library(cluster)
clusters <- hclust(dist(dataset[,1:2]))
clusters
plot(clusters)
result2<-cutree(clusters,5)
hpur<-purity(result2,5)
hpur

##hierarchical SSE
ax<-numeric(5)
ay<-numeric(5)
an<-numeric(5)
for(i in 1:nrow(dataset))
{
  ax[result2[i]]<-ax[result2[i]]+dataset[i,1]
  ay[result2[i]]<-ay[result2[i]]+dataset[i,2]
  an[result2[i]]<-an[result2[i]]+1
  
}


for(i in 1:5)
{ax[i]<-ax[i]/an[i]
 ay[i]<-ay[i]/an[i]}

SSEh<-0
for(i in 1:nrow(dataset))
{
  SSEh<-SSEh+ (ax[result2[i]]-dataset[i,1])^2+(ay[result2[i]]-dataset[i,2])^2
  
}

SSEh


mycol=c("red", "blue", "green","black", "magenta")
plot(x=dataset$x,y=dataset$y,col=mycol[result2],pch=20,xlim=c(-10,10),ylim=c(-10,10),xlab = "x-coordinate",ylab = "y-coordinate",main="hierarchical clustering " )
legend("bottomleft",legend=levels(factor(result2)),pch=20,col=mycol)
text(x=5,y=-5,labels=paste("Purity =",hpur))
text(x=5,y=-8.7,labels=paste("SSE =", SSEh))





##creating dbscan purity function
puritydb<-function(clust,w)
{
  n<-w
  resultq<-clust  
  ## confusion matrix
  t1<-table( resultq,dataset$label)
  colnames(t1)<-c("t1","t2","t3","t4","t5")
  each<-numeric(n+1)
  ##calculating purity
  for(i in 1:n+1)
  {
    for(j in 1:5)
    {
      if(each[i]<t1[i-1,j])
        each[i]=t1[i-1,j]
      
    }
  }  
  s1<-sum(each)
  total<-sum(cluster_size)
  purity<-s1/total
}


##density based clustering
library(fpc)
library(plyr)
result3<-fpc::dbscan(dataset[,1:2],eps = 1,MinPts = 8)
#plot(x=dataset$x,y=dataset$y,col=result3$cluster,xlab = "x-coordinate",ylab = "y-coordinate",main="dbscan")
a1<-count(result3$cluster)
n<-max(a1$x)
n
dpur<-puritydb(result3$cluster,n)
dpur
##density SSE
axd<-numeric(n+1)
ayd<-numeric(n+1)
and<-numeric(n+1)
for(i in 1:nrow(dataset))
{  axd[result3$cluster[i]+1]<-axd[result3$cluster[i]+1]+dataset[i,1]
  ayd[result3$cluster[i]+1]<-ayd[result3$cluster[i]+1]+dataset[i,2]
  and[result3$cluster[i]+1]<-and[result3$cluster[i]+1]+1
  
  }



for(i in 1:n+1)
{ axd[i]<-axd[i]/and[i]
  ayd[i]<-ayd[i]/and[i]
 }

SSEd<-0
for(i in 1:nrow(dataset))
{
  SSEd<-SSEd+ (axd[result3$cluster[i]+1]-dataset[i,1])^2+(ayd[result3$cluster[i]+1]-dataset[i,2])^2
  
}

SSEd

mycol=c("red", "blue", "green","black", "magenta","brown","white")
plot(x=dataset$x,y=dataset$y,col=mycol[result3$cluster],pch=20,xlim=c(-10,10),ylim=c(-10,10),xlab = "x-coordinate",ylab = "y-coordinate",main="density based " )
legend("bottomleft",legend=levels(factor(result3$cluster)),pch=20,col=mycol)
text(x=5,y=-5,labels=paste("Purity =",dpur))
text(x=5,y=-8.7,labels=paste("SSE =", SSEd))


