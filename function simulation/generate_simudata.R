rm(list = ls())
library('MCMCpack')
# setwd('/home/zheqng/function simulat')
setwd('/home/zheqng/src/my-RJMCMC-matlab/split-GPFR/function simulation/')
these = read.table(file='/home/zheqng/src/my-RJMCMC-matlab/split-GPFR/function simulation/theta.txt')
# setwd('/media/zheqng/Seagate Backup Plus Drive/zheqng@nwu/src/RJMCMC-my-C/simu1/2019.2.10/function simulation/')
library("MASS")

source('basicfunc.r')
source('plot.mix.r')





K=10
theta = vector("list",K)
# for(k in 1:100){
PI  = rep(1/K,1,K);
for(k in 1:K){
  theta[[k]]$v=these[k,1]^2
  theta[[k]]$w=these[k,2]^2
  theta[[k]]$sigma2=these[k,3]^2
  theta[[k]]$pi = PI[k]
  
}
# label = rmultinom(n=1,size=M,prob=PI)
step = 100
z=NULL
for(k in 1:K)z =c(z, rep(k,step))

M = K*step

dat =vector( "list", M)
x=seq(from=-4,to=4,length.out = 100)
for(i in 1:M)
  dat[[i]]$x = x;
dat$M=M


# curves.left=seq(1,M,by=1)
# z=rep(0,1,M)
# for(k in 1:K){
#   curves.choose=sample(curves.left,label[k])
#   z[curves.choose]=k
#   curves.left = curves.left[-pmatch(curves.choose,curves.left)]
# }


for(m in 1:M)
{
  k=z[m]
  dat[[m]]$y = mvrnorm(n=1,mu=mean.function(x,k),
                       Sigma = cov(x,theta[[k]]))
  dat[[m]]$k=k;
  dat[[m]]$x = (dat[[m]]$x)
  # /8*0.01
}
save.image("simudata.RData")
# load("simudata.RData")
plot.mixgaussian(dat,step=step,K=K)
plot.mixgaussian(dat,step=step,K=K,make.pdf=TRUE)
# write to file

stepsize = length(x)
tsize = stepsize/2
unlink('../demo/traindata.dat')
unlink('../demo/testdata.dat')
# for(k in 1:3)
for(m in 1:M)
{
  xtoltrain = 1:stepsize
  xindtrain = sample(1:stepsize,size = tsize,replace = FALSE)
  xindtrain = sort(xindtrain)
  xresttrain = xtoltrain[-xindtrain]
  sink('../demo/traindata.dat',append = TRUE)
  cat(dat[[m]]$x[xindtrain],"\n")
  cat(round(dat[[m]]$y[xindtrain],digits=4),"\n")
  sink()
  sink('../demo/testdata.dat',append = TRUE)
  cat(dat[[m]]$x[xresttrain],"\n")
  cat(round(dat[[m]]$y[xresttrain],digits=4),"\n")
  sink()
}
# sink()
##########################################################################
M.test = 600
step.test = 60
z=NULL
for(k in 1:K)z =c(z, rep(k,step.test))
dat.test =vector( "list", M.test)
for(i in 1:M.test)
  dat.test[[i]]$x = x;
dat.test$M=M
for(m in 1:M.test)
{
  k=z[m]
  dat.test[[m]]$y = mvrnorm(n=1,mu=mean.function(x,k),
                            Sigma = cov(x,theta[[k]]))
  dat.test[[m]]$k=k;
  dat.test[[m]]$x = (dat.test[[m]]$x)
  # /8*0.01
}
unlink('../demo/validedata.dat')
# for(k in 1:3)
sink('../demo/validedata.dat',append = TRUE)
for(m in 1:M.test)
{
  cat(dat.test[[m]]$x,"\n")
  cat(round(dat.test[[m]]$y,digits=4),"\n")
}
sink()
save.image("simudata.RData")
# load("simudata.RData")
# plot.mixgaussian(dat,step=2)
# plot.mixgaussian(dat,step=2,make.pdf=TRUE)
# 
# for(i in 1:19) cat(i,'th',these[[i]],'\n')
#############################################################################
source('predict.R')
theta$K = K
bbb = print.posterior(dat,theta)
aaa=bbb
for(m in 1:M){
  tmp = max(aaa[m,])
  aaa[m,] = aaa[m,] - tmp
  aaa[m,]=aaa[m,]- log(sum(exp(aaa[m,])))
}
  

aaa = exp(aaa)
index = apply(aaa,1, which.max)
plot(index)
value = apply(aaa,1, max)
plot(value)
