clear all;
clc;
delete data.mat
aaa = readtable('../demo/traindata.dat');
data = table2array(aaa(:,1:50));
curve_num=1200;
T=data((1:curve_num)*2-1,:);
Y = data((1:curve_num)*2,:);

save data.mat
clear all;
clc;
delete data_test.mat
curve_num=1200;
aaa = readtable('../demo/traindata.dat');
data = table2array(aaa(:,1:50));
T1 = data((1:curve_num)*2-1,:);
Y1 = data((1:curve_num)*2,:);
aaa = readtable('../demo/testdata.dat');
data = table2array(aaa(:,1:50));
T2=data((1:curve_num)*2-1,:);
Y2 = data((1:curve_num)*2,:);
save data_test.mat