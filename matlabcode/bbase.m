function phi=bbase(x,knots,order)

knots_num=size(knots,2);
knots_num=knots_num-2*order-1;
for i=1:knots_num+order
    for j=1:order+2
        u(j)=knots(i+j-1);
        if u(j)>=x
            N(j,1)=(u(j)-x)^order;
        else N(j,1)=0;
        end
    end

%     A=[];
%     A=[tmp',zeros(order+2,order+1)];
    for jj=2:order+2
        for ii=jj:order+2
            N(ii,jj)=(N(ii,jj-1)-N(ii-1,jj-1))/(u(ii)-u(ii+1-jj));
        end
    end
    phi(i)=(knots(i+order+1)-knots(i))*N(order+2,order+2);
end
