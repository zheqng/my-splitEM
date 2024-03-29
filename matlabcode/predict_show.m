function predict_show(T2_test,Y2_test,YV)
plot_index=[600 700 800];
figure
for ii=1:3
    subplot(1,3,ii)
    [T2,I]=sort(T2_test(plot_index(ii),:));
    ylow = YV{plot_index(ii)}(I,1) - 1.96*sqrt(YV{plot_index(ii)}(I,2));
    yhigh = YV{plot_index(ii)}(I,1) + 1.96*sqrt(YV{plot_index(ii)}(I,2));
    t = T2;y = [ylow  YV{plot_index(ii)}(I,1) yhigh];
    fy=cat(2,yhigh',flipdim(ylow,1)')';
    fx=cat(2,t,flipdim(t',1)')';
    fill(fx,fy,[0.9,0.9,1.0],'EdgeColor','w') ; hold on
    plot(T2,Y2_test(plot_index(ii),I),'r+',T2,YV{plot_index(ii)}(I,1),'g');%ylim([-2 2]);
end

