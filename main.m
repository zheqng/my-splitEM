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
load data.mat
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
% %     [~,index] = sort(T{ii});
% %     T1{ii} = T{ii}(index);
% %     Y1{ii} = Y{ii}(index);
%     xdata(ii,:) = T{ii};
%     ydata(ii,:) = Y{ii};
% end
% L = min(min(xdata));
% H = max(max(xdata));
% A = ones(Curve_num,1);
% eps = (H-L)/Nm/2;
% bsbasis = create_bspline_basis([L-eps,H+eps], 22,3);
bsbasis = createT1(30,2,0,9);

[Theta,PI,A,B,~,Jsp]=SMGPFRL1(xdata,ydata,bsbasis);

  load data_test.mat
      YV=mix_GPFRP_qz(Theta,PI,T1_test,Y1_test,T2_test,bsbasis,B);
      
      rmse = 0;
parfor i = 1:600
rmse = rmse + sum((Y2_test{i}-YV{i}(:,1)).^2);

end

RMSE = sqrt(rmse/600/110)
 predict_show(T2_test,Y2_test,YV)
% YV=mix_GPFRP_qz_real(TV,PI,T1_test,Y1_test,T2_test);
%    rmse = 0;
% for i = 1:600
% rmse = rmse + sum((Y2_test{i}-YV{i}(:,1)).^2);
% 
% end
% 
% sqrt(rmse/600/110)
% predict_show(T2_test,Y2_test,YV)
% 
t2 = clock;
time = etime(t2,t1)
