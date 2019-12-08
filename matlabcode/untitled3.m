clear
clc
close all

load('data.mat');

%--------------------------------BIC------------------------------------%
t1 = clock;

% Nm = size(T{1},1);Curve_num = size(T,2);
% for ii = 1:Curve_num
%     xdata(ii,:) = T{ii};
%     ydata(ii,:) = Y{ii};
% end
knots = createT1(31,3,-4,4);
% knots = linspace(-4,4,37);
index = 1:1000;
T_test = T(index,:);Y_test = Y(index,:);
m=size(T_test,1);
Nm = size(T_test,2);Curve_num = m;
iter_num=1;
% [Theta,PI]=fixedmove(T,Y);
component_iter=[];
relative_theta_accuracy = cell(1,iter_num);
Theta_iter=cell(1,iter_num);
A_iter = cell(1,iter_num);
rmse_iter = cell(1,iter_num);
for ii=6:50
    ii
    [Theta,PI,A,B,component_num]=fixedmove1(T_test,Y_test,knots);

%     [BIC,Theta,PI,A,B,component_num]=SMGPFRL1(T,Y,knots);
    % [Theta,PI,A,B,~,Jsp]=SMGPFRL1(T,Y,bsbasis);
    component_iter(ii) = component_num(end);
    Theta_iter{ii}=Theta;
    A_iter{ii}=A;
    B_iter{ii}=B;
    %
    
    %__________________calc clustering________________________________________%
    
    [~,cluster]=max(A,[],2);
    % figure;plot(cluster,'.')
    % Theta
    %_____________________prediction___________________________________________%
    load('data_test.mat');
    
    YP=mix_GPFRP_qz(Theta,PI,T1(index,:),Y1(index,:),T2(index,:),knots,B);
    
    rmse = zeros(Curve_num,1);
    parfor m = 1:Curve_num
        rmse(m) =  sqrt(mean((Y2(index(m),:)-YP{m}(:,1)').^2));
        
    end
    rmse_iter{ii}=rmse;
    
    RMSE(ii) = mean(rmse)
    component_iter
    % STD=0;
    % for ii = 1:curve_num
    %     STD = STD + sum(sqrt(YP{ii}(:,2)));
    % end
    % STD = STD/curve_num/50
    % RMSE = sqrt(rmse/curve_num/50)
    %  predict_show(T2,Y2,YP)
    %  figure;plot(cluster,'.');
    %___________cluster error_________________________________________%
    
end
t2 = clock;
time = etime(t2,t1)

