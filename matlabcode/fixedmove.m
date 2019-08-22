function [Theta,PI,A,B,component_num]= fixedmove(T,Y,knots)
kmax=30;
kk=10;
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
[Theta,PI]=Theta_PI_init(kk);
A=posterior_update(D,Y,Theta,PI);
[Theta,PI,A,B]=EM(D,Y,Theta,PI,A,phi);
component_num = size(Theta,1);
