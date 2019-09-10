function [ratio,PI,Theta,loglik_new,add_logratio] =calc_Accept_ratio(u,Theta,PI,d,b,loglik_old,D,Y,k,kk)

pi1=u(1)*PI(k);
pi2=(1-u(1))*PI(k);
pi_star = PI(k);

sigma_star = Theta(k,3)^2;
sigma1=u(2)*Theta(k,3)^2/u(1);
sigma2=(1-u(2))*Theta(k,3)^2/(1-u(1));

v_star = Theta(k,1)^2;
v1=u(3)*Theta(k,1)^2/u(1);
v2=(1-u(3))*Theta(k,1)^2/(1-u(1));

w_star = Theta(k,2)^2;
w1=(1-u(4))/u(3)*Theta(k,2)^2;
w2=u(4)/(1-u(3))*Theta(k,2)^2;

%         PI_iter{iter}=PI;
%         Theta_iter{iter}=Theta;
PI(k)=[];
Theta(k,:)=[];
PI=[ PI,[pi1,pi2]];
Theta=[ Theta;sqrt([v1,w1,sigma1;v2,w2,sigma2])];


%       A=posterior_update(D,Y,Theta,PI);
loglik_new=LogLik(D,Y, Theta,PI);
% % % % % % % % % % % % % % % %             fixed moves
prop_ratio = d(kk+1)/b(kk);
%    _________________pi_______________________________%
add_logratio = log(kk) - log(6) - log(u(1)*(1-u(1))) + log(pi_star);
%    __________________sigmav2_________________________%
add_logratio = add_logratio - log(3.0) - 0.5*log(2*pi) +...
    log(sigma_star/sigma1/sigma2)...
    -(log(sigma1)+3)^2/18 - (log(sigma2)+3)^2/18+...
    (log(sigma_star)+3)^2/18 - log(u(2)*(1-u(2)))...
    +log(sigma_star) + 2*log(pi_star) - log(pi1*pi2);
%   __________________v__________________________%
add_logratio = add_logratio - 0.5*log(2*pi)+log(v_star/v1/v2)...
    -(log(v1)+1)^2/2 - (log(v2)+1)^2/2 +(log(v_star)+1)^2/2+...
    -log(6) - log(u(3)*(1-u(3)))...
    +log(v_star) + 2*log(pi_star) -log(pi1*pi2);
%  ______________w__________________________________%
add_logratio = add_logratio +0.5*log(0.5) - 1.5*log(w1*w2/w_star)...
    -0.5*(1/w1+1/w2-1/w_star)...
    -log(6.0) - log(u(4)*(1-u(4)))...
    +log(w_star) - log( u(3)*(1-u(3)));
%             [LogLik,LL(end)];
% [loglik_new loglik_old add_logratio]
M = size(Y,1);
ratio = exp((loglik_new-loglik_old) -0.5*4*log(50)+ add_logratio);
ratio = ratio*prop_ratio;
if ratio>1
    ratio=1;
end
