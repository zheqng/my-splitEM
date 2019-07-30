clear
clc
close all
% load SimuData3
% load electrical_load_wudi
%load ../simu_meanfunc300.mat
% delete data.mat
% delete paper.mat
% delete data_test.mat
% delete paper_test.mat
% generatepapercurve
delete data.mat
load('../function simulation/data.mat');
%addpath('../makedata/')
%delete data_test.mat
%delete paper_test.mat
% addpath('~/src/2016-06-06/gpfrcodes_unix/fda');
% load weather
% load simu
%--------------------------------BIC------------------------------------%
t1 = clock;

% Nm = size(T{1},1);Curve_num = size(T,2);
% for ii = 1:Curve_num
%     xdata(ii,:) = T{ii};
%     ydata(ii,:) = Y{ii};
% end
% L = min(min(xdata));
% H = max(max(xdata));
% A = ones(Curve_num,1);
% eps = (H-L)/Nm/2;
% bsbasis = create_bspline_basis([L-eps,H+eps], 22,3);
% bsbasis = createT1(30,3,0,9);

% [Theta,PI]=fixedmove(T,Y);

[BIC,Theta,PI,A,component_num]=SMGPFRL1(T,Y);

 
% 
t2 = clock;
time = etime(t2,t1)
%__________________calc clustering________________________________________%
m=size(T,1);
Nm = size(T,2);Curve_num = m;

% % % % % % % % % % % % % % r
for ii = 1:Curve_num
    D{ii}=dist(T(ii,:)).^2;
end
A=posterior_update(D,Y,Theta,PI);
[~,cluster]=max(A,[],2);
Theta
%_____________________prediction___________________________________________%
load('../function simulation/data_test.mat');

 YP=mix_GPFRP_qz(Theta,PI,T1,Y1,T2);
      
      rmse = zeros(curve_num,1);
parfor ii = 1:curve_num
rmse(ii) =  sqrt(mean((Y2(ii,:)-YP{ii}(:,1)').^2));

end
for k=1:10
    index_k = ((k-1)*100+1) : (k*100);
   rmse_k(k)= mean(rmse(index_k));
end

rmse_k

RMSE = mean(rmse(1:1000))
% RMSE = sqrt(rmse/curve_num/50)
 predict_show(T2,Y2,YP)
% cluster_true = [repmat(1,1,108) repmat(2,1,103) repmat(3,1,89)]';