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
% bsbasis = createT1(30,3,0,9);

[BIC,Theta,PI,A,Jsp]=SMGPFRL1(T,Y);

 
% 
t2 = clock;
time = etime(t2,t1)

[~,cluster]=max(A,[],2);
% cluster_true = [repmat(1,1,108) repmat(2,1,103) repmat(3,1,89)]';