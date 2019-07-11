function  [Theta,PI,MU]=delcomp(Theta,PI,MU,threhold)
if nargin<3
    threhold=0.05;
end
ind=find(PI<threhold);
PI(ind)=[];
MU(ind,:)=[];
PI=PI/sum(PI);
Theta(ind,:)=[];