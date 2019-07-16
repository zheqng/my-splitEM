clear all;
clc;
aaa = readtable('../demo/traindata.dat');
data = table2array(aaa(:,1:50));
T=data((1:14)*2-1,:);
Y = data((1:14)*2,:);

save data.mat
clear all;
clc;
aaa = readtable('/home/zheqng/src/my-RJMCMC-matlab/large K/demo/testdata.dat');
data = table2array(aaa(:,1:50));
T=data((1:40)*2-1,:);
Y = data((1:40)*2,:);