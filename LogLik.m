function loglik=LogLik(D,Y,Theta,PI,A,B,phi)
narginchk(5,7)
m=size(Y,1);
kk=size(Theta,1);
loglik=0;
if nargin<7
    for i=1:m
        Mle=zeros(1,kk);
        for k=1:kk
            Mle(k)=-.5*MLE(Theta(k,:),D{i},Y(i,:));
            %loglik = loglik + A(i,k)*Mle(k);
        end
        maxL=max(Mle);
        Mle=Mle-maxL;
        loglik=loglik+(log(PI*exp(Mle)')+maxL);
    end
else
    for i=1:m
        Mle=zeros(1,kk);
        for k=1:kk
            Mle(k)=-.5*MLE(Theta(k,:),D{i},Y(i,:) - (phi{i}*B(:,k))');
            %loglik = loglik+A(i,k)*Mle(k);
        end
        maxL=max(Mle);
        Mle=Mle-maxL;
        loglik=loglik+(log(PI*exp(Mle)')+maxL);
    end
end
