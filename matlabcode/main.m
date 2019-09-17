clear
clc
close all

load('data.mat');
%--------------------------------BIC------------------------------------%
t1 = clock;
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
RMSE_K = cell(1,iter_num);
for ii=2:iter_num
    ii
 [BIC,Theta,PI,A,component_num]=SMGPFRL1(T,Y);
% [Theta,PI,A,component_num]=fixedmove(T,Y);
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
YP=mix_GPFRP_qz(Theta,PI,T1,Y1,T2);
rmse = zeros(curve_num,1);
parfor m = 1:curve_num
    rmse(m) =  sqrt(mean((Y2(m,:)-YP{m}(:,1)').^2));

end

for k=1:10
    index_k = ((k-1)*step+1) : (k*step);
   rmse_k(k)= mean(rmse(index_k));
end

RMSE_K{ii} = rmse_k;
% rmse_k

RMSE(ii) = mean(rmse);
%___________cluster error_________________________________________%
if(component_num(end)==K)
    for k= 1:K
        index_k = ((k-1)*step+1) : (k*step);
        index_sort(k) = mode(cluster(index_k));
    end
    aaa=repmat(index_sort,step,1);
    true_cluster = aaa(:);
    error_cluster(ii) =sum(true_cluster~=cluster)/curve_num;
%     %__________________________rmse________________________________%
%     rmse_k = rmse_k(index_sort);
%     RMSE_K{ii} = rmse_k;
    %______________Theta accuracy___________________________________%
    Theta_sort =abs( Theta(index_sort,:));
    aaa = readtable('../function simulation/theta.txt');
    Theta_true = table2array(aaa);
    relative_theta_accuracy{ii}=abs((Theta_true(1:K,:) - Theta_sort)./Theta_true(1:K,:))*100;
end
pause(1)
end
t2 = clock;
time = etime(t2,t1)
%__________________save data ________________________________________%
delete(['iter50_result',num2str(step),'.mat'])
save(['iter50_result',num2str(step),'.mat'])

average_theta_accuracy = zeros(10,3);
for ii = 1:iter_num
    if(component_iter(ii) == 10)
    average_theta_accuracy = average_theta_accuracy +   relative_theta_accuracy{ii};
    end
end
average_theta_accuracy = average_theta_accuracy/sum(component_iter==K);


%________________________valide data_________________________________%
Theta_sort = zeros(K,3);
for ii=1:iter_num
    %__________________calc clustering________________________________________%
 

    [~,cluster]=max(A_iter{ii},[],2);
    %___________cluster error_________________________________________%
    if(component_iter(ii)==K)
        for k= 1:K
            index_k = ((k-1)*step+1) : (k*step);
            index_sort(k) = mode(cluster(index_k));
        end
        %______________Theta accuracy___________________________________%
        Theta_sort = Theta_sort + Theta_iter{ii}(index_sort,:);
    end
end
Theta_sort = Theta_sort/sum(component_iter==K);
% B_sort = B_sort/iter_num;
M_test=600;
load('data_valide.mat');
for ii = 1:M_test
    D_valide{ii}=dist(T_valide(ii,:)).^2;
end
A=zeros(M_test,K);

% for m = 1:M_test
A=posterior_update(D_valide,Y_valide,Theta_sort,repmat(0.1,1,10));
%     for k = 1:K
%         Mle(k) = -0.5*MLE(Theta_sort(k,:),dist(T_valide(m,:)).^2,Y_valide(m,:));
%     end
%     [~,index]=max(Mle);
   [~, cluster_valide]=max(A,[],2);

figure;plot(1:600,cluster_valide,'.')
set(gca,'xtick',1:60:600);
set(gca,'XTicklabel',{'0','60','120','180','240','300','360','420','480','540','600'})
order = [10 8 1 9 7 6 5 2 4 3];
cluster_valide_true = repmat(order,60,1);
cluster_valide_true = cluster_valide_true(:)';
sum(cluster_valide~=cluster_valide_true)/M_test*100
