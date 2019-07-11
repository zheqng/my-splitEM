function plot_curve(T,Y,group)
% train_size=size(T,1);
% figure

if nargin==3
color={'r','g','b','y','m','c','k'};
kk=max(group);
for k=1:kk
    index_k=find(group==k);
    subplot(1,kk,k)
    train_size_k=length(index_k);
for i=1:train_size_k
    [Ti,I]=sort(T(index_k(i),:));
    Yi=Y(index_k(i),I);
    plot(Ti,Yi,color{k});hold on
end
hold off
end
else
    train_size=size(T,1);
    for i=1:train_size
        [Ti,I]=sort(T(i,:));
        Yi=Y(i,I);
        plot(Ti,Yi,'-b');hold on;
    end
    hold off;
end
% hold off