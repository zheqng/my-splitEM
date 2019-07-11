delete data.mat data_test.mat
 %_______________________generate train data_______________________________%

clear all;clc;close all;
Curve_num = 300;
Nm = 101;
[T,Y,MU,m_class]=generate(Curve_num);												      
  save data.mat 
 %_______________________generate test data_______________________________%

clear all
N=101;Curve_num = 600;
[T_test,Y_test,MU,m_class]=generate(Curve_num);
stepsize = N;               % training data size
tdsize = fix(stepsize/2);   % choose half data for training
%____________write into the traindata.dat & testdata.dat____________%
for m=1:Curve_num
    [xindtrain,xresttrain] = srswor(stepsize,40);
    %________________traindata{i}_______________%
    T1_test(m,:) = T_test(m,xindtrain);
    Y1_test(m,:) = Y_test(m,xindtrain);    
     %____________trainrestdata{i}______________%
     T2_test(m,:) = T_test(m,xresttrain);
     Y2_test(m,:) = Y_test(m,xresttrain);
end

 save data_test.mat
