function [ratio,final,Theta_new,PI_new]=split_criterion2(D,MY,Theta,PI,d,b)
kk=size(Theta,1);

A=posterior_update(D,MY,Theta,PI);
loglik_old=LogLik(D,MY,Theta,PI,A);
[~,cluster] = max(A,[],2);
ratio=0.0;
iter_worker=1;
ratio_worker=0.0;
spmd
    while ratio_worker<1e-4 && iter_worker<200
        k=unidrnd(kk,1);
        u=betarnd(2,2,1,4);
        [ratio_worker,PI_worker,Theta_worker] =calc_Accept_ratio(u,Theta,PI,d,b,loglik_old,D,MY,k,kk);
        iter_worker=iter_worker+1;
    end
end


for worker = 1:4
    if ratio<ratio_worker{worker}
        ratio = ratio_worker{worker};
        PI_new = PI_worker{worker};
        Theta_new = Theta_worker{worker};
        iter = iter_worker{worker};
    end
end
iter

if iter>=200
    final = true;
%     Theta_new = Theta;
%     PI_new = PI;
else
    final = false;
end
iter
end

% for k = 1:kk
% options = optimoptions('fmincon','Display','iter','Algorithm','sqp');
% [x,ratio_k(k)] = fmincon(@(u)Accept_ratio(u,PI,Theta,d,b,loglik_old,D,MY,k,kk),betarnd(2,2,1,4),[],[],[],[],[0 0 0 0],[1 1 1 1],[],options);
% u_tmp(k,:) = x;
% end
% [~,k] = min(ratio_k);
% ratio_k
% % ratio = -ratio_k(k);
% [ratio,PI_new,Theta_new] =calc_Accept_ratio(u_tmp(k,:),Theta,PI,d,b,loglik_old,D,MY,k,kk);
% if ratio<1e-5
%     final = true;
% else
%     final = false;
% end