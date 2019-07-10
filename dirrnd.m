function sample=dirrnd(alpha,n)
% DIRRND Random arrays from dirichlet distribution.
if nargin<2
    n=1;
end
K=length(alpha);
sample=zeros(n,K);
for i=1:n
    s=randg(alpha);
    s=s/sum(s);
    sample(i,:)=s;
end
