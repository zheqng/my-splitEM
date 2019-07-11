% clear all;clc
 function makedata
addpath('~/src/2016-06-06/gpfrcodes_unix/fda');
addpath('~/src/2016-06-06/gpfrcodes_unix/gpfr');

% close('all'); clear('all');
%load trainig data
%stepsize = N;               % training data size
Curve_num=600;Nm = 150;
[T_test,Y_test,MET_test,ma1_test]=cmixGPFR_WuDi(Curve_num,Nm);
stepsize = Nm;               % training data size
tdsize = 40;   % choose half data for training

%Curve_num = size(T,2);


%____________write into the traindata.dat & testdata.dat____________%
for m=1:Curve_num
        [xindtrain,xresttrain] = srswor(stepsize,tdsize);
    %________________traindata{i}_______________%
    T1_test{m} = T_test{m}(xindtrain,:);
    Y1_test{m} = Y_test{m}(xindtrain,:);    
     %____________trainrestdata{i}______________%
     T2_test{m} = T_test{m}(xresttrain,:);
     Y2_test{m} = Y_test{m}(xresttrain,:);
end

 save data_test.mat
