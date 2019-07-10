function [negative_loglik,grad]=MLE(theta,D,Y)    
%��GP��������Ȼ
% Dis=dist(T').^2;
Y = Y';
n=size(D,1);
a=theta(1)^2;% v
b=theta(2)^2;%w
c=theta(3)^2;%sigma2
Exp=exp(-1/2*b*D);
C=a*Exp+c*eye(n);

L=chol(C)';
K=L\Y;
A=L'\(L\Y);
% A = C\Y;
% [L,U] = lu(C);
negative_loglik=(K'*K)+2*trace(log(abs(L)))+n*log(2*pi);   %-2loglik
% negative_loglik = Y'*A + sum(log(abs(diag(L))));

% coef = A*A' - inv(C);
% grad1 = 2*theta(1)*Exp;
% grad1 = trace(coef*grad1)/2;
% grad3 = trace(coef)*theta(3);
% grad2 = -theta(2)*theta(1)^2*Dis.*Exp;
% grad2 = trace(coef*grad2)/2;
% 
grad=zeros(3,1);
coef=A*A'-L'\(L\eye(n));
pd1=2*theta(1)*Exp;
pd2=-theta(2)*a*D.*Exp;
grad(1)=trace(coef*pd1);
grad(2)=trace(coef*pd2);
grad(3)=trace(coef)*2*theta(3);

grad = -grad;
% grad=-[grad1;grad2;grad3];% gradient of -2loglik
