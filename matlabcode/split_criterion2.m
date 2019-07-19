function [ratio,final,Theta_new,PI_new]=split_criterion2(D,MY,Theta,PI,d,b)
kk=size(Theta,1);

A=posterior_update(D,MY,Theta,PI);
loglik_old=LogLik(D,MY,Theta,PI,A);
[~,cluster] = max(A,[],2);
% loglik=zeros(1,kk);
% for k=1:kk
%     index=find(cluster==k);
%     for ii=1:length(index)
%         m=index(ii);
%         loglik(k) = loglik(k)+log(PI(k))-0.5*MLE(Theta(k,:),D{m},MY(m,:));
%     end
%     loglik(k) = loglik(k);
% end
% 
% [~,k] = min(loglik);
% k
% u=betarnd(2,2,1,4);
% [ratio,PI_new,Theta_new] =calc_Accept_ratio(u,Theta,PI,d,b,loglik_old,D,MY,k,kk);
% index=k;
ratio=0.0;
iter=1;
while ratio<1e-5 && iter<100
    k=unidrnd(kk,1);
%     index=[index k]; index = unique(index);
    u=betarnd(2,2,1,4);
    [ratio,PI_new,Theta_new] =calc_Accept_ratio(u,Theta,PI,d,b,loglik_old,D,MY,k,kk);
    iter=iter+1;
end
if iter>=100 && ratio<1e-5
    final = true;
else
    final = false;
end
end