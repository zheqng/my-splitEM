clear all;
clc;
delete data.mat
aaa = readtable('../demo/traindata.dat');
data = table2array(aaa(:,1:50));
curve_num=size(data,1)/2;
T=data((1:curve_num)*2-1,:);
Y = data((1:curve_num)*2,:);

save data.mat
clear all;
clc;
delete data_test.mat
aaa = readtable('../demo/traindata.dat');
data = table2array(aaa(:,1:50));
curve_num=size(data,1)/2;
T1 = data((1:curve_num)*2-1,:);
Y1 = data((1:curve_num)*2,:);
aaa = readtable('../demo/testdata.dat');
data = table2array(aaa(:,1:50));
T2=data((1:curve_num)*2-1,:);
Y2 = data((1:curve_num)*2,:);
save data_test.mat


clear all;
clc;
delete data_valide.mat
aaa = readtable('../demo/validedata.dat');
data = table2array(aaa(:,1:50));
curve_num=size(data,1)/2;
T_valide = data((1:curve_num)*2-1,:);
Y_valide = data((1:curve_num)*2,:);
save data_valide.mat