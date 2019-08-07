function [Theta,PI]= fixedmove(T,Y)
kmax=30;
kk=8;
% initialization
m=size(T,1);
Nm = size(T,2);Curve_num = m;

% % % % % % % % % % % % % % r
for ii = 1:Curve_num
    D{ii}=dist(T(ii,:)).^2;
end
[Theta,PI]=Theta_PI_init(kk);
A=posterior_update(D,Y,Theta,PI);
[Theta,PI,A]=EM(D,Y,Theta,PI,A,0);
