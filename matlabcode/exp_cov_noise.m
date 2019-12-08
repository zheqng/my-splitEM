function cov = exp_cov_noise(x,theta)
n = length(x);
cov = theta(1)^2*exp( - theta(2)^2/2*dist(x).^2) + eye(n)*theta(3)^2;


