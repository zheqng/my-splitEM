function  [Theta,PI,B]=delcomp(Theta,PI,B,threhold)
if nargin<3
    threhold=0.05;
end
ind=find(PI<threhold);
PI(ind)=[];
B(:,ind)=[];
PI=PI/sum(PI);
Theta(ind,:)=[];