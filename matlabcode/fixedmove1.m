function [Theta,PI,A,B,component_num]= fixedmove1(T,Y,knots)
kmax=30;
% kk=10;
% initialization
m=size(T,1);
Nm = size(T,2);Curve_num = m;
phi=cell(1,m);

% % % % % % % % % % % % % % r
for ii = 1:Curve_num
    D{ii}=dist(T(ii,:)).^2;
    for jj = 0:(numel(knots)-4-1)
        phi{ii}(:,jj+1) = bspline_basis(jj,4,knots,T(ii,:));
    end
    %     for jj = 1:Nm
    %         phi{ii}(jj,:) = bbase(T(ii,jj),bsbasis,2);
    %     end
end
final = false;
kk=1;
BIC=[];
L = [];
component_num=[];
% while final==false
for kk=1:20
    [Theta_new,PI_new]=Theta_PI_init(kk);
    A_new=posterior_update(D,Y,Theta_new,PI_new);
    [Theta_new,PI_new,A_new,B_new]=EM(D,Y,Theta_new,PI_new,A_new,phi);
    %  kk=length(PI_new)
    loglik=LogLik(D,Y,Theta_new,PI_new,B_new,phi);
    L = [L loglik];
    BIC = [BIC -2*loglik+(4+numel(knots)-4)*kk*log(Nm)];
    %     if BIC(end)>BIC(end-1)
    %              final = true;
    
    %         else
    %             final = false;
    component_num = [component_num kk];
    %______________update parameters________________________%
    Theta_iter{kk}=Theta_new;
    PI_iter{kk}=PI_new;
    B_iter{kk} = B_new;
    A_iter{kk} = A_new;
%     kk=kk+1    
end
% component_num = size(Theta,1);
% figure;plot(L)
[~,component_num]=min(BIC);
Theta = Theta_iter{component_num};
PI = PI_iter{component_num};
B = B_iter{component_num};
A = A_iter{component_num};
end
