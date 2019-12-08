function [Theta,PI,A,B]=GPFRL(T,Y,bsbasis)
kmax=9;
kk=3;
% initialization
m=size(T,1);
% N=0;
% for i=1:m
%     N=N+length(T{i});
% end
phi=cell(1,m);
% dim=size(phi{1},2);
%xdata  1*Nm
%ydata Curve_num*Nm
%B K (nbasis*Curve_num)
%phi curve_num(Nm*nbaisi)
%coef Ahat K (nbasis*Curve_num)
%zmat Curve_num*K
% xdata = [];
Nm = size(T,2);Curve_num = m;
% for ii = 1:Curve_num
%     xdata(ii,:) = T{ii};
%     ydata(ii,:) = Y{ii};
% end
% L = min(min(xdata));
% H = max(max(xdata));
A = ones(Curve_num,kk)/kk;
% bsbasis = create_bspline_basis([L-0.5,H+0.5], 10,2);
% zmat = ones(m,kk)/kk;
% B = calc_B(T,Y,bsbasis,zmat);
% % % % % % % % % % % % % r
% plot_B(B,T,Y,A,bsbasis)

% % % % % % % % % % % % % % r
for ii = 1:Curve_num
    D{ii}=dist(T(ii,:)).^2;
    for jj = 1:Nm
    phi{ii}(jj,:) = bbase(T(ii,jj),bsbasis,2);
    end
%phi{ii} = getbasismatrix(xdata(ii,:),bsbasis);
end
[Theta,PI]=Theta_PI_init(kk);
%  B=bspline_update(T,Y,Theta,A,umat,phi);
%  Theta=Theta_update(T,Y,Theta,A,B,phi);
%  A=posterior_update(T,Y,Theta,PI,B,phi);



% T,Y,Theta,PI,B,phi,zmat,hardcut_flag
[Theta,PI,A,B]=EM(D,Y,Theta,PI,phi,A,0);

          [~,cluster]=max(A,[],2);
         subplot(1,3,kk)
         plot_curve(T,Y,cluster);
end