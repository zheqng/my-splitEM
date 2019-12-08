function  [Theta,PI,B]=delcomp(Theta,PI,A,B)

[~,cluster]=max(A,[],2);
kk=size(A,2);
index=1:kk;
empty_index=[];
for k=1:kk
    if length(find(unique(cluster)==k))==0
    empty_index = [empty_index k];
    end
end% ind=find(PI<threhold);
PI(empty_index)=[];
B(:,empty_index)=[];
PI=PI/sum(PI);
Theta(empty_index,:)=[];
