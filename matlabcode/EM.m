function [Theta,PI,A]=EM(D,Y,Theta,PI,hardcut_flag)


% if nargin<8
%     hardcut_flag=false;
% end

m=size(Y,1);
iter=0;
eps=1e-6;
max_iter=25;


A=posterior_update(D,Y,Theta,PI);
% umat = ones(m,1);
% E-step first
while  iter==0 ||( iter<max_iter&&M11>10^(-3)  )
    iter=iter+1;
    A2 = A;
    % update PI,Theta and B
    PI=sum(A,1)/m;
    %maximum step
    Theta=Theta_update(D,Y,Theta,PI,A);
    %expectation step
    A=posterior_update(D,Y,Theta,PI);
    M11=mean(mean(abs(A2-A)));
end

end

