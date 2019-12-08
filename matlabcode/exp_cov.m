function cov=exp_cov(x,x_star,theta)
cov = theta(1)^2*exp( - theta(2)^2/2*dist(x',x_star).^2);
end