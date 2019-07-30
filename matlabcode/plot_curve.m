function plot_curve(T,Y,group)
% train_size=size(T,1);
% figure
set(gcf,'Position',[400 400 1000 500]);
if nargin==3
color={'r','g','b','y','m','c','k','r','g','b','y','m','c'};
kk=max(group);
for k=1:kk
    index_k=find(group==k);
    subplot(3,4,k)
    train_size_k=length(index_k);
for i=1:train_size_k
    [Ti,I]=sort(T(index_k(i),:));
    Yi=Y(index_k(i),I);
    plot(Ti,Yi,color{k});ylim([-30,30]);hold on
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
