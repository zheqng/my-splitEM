function predict_show(T2_test,Y2_test,YV)
figure
subplot(1,3,1)
[T2,I]=sort(T2_test{30});
ylow = YV{30}(I,1) - 1.96*sqrt(YV{30}(I,2));
yhigh = YV{30}(I,1) + 1.96*sqrt(YV{30}(I,2));
t = T2;y = [ylow  YV{30}(I,1) yhigh];
fy=cat(2,yhigh',flipdim(ylow,1)')';
fx=cat(2,t',flipdim(t,1)')';
fill(fx,fy,[0.95,0.95,1.0],'EdgeColor','w') ; hold on
plot(T2,Y2_test{30}(I),'r+',T2,YV{30}(I,1),'g');%ylim([-2 2]);
% figure;
subplot(1,3,2)
[T2,I]=sort(T2_test{60});
ylow = YV{60}(I,1) - 1.96*sqrt(YV{60}(I,2));
yhigh = YV{60}(I,1) + 1.96*sqrt(YV{60}(I,2));
t = T2;y = [ylow  YV{60}(I,1) yhigh];
fy=cat(2,yhigh',flipdim(ylow,1)')';
fx=cat(2,t',flipdim(t,1)')';
fill(fx,fy,[0.95,0.95,1.0],'EdgeColor','w') ; hold on
plot(T2,Y2_test{60}(I),'r+',T2,YV{60}(I,1),'g');%ylim([-2 2]);
% figure;
subplot(1,3,3)
[T2,I]=sort(T2_test{90});
ylow = YV{90}(I,1) - 1.96*sqrt(YV{90}(I,2));
yhigh = YV{90}(I,1) + 1.96*sqrt(YV{90}(I,2));
t = T2;y = [ylow  YV{90}(I,1) yhigh];
fy=cat(2,yhigh',flipdim(ylow,1)')';
fx=cat(2,t',flipdim(t,1)')';
fill(fx,fy,[0.95,0.95,1.0],'EdgeColor','w') ; hold on
plot(T2,Y2_test{90}(I),'r+',T2,YV{90}(I,1),'g');%ylim([-2 2]);
