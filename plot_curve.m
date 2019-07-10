function plot_curve(T,Y,group)
train_size=size(T,1);
% figure
hold on
if nargin==3
color={'r','g','b','y','m','c','k'};
for i=1:train_size
    [Ti,I]=sort(T(i,:));
    Yi=Y(i,I);
    plot(Ti,Yi,color{group(i)});
end
else
    for i=1:train_size
        [Ti,I]=sort(T(i,:));
        Yi=Y(i,I);
        plot(Ti,Yi,'-b');
    end
end
hold off