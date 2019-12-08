clear
clc
close all

load('data.mat');

%--------------------------------BIC------------------------------------%
% t1 = clock;

% Nm = size(T{1},1);Curve_num = size(T,2);
% for ii = 1:Curve_num
%     xdata(ii,:) = T{ii};
%     ydata(ii,:) = Y{ii};
% end
knots = createT1(31,3,-4,4);
% knots = linspace(-4,4,37);
m=size(T,1);
Nm = size(T,2);Curve_num = m;
[BIC,Theta,PI,A,B,component_num]=SMGPFRL1(T,Y,knots);


%__________________calc clustering________________________________________%

[~,cluster]=max(A,[],2);
% figure;plot(cluster,'.')
% Theta
%_____________________prediction___________________________________________%
load('data_test.mat');

YP=mix_GPFRP_qz(Theta,PI,T1,Y1,T2,knots,B);



    
    
