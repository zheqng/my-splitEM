function T1=createT1(fg,jq,T1m,T1M)

T1=linspace(T1m,T1M,fg+1);
T1j=T1(2)-T1(1);
if jq==0
    T2=[];
    T3=[];
elseif jq>=1
    for i=1:jq
        T2(i)=T1M+i*T1j;
        T3(jq+1-i)=T1m-i*T1j;
    end
end
T1=[T3 T1 T2];