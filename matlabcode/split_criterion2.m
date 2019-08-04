function [ratio,final,Theta_new,PI_new]=split_criterion2(D,MY,Theta,PI,loglik_old,d,b)
kk=size(Theta,1);

% A=posterior_update(D,MY,Theta,PI);
% loglik_old=LogLik(D,MY,Theta,PI,A);
% [~,cluster] = max(A,[],2);
ratio=0.0;
iter=1;

for k = 1:kk
    for iter =1:50
        u=betarnd(2,2,1,4);
        u(2) = betarnd(1,1,1,1);
        [ratio_iter,PI_iter,Theta_iter] =calc_Accept_ratio(u,Theta,PI,d,b,loglik_old,D,MY,k,kk);
        %_____________________find the maximum ratio_______________________
        if ratio<ratio_iter
            PI_new = PI_iter;
            Theta_new = Theta_iter;
            ratio = ratio_iter;
            iter
        end
        iter=iter+1;
    end
end
ratio



% for k = 1:kk
% options = optimoptions('fmincon','Display','iter','Algorithm','sqp');
% [x,ratio_k(k)] = fmincon(@(u)Accept_ratio(u,PI,Theta,d,b,loglik_old,D,MY,k,kk),betarnd(2,2,1,4),[],[],[],[],[0 0 0 0],[1 1 1 1],[],options);
% u_tmp(k,:) = x;
% end
% [~,k] = min(ratio_k);
% ratio_k
% % ratio = -ratio_k(k);
% [ratio,PI_new,Theta_new] =calc_Accept_ratio(u_tmp(k,:),Theta,PI,d,b,loglik_old,D,MY,k,kk);
if ratio<1e-4 
    final = true;
else
    final = false;
end