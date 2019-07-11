function MU=meanfunc_update(D,Y,Theta,A)
kk = size(Theta,1);
[~,group]=max(A,[],2);
for k=1:kk
    index = find(group==k);
    MU(k,:)=mean(Y(index,:),1);
end