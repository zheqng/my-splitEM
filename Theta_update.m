function Theta=Theta_update(D,Y,Theta,A,B,phi)
% options2=optimset('MaxFunEvals',10^20);
options=optimoptions('fminunc','Algorithm','quasi-newton','Display','iter','UseParallel',true);
kk=size(Theta,1);
[~,cluster]=max(A,[],2);

if nargin==6
    m=size(Y,1);
    n=size(Y,2);
    MY=zeros(m,n);
    parfor i=1:m
           MY(i,:)=Y(i,:) - (phi{i}*B(:,cluster(i)))';
    end 
    parfor k=1:kk
        disp('Minimising the minus loglikelihood...')
%         [x fxp ip] = minimize_qz(Theta(k,:)','Jmle', 100, A(:,k),D, MY);
%         Theta(k,:) = x';
        [Theta(k,:),~]=fminunc(@(theta)Jmle(theta,A(:,k),D,MY),Theta(k,:),options);
    end
else
   parfor k=1:kk;
                disp('Minimising the minus loglikelihood...')
%          [x fxp ip] = minimize_qz(Theta(k,:)','Jmle', 100, A(:,k),D, Y);
%         Theta(k,:) = x';
        [Theta(k,:),~]=fminunc(@(theta)Jmle(theta,A(:,k),D,Y),Theta(k,:),options);
    end
end
%         [x fxp ip] = minimize_qz(Theta(k,:)','Jmle', 20, A(:,k),D, MY);

       