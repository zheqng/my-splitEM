function [Theta,PI]=Theta_PI_init(kk)
Theta=zeros(kk,3);
Theta(:,2)=1./gamrnd(1/2,2,kk,1);%w
Theta(:,1)=lognrnd(-1,1,kk,1);%v
Theta(:,3)=lognrnd(-3,3,kk,1);%sigma
Theta=sqrt(Theta);
PI=dirrnd(ones(1,kk));
