function [Theta,PI,A]=EM(D,Y,Theta,PI,A,hardcut_flag)


% if nargin<8
%     hardcut_flag=false;
% end

m=size(Y,1);
iter=0;
delta=1;
eps=1e-6;
max_iter=25;
% umat = ones(m,1);
% E-step first
while  iter==0 ||( iter<max_iter&&M11>10^(-3)  )
    iter=iter+1;
   A2 = A;
    % update PI,Theta and B
    PI=sum(A,1)/m;
    if hardcut_flag
        A=hard_cut(A);
    end
%     if ~isempty(phi)
%         B=bspline_update(D,Y,Theta,A,umat,phi);
      %   compare_meanfunction(bsbasis,B)
%         plot_B(B,T,Y,A)
        Theta=Theta_update(D,Y,Theta,A);
        A=posterior_update(D,Y,Theta,PI);
               M11=mean(mean(abs(A2-A)))

       % LL(iter)=LogLik(T,Y,Theta,PI,A,B,phi);
%     else
%         Theta=Theta_update(D,Y,Theta,A);
%          A=posterior_update(D,Y,Theta,PI);
        %LL(iter)=LogLik(T,Y,Theta,PI,A);
    end
     % update posterior
%     if ~isempty(phi)
%         
%     else
%        
%     end
    
    %if iter>1
        %delta=abs(LL(iter)-LL(iter-1));
    %end
end
% figure
% plot(LL)
% xlabel('iteration');
% ylabel('log-likelihood');
