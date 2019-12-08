function [LL,grad]=Jmle(theta,PI,A,D,Y)
%-2log
m=numel(A);

n=size(D{1},1);
LL=0;
d1=numel(theta);
grad=zeros(d1,1);
if sum(A)>10^(-100)
    for i=1:m
        [LL1,grad1]=MLE(theta,D{i},Y(i,:)); 
        LL=LL+A(i)*(LL1-2*log(PI));
        grad=grad+A(i)*grad1;
    end
else 
    for i=1:m
        [LL1,grad1]=MLE(theta,D{i},Y(i,:)); 
        LL=LL+LL1-2*log(PI);
        grad=grad+grad1;
    end
end