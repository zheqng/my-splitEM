function [Jsp,TTheta,TPI]=split_criterion2(D,MY,Theta,PI,d,b)
kk=size(Theta,1);
Jsp=zeros(1,kk);
TTheta=cell(1,kk);
TPI=cell(1,kk);

J_iter = [];
iter_num=100;
Theta_iter = cell(1,iter_num);
PI_iter = cell(1,iter_num);
% % % % % % % % % % % % % 
% zmat = [];
%  for ii = 1:Curve_num
%            MY{ii}=Y{ii} -  phi{ii}*B*zmat(ii,:)';
% %             MLE(k)=-.5*mle(Theta(k,:),T{i},MY);
%  end
A=posterior_update(D,MY,Theta,PI);
 loglik_old=LogLik(D,MY,Theta,PI,A);
for k=1:kk
    parfor iter= 1:iter_num
    u0=betarnd(2,2,1,4);
% u0=[0.5 0.5 0.5 0.5];
%     [u,~,exitflag]=fmincon(@(U)-Accept_ratio(U,Theta,PI,d,b,loglik_old,T,MY,k,kk),u0,[],[],[],[],[0 0 0 0],[1 1 1 1],[],options);
    [J_iter(iter),PI_iter{iter},Theta_iter{iter}] =calc_Accept_ratio(u0,Theta,PI,d,b,loglik_old,D,MY,k,kk);
    end
    [Jsp(k),ks] = max(J_iter);
    TTheta{k} = Theta_iter{ks};
    TPI{k} = PI_iter{ks};
end