function [ratio,PI,Theta] =calc_Accept_ratio(u,Theta,PI,d,b,loglik_old,D,Y,k,kk)

               pi1=u(1)*PI(k);
        pi2=(1-u(1))*PI(k);
        pi_star = PI(k);
        
        sigma_star = Theta(k,2)^2;
        sigma1=u(2)*Theta(k,2)^2/u(1);
        sigma2=(1-u(2))*Theta(k,2)^2/(1-u(1));
        
        v_star = Theta(k,1)^2;
        v1=u(3)*Theta(k,1)^2/u(1);
        v2=(1-u(3))*Theta(k,1)^2/(1-u(1));
        
        w_star = Theta(k,3)^2;
        w1=(1-u(4))/u(3)*Theta(k,3)^2;
        w2=u(4)/(1-u(3))*Theta(k,3)^2;
        
%         PI_iter{iter}=PI;
%         Theta_iter{iter}=Theta;
        PI(k)=[];
        Theta(k,:)=[];
         PI=[ PI,[pi1,pi2]];
         Theta=[ Theta;sqrt([v1,sigma1,w1;v2,sigma2,w2])];
        
        %theta1,v;theta2,w;theta3,sigma
%         V = TTheta{k}(:,1);
%         W = TTheta{k}(:,2);
%         Sigma = TTheta{k}(:,3);
%         sort_index = 2*(Curve_num-1).*V.*exp(-W./2*eps_x^2)...
%             +Curve_num*(V + Sigma);
%         [~,I]=sort(sort_index);
%         TTheta{k} = TTheta{k}(I,:);
%         TPI{k} = TPI{k}(I);
        %            calculate logl, just calculate, not EM iteration
%         [A,LogLik]=posterior_calculate(T,Y, Theta,PI);
      A=posterior_update(D,Y,Theta,PI);
      loglik_new=LogLik(D,Y, Theta,PI,A);
        % % % % % % % % % % % % % % % %             fixed moves
        %[TTheta{k},TPI{k},TA{k},TLL{k}]=EM(T,Y,TTheta{k},TA{k});
        %             radio=1;
                    prop_ratio = d(kk+1)/b(kk);
%    _________________pi_______________________________%
            add_logratio = log(kk) - log(6) - log(u(1)*(1-u(1))) + log(pi_star);
%    __________________sigmav2_________________________%
            add_logratio = add_logratio - log(3.0) - 0.5*log(2*pi) +...
                log(sigma_star/sigma1/sigma2)...
                -(log(sigma1)+3)^2/18 - (log(sigma2)+3)^2/18+...
            (log(sigma_star)+3)^2/18-log(6.0) - log(u(2)*(1-u(2)))...
                +log(sigma_star) + 2*log(pi_star) - log(pi1*pi2);
%   __________________v__________________________%
            add_logratio = add_logratio - 0.5*log(2*pi)+log(v_star/v1/v2)...
                -(log(v1)+1)^2/2 - (log(v2)+1)^2/2 +(log(v_star)+1)^2/2+...
            -log(6) - log(u(3)*(1-u(3)))...
                +log(v_star) + 2*log(pi_star) -log(pi1*pi2);
%  ______________w__________________________________%           
            add_logratio = add_logratio +0.5*log(0.5) - 1.5*log(w1*w2/w_star)...
                -0.5*(1/w1+1/w2-1/w_star)...
                -log(6.0) - log(u(4)*(1-u(4)))...
                +log(w_star) - log( u(3)*(1-u(3)));
%             [LogLik,LL(end)];
% [loglik_new loglik_old add_logratio]
            ratio = exp(loglik_new-loglik_old + add_logratio);
            ratio = ratio*prop_ratio;
%             ratio = -ratio
%             J_split_iter(iter) = ratio;
% accept_parameter.ratio = ratio;
% accept_parameter.Theta = Theta;
% accept_parameter.PI = PI;
% theta_tmp = Theta';
% theta_tmp_1 = theta_tmp(:);
% theta_tmp_2 = theta_tmp_1';
% accept_parameter = [ratio,PI,theta_tmp_2];
% ratio = accept_parameter(1);
% PI = accept_parameter(2:kk+1);
% theta_tmp = accept_parameter(kk+2:4*kk+1);
% Theta = reshape(theta_tmp,3,kk)';