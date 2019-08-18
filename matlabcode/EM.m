function [Theta,PI,A,B]=EM(D,Y,Theta,PI,A,phi)


% if nargin<8
%     hardcut_flag=false;
% end

m=size(Y,1);
iter=0;
eps=1e-6;
max_iter=25;


% A=posterior_update(D,Y,Theta,PI,B,phi);
umat = ones(m,1);
% E-step first
while  iter==0 ||( iter<max_iter&&M11>10^(-3)  )
    iter=iter+1;
    A_old = A;
    % update PI,Theta and B
    PI=sum(A,1)/m;
    if ~isempty(phi)
        B=bspline_update(D,Y,Theta,A,umat,phi);
        %maximum step
        Theta=Theta_update(D,Y,Theta,PI,A,B,phi);
        %expectation step
        A=posterior_update(D,Y,Theta,PI,B,phi);
    else
        %maximum step
        Theta=Theta_update(D,Y,Theta,PI,A);
        %expectation step
        A=posterior_update(D,Y,Theta,PI);
    end
    M11=mean(mean(abs(A_old-A)));
end

end
