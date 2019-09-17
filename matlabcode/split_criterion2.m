function [ratio,final,Theta_new,PI_new]=split_criterion2(D,MY,Theta,PI,loglik_old,d,b)
kk=size(Theta,1);

%____________________split k___________________________________%
ratio=0.0;
iter=1;
k_split =1;

for k = 1:kk
    for iter =1:50
        u=betarnd(2,2,1,4);
        u(2) = betarnd(1,1,1,1);
        [ratio_iter,PI_iter,Theta_iter,loglik_iter,add_logratio_iter] =calc_Accept_ratio(u,Theta,PI,d,b,loglik_old,D,MY,k,kk);
        %_____________________find the maximum ratio_______________________
        if ratio<ratio_iter
            PI_new = PI_iter;
            Theta_new = Theta_iter;
            ratio = ratio_iter;
            k_split = k;
            loglik_new = loglik_iter;
            add_logratio = add_logratio_iter;
        end
        if(ratio==1)
            break;
        end
    end
    if(ratio==1)
        break;
    end
end

% k_split
ratio
% [loglik_new loglik_old add_logratio]

if ratio<1e-3
    final = true;
    Theta_new = Theta;
    PI_new = PI;
else
    final = false;
end
