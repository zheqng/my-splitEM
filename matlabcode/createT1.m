function T1=createT1(knots_num,order,x_min,x_max)

T1=linspace(x_min,x_max,knots_num+1);
step=T1(2)-T1(1);
if order==0
    T2=[];
    T3=[];
elseif order>=1
    for i=1:order
        T2(i)=x_max+i*step;
        T3(order+1-i)=x_min-i*step;
    end
end
T1=[T3 T1 T2];