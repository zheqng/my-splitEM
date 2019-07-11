% clear all;clc
 function maketestdata
addpath('~/src/2016-06-06/gpfrcodes_unix/fda/');
addpath('~/src/2016-06-06/gpfrcodes_unix/gpfr/');


% close('all'); clear('all');
%load trainig data
load paper_test.mat
stepsize = N;               % training data size
tdsize = fix(stepsize/2);   % choose half data for training

Curve_num = size(T_test,2);


%____________write into the traindata.dat & testdata.dat____________%
for m=1:Curve_num
        [xindtrain,xresttrain] = srswor(stepsize,40);
    %________________traindata{i}_______________%
    T1_test{m} = T_test{m}(xindtrain,:);
    Y1_test{m} = Y_test{m}(xindtrain,:);    
     %____________trainrestdata{i}______________%
     T2_test{m} = T_test{m}(xresttrain,:);
     Y2_test{m} = Y_test{m}(xresttrain,:);
end

 save data_test.mat
