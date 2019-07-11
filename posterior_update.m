function A=posterior_update(D,Y,Theta,PI,MU)
%B K (nbasis*K)
%phi curve_num(Nm*nbaisi)
%coef Ahat K (Curve_num*nbasis)
%zmat Curve_num*K
%narginchk(4,8);

if nargin<5
    MU=[];
end
kk=size(Theta,1);
m=size(Y,1);
A=zeros(m,kk);
% m
if ~isempty(MU)
    parfor ii=1:m
        Mle=zeros(1,kk);
%         ii
        for k=1:kk
%             k
            MY=Y(ii,:)-  MU(k,:);
            Mle(k)=-.5*MLE(Theta(k,:),D{ii},MY);
        end
        Mle=Mle-max(Mle);
        A(ii,:)=exp(Mle).*PI;
        A(ii,:)=A(ii,:)/sum(A(ii,:));
    end
else
    parfor i=1:m
        Mle=zeros(1,kk);
        for k=1:kk
            Mle(k)=-.5*MLE(Theta(k,:),D{i},Y(i,:));
        end
        Mle=Mle-max(Mle);
        A(i,:)=exp(Mle).*PI;
        A(i,:)=A(i,:)/sum(A(i,:));
    end
end


