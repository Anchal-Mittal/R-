
#generate  random datasets using exponential  distribution
rho=0.3
m1=1
m2=2
s1=0.3
s2=0.5
m=c(m1,m2)
sigma=matrix(c(s1^2,s1*s2*rho,s1*s2*rho,s2^2),2)
ndist=mvrnorm(n=100,mu=m,Sigma=sigma)
edist=cbind(qexp(pnorm(ndist)),2)
