function [Theta,PI,A,MU]=EM(D,Y,Theta,PI,A,hardcut_flag)


if nargin<6
    hardcut_flag=false;
end

m=size(Y,1);
iter=0;
delta=1;
eps=1e-6;
max_iter=25;
umat = ones(m,1);
% E-step first
while  iter==0 ||( iter<max_iter&&M11>10^(-3)  )
    iter=iter+1;
    Aold = A;
    % update PI,Theta and B
    PI=sum(A,1)/m;
%     if hardcut_flag
%         A=hard_cut(A);
%     end
%     if ~isempty(MU)
     MU=meanfunc_update(D,Y,Theta,A);
      %   compare_meanfunction(bsbasis,B)
%         plot_B(B,T,Y,A)
     Theta=Theta_update(D,Y,Theta,PI,A,MU);
     A=posterior_update(D,Y,Theta,PI,MU);
     M11=mean(mean(abs(Aold-A)))
    %end
end
% figure
% plot(LL)
% xlabel('iteration');
% ylabel('log-likelihood');
