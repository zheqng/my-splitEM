
cov <- function(x,theta){
  (theta$v) *exp(-0.5*(theta$w)*( (outer(x,x,"-")^2)))+diag(length(x))*(theta$sigma2)
  
}



mix.posterio <- function(dat, theta, m,k) {
  result<-theta[[k]]$pi * dmvnorm(dat[[m]]$y,
                                  mean = rep(0, length(dat[[m]]$y)),
                                  sigma = cov(X=dat[[m]]$x, theta = theta[[k]]),
                                  log = FALSE
  )
  result
  
}

mean.function<-function(x,k){
  if(k==1){
    mu=0.5*sin((x-4)^2/8)+3
  }
  if(k==2){
    mu = -3/sqrt(2*pi)*exp(-(x-4)^2/8)+3.7
  }
  if(k==3){
    mu = -1/2*atan(x/2 -2) +3
  }
  if(k==4){
    mu = 0.5*cos(-(x-4)^2/8)+3
  }
  if(k==5){
    mu = -1/2*acos(x/4) +3
  }
  if(k==6){
    mu = -4*asin(x/4) +3
  }
  if(k==7){
    mu = 6*sin(-(x-4)^2/8)+3
  }
  if(k==8){
    mu=-32/sqrt(2*pi)*exp(-(x-4)^2/8)+10
    }
  if(k==9){
    mu = -1/sqrt(2*pi)*exp((x-4)^2/16)+11
  }
  if(k==10){
    mu = 6*cos(-(x-4)^2/8+pi/2)+3
  }
  mu
}

# plot(x,mean.function(x,1),'l',ylim=c(-5,10))
# 
# for(k in 2:9){
#   lines(x,mean.function(x,k))
# }
# points(x,mean.function(x,10))
