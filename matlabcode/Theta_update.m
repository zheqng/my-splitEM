function Theta=Theta_update(D,Y,Theta,PI,A)
% options2=optimset('MaxFunEvals',10^20);
options=optimoptions('fminunc','Algorithm','quasi-newton','Display','off','UseParallel',true);
kk=size(Theta,1);
[~,cluster]=max(A,[],2);

   parfor k=1:kk;
%                 disp('Minimising the minus loglikelihood...')
%          [x fxp ip] = minimize_qz(Theta(k,:)','Jmle', 100,PI(k), A(:,k),D, Y);
%         Theta(k,:) = x';
        [Theta(k,:),~]=fminunc(@(theta)Jmle(theta,PI(k),A(:,k),D,Y),Theta(k,:),options);
    end
end

       