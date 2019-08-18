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
m=size(T,1);
Nm = size(T,2);Curve_num = m;
step = 100;
iter_num=50;
% [Theta,PI]=fixedmove(T,Y);
component_iter=[];
relative_theta_accuracy = cell(1,iter_num);
Theta_iter=cell(1,iter_num);
K=10;
A_iter = cell(1,iter_num);
for ii=1:iter_num
    ii
    [BIC,Theta,PI,A,B,component_num]=SMGPFRL1(T,Y,knots);
    % [Theta,PI,A,B,~,Jsp]=SMGPFRL1(T,Y,bsbasis);
    component_iter(ii) = component_num(end);
    Theta_iter{ii}=Theta;
    A_iter{ii}=A;
    %
    
    %__________________calc clustering________________________________________%
    
    [~,cluster]=max(A,[],2);
    % figure;plot(cluster,'.')
    % Theta
    %_____________________prediction___________________________________________%
    load('data_test.mat');
    
    YP=mix_GPFRP_qz(Theta,PI,T1,Y1,T2,knots,B);
    
    rmse = zeros(curve_num,1);
    parfor m = 1:curve_num
        rmse(m) =  sqrt(mean((Y2(m,:)-YP{m}(:,1)').^2));
        
    end
    
    
    RMSE(ii) = mean(rmse);
    
    % STD=0;
    % for ii = 1:curve_num
    %     STD = STD + sum(sqrt(YP{ii}(:,2)));
    % end
    % STD = STD/curve_num/50
    % RMSE = sqrt(rmse/curve_num/50)
    %  predict_show(T2,Y2,YP)
    %  figure;plot(cluster,'.');
    %___________cluster error_________________________________________%
    if(component_num(end)==K)
        for k= 1:K
            index_k = ((k-1)*step+1) : (k*step);
            index_sort(k) = mode(cluster(index_k));
        end
        aaa=repmat(index_sort,step,1);
        true_cluster = aaa(:);
        error_cluster(ii) =sum(true_cluster~=cluster)/curve_num;
        %______________Theta accuracy___________________________________%
        Theta_sort =abs( Theta(index_sort,:));
        aaa = readtable('../function simulation/theta.txt');
        Theta_true = table2array(aaa);
        relative_theta_accuracy{ii}=abs((Theta_true(1:K,:) - Theta_sort)./Theta_true(1:K,:))*100;
    end
end
t2 = clock;
time = etime(t2,t1)
%__________________save data ________________________________________%
delete *.mat
save(['iter50_result',num2str(step),'.mat'])

average_theta_accuracy = zeros(10,3);
for ii = 1:50
    if(component_iter(ii) == 10)
    average_theta_accuracy = average_theta_accuracy +   relative_theta_accuracy{ii};
    end
end
average_theta_accuracy = average_theta_accuracy/48;
% cluster_true = [repmat(1,1,108) repmat(2,1,103) repmat(3,1,89)]';