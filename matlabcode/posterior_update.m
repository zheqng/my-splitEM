function A=posterior_update(D,Y,Theta,PI)

kk=size(Theta,1);
m=size(Y,1);
A=zeros(m,kk);

for i=1:m
    Mle=zeros(1,kk);
    for k=1:kk
        Mle(k)=-.5*MLE(Theta(k,:),D{i},Y(i,:));
    end
    Mle=Mle-max(Mle);
    A(i,:)=exp(Mle).*PI;
    A(i,:)=A(i,:)/sum(A(i,:));
end
% end


