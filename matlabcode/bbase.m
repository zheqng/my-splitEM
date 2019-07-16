function B=bbase(x,T1,jq)
% T1为输入的分点
% b样条基的阶数为js+1
% 输出x点处的b样条基函数的函数值组成的向量
fg=size(T1,2);
fg=fg-2*jq-1;
for i=1:fg+jq
    for j=0:jq+1
        T0(j+1)=T1(i+j);
        if T0(j+1)>=x
            cf(j+1)=(T0(j+1)-x)^jq;
        else cf(j+1)=0;
        end
    end
    %求微商
    A=[];
    A=[cf',zeros(jq+2,jq+1)];
    for j=2:jq+2
        for i1=j:jq+2
            A(i1,j)=(A(i1,j-1)-A(i1-1,j-1))/(T0(i1)-T0(i1+1-j));
        end
    end
    B(i)=(T1(i+jq+1)-T1(i))*A(jq+2,jq+2);
end
