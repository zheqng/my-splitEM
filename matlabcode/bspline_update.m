function B=bspline_update(D,Y,Theta,A,umat,phi)
%B K (nbasis*Curve_num)
%phi curve_num(Nm*nbaisi)
%coef Ahat K (Curve_num*nbasis)
m=size(Y,1);
n=size(D{1},1);
kk=size(Theta,1);
% B=zeros(size(phi{1},2),kk);
% I=(1e-7)*eye(size(B,1));
for k=1:kk;
    M1=0;
    M2=0;
    parfor i=1:m
        C=Theta(k,1)^2*exp(-Theta(k,2)^2*D{i}/2)+Theta(k,3)^2*eye(n);
        kron1 = kron(umat(i,:),phi{i}');
        kron2 = kron(umat(i,:)',phi{i});
        x=kron1*(C\kron2);
        M1 = M1 + A(i,k)*x;
        y=kron1*(C\Y(i,:)');
        M2 = M2+A(i,k)*y;
    end
    if rank(M1)==size(M1,1)
    B(:,k)=M1\M2;
    else
         B(:,k)=(M1+0.00000001*eye(size(M1,1)))\M2;
    end
end
