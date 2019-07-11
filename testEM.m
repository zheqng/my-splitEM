clear
clc
close all
load data.mat
%--------------------------------BIC------------------------------------%
t1 = clock;
bsbasis = createT1(30,2,0,9);


[Theta,PI,A,B,]=GPFRL(xdata,ydata,bsbasis);

  load data_test.mat
      YV=mix_GPFRP_qz(Theta,PI,T1_test,Y1_test,T2_test,bsbasis,B);
      
      rmse = 0;
parfor i = 1:600
rmse = rmse + sum((Y2_test{i}-YV{i}(:,1)).^2);

end

RMSE = sqrt(rmse/600/110)

 predict_show(T2_test,Y2_test,YV)

t2 = clock;
time = etime(t2,t1)
